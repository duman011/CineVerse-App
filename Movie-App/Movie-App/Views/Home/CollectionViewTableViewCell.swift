//
//  CollectionViewTableViewCell.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: MoviePreviewViewModel, movieModel: Movie)
}

class CollectionViewTableViewCell: UITableViewCell {
    weak var delegate: CollectionViewTableViewCellDelegate?
    static let identifier = "CollectionViewTableViewCell"
    private var movies: [Movie] = [Movie]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .tertiarySystemGroupedBackground
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with movie: [Movie]) {
        self.movies = movie
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
   
       if let model: Movie = movies[indexPath.row] as? Movie {
           cell.configure(with: model)
       } else {
          return UICollectionViewCell()
       }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        guard let movieName = movie.original_title ?? movie.original_name else {
            return
        }
        

        Task{
            do {
                let moviePreviewModel  = try await APICaller.shared.getMovie(with: movieName + " trailer")
                let movie = self.movies[indexPath.row]
                guard let movieOverview = movie.overview else {
                    return
                }
             
               
                let viewModel = MoviePreviewViewModel(title: movieName, youtubeView: moviePreviewModel, movieOverview: movieOverview, release_date: movie.release_date ?? movie.first_air_date)
                self.delegate?.collectionViewTableViewCellDidTapCell(self, viewModel: viewModel, movieModel: movie)
               
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                   
                }
                
            }
        }
        
        
        
    }
}
