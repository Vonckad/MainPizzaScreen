//
//  AdvertisementCollectionViewCell.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 05.04.2023.
//

import UIKit

class AdvertisementCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "advertisement-cell-reuse-identifier"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        return imageView
    }()
    
    // MARK: - Public
    func setupImage(image: UIImage?) {
        guard let image = image else { return }
        imageView.image = image
    }
}
