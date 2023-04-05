//
//  FilterView.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 05.04.2023.
//

import UIKit

struct FilterItem {
    var title: String
    var selected: Bool = false
}

class FilterView: UICollectionReusableView {
    
    private var filterItems: [FilterItem] = [.init(title: "Пицца", selected: true),
                                             .init(title: "Комбо"),
                                             .init(title: "Десерты"),
                                             .init(title: "Напитки"),
                                             .init(title: "Акции")]
    
    private lazy var filterCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 88, height: 32)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "filterCell")
        filterCollectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)//UIColor(hexString: "E5E5E5")
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        return filterCollectionView
    }()
    
    static let reuseIdentifier = "title-supplementary-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(filterCollectionView)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterCollectionView.topAnchor.constraint(equalTo: topAnchor),
            filterCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension FilterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(filterItem: filterItems[indexPath.row])
        cell.corneredRadius()
        cell.layer.borderColor = UIColor(hexString: "FD3A69", alpha: 0.2).cgColor
        cell.layer.borderWidth = 1.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (index, _) in filterItems.enumerated() {
            if index == indexPath.row {
                filterItems[index].selected = true
            } else {
                filterItems[index].selected = false
            }
        }
        filterCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        collectionView.reloadData()
    }
}
