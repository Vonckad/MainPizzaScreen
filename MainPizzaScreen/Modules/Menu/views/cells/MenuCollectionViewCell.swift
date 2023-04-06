/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Cell for displaying a video
*/

import UIKit
import SDWebImage

class MenuCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "menu-cell-reuse-identifier"
    private let spacing = CGFloat(16.0)
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 132.0),
        ])
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        
        let spacing = CGFloat(16.0)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),
            ])
        return titleLabel
    }()
    
    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(categoryLabel)
        categoryLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        categoryLabel.adjustsFontForContentSizeCategory = true
        categoryLabel.textColor = .placeholderText
        categoryLabel.numberOfLines = 0
        
        let spacing = CGFloat(16.0)
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: spacing),
            categoryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ])
        return categoryLabel
    }()
    
    func setupData(item: MenuController.MenuItem) {
        titleLabel.text = item.title
        categoryLabel.text = item.category
        if let url = URL(string: item.imageUrl) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "No-Image-Placeholder"))
        }
    }
}
