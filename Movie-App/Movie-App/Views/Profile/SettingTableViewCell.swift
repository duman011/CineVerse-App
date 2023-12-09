//
//  SettingTableViewCell.swift
//  Movie-App
//
//  Created by Yaşar Duman on 3.11.2023.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "SettingTableViewCell"
    
    // MARK: - UI Elements
    private lazy var iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = MovieColor.playButonBG
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        
        iconContainer.anchor(leading: leadingAnchor,
                             padding: .init(leading: 15),
                             size: .init(width: size, height: size))
        iconContainer.centerYInSuperview()
        
        iconImageView.anchor(size: .init(width: imageSize, height: imageSize))
        iconImageView.centerXInSuperview()
        iconImageView.centerYInSuperview()
        
        label.anchor(leading: iconContainer.trailingAnchor,
                     padding: .init(leading: 20))
        label.centerYInSuperview()
    }
    
    // MARK: - Prepare For Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    
    // MARK: - Configure Cell
    func configure(with model: SettingsOption){
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgrondColor
    }   
}
