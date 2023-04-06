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
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24.0),
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
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: spacing * 2),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.0),
            ])
        return titleLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.textColor = .placeholderText
        descriptionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing / 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            ])
        return descriptionLabel
    }()
    
    private lazy var priceButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(priceAction), for: .touchUpInside)
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: spacing / 2),
            button.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 87.0),
            button.heightAnchor.constraint(equalToConstant: 32.0),
        ])
        
        button.layer.borderColor = UIColor(hexString: "FD3A69").cgColor
        button.layer.borderWidth = 1.0
        button.corneredRadius(radius: 6.0)
        button.setTitleColor(UIColor(hexString: "FD3A69"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        return button
    }()
    
    func setupData(item: MenuController.MenuItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        if let url = URL(string: item.imageUrl) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "No-Image-Placeholder"))
        }
        priceButton.setTitle("от \(item.price) $", for: .normal)
    }
    
    @objc
    private func priceAction() {
        print("price")
    }
}
