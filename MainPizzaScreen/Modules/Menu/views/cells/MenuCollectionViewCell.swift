/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Cell for displaying a video
*/

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "menu-cell-reuse-identifier"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let categoryLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension MenuCollectionViewCell {
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)

        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        
        categoryLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        categoryLabel.adjustsFontForContentSizeCategory = true
        categoryLabel.textColor = .placeholderText
        categoryLabel.numberOfLines = 0

        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = UIColor.red
        
        let spacing = CGFloat(16.0)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 132.0),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -spacing),

            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: spacing),
            categoryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ])
    }
}
