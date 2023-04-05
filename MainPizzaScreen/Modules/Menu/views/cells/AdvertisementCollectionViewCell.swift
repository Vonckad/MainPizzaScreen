//
//  AdvertisementCollectionViewCell.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 05.04.2023.
//

import UIKit

class AdvertisementCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "advertisement-cell-reuse-identifier"
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
