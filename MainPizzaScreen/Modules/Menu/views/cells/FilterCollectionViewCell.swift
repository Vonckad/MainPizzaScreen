//
//  FilterCollectionViewCell.swift
//  Sports map
//
//  Created by Vlad Ralovich on 08.03.2023.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4.0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.0)
        ])
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let selectedBackgroundColor = UIColor(hexString: "FD3A69", alpha: 0.2)
    private let redTextColor = UIColor(hexString: "FD3A69")
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.contentView.backgroundColor = selectedBackgroundColor
                titleLabel.textColor = redTextColor
            } else {
                self.contentView.backgroundColor = .clear
                titleLabel.textColor = selectedBackgroundColor
            }
        }
    }
    
    //MARK: -
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        titleLabel.textColor = selectedBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(filterItem: FilterItem) {
        titleLabel.text = filterItem.title
    }
}
