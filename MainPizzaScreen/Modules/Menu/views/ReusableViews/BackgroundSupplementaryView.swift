//
//  BackgroundSupplementaryView.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 05.04.2023.
//

import UIKit

final class BackgroundSupplementaryView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        clipsToBounds = true
        corneredRadius(radius: 22.0)
        layer.maskedCorners = [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

