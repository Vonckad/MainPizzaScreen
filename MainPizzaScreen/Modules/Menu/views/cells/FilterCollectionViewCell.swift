//
//  FilterCollectionViewCell.swift
//  Sports map
//
//  Created by Vlad Ralovich on 08.03.2023.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let selectedBackgroundColor = UIColor(hexString: "FD3A69", alpha: 0.2)
    private let redTextColor = UIColor(hexString: "FD3A69")
    
    private enum CellState {
        case select
        case unSelect
    }

    private var state: CellState = .unSelect {
        didSet {
            switch state {
            case .select:
                backgroundColor = selectedBackgroundColor
                titleLabel.textColor = redTextColor
            case .unSelect:
                backgroundColor = .clear
                titleLabel.textColor = selectedBackgroundColor
            }
        }
    }
    
    func configureCell(filterItem: FilterItem) {
        titleLabel.text = filterItem.title
        state = filterItem.selected ? .select : .unSelect
    }
}
