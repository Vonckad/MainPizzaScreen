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
    
    var filterItems: [FilterItem] = [] {
        didSet {
            filterCollectionView.reloadData()
        }
    }
    
    private lazy var filterCollectionView: UICollectionView = {
        let filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "filterCell")
        filterCollectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        addSubview(filterCollectionView)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterCollectionView.topAnchor.constraint(equalTo: topAnchor),
            filterCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return filterCollectionView
    }()
    
    static let reuseIdentifier = "title-supplementary-reuse-identifier"
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 32)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.estimatedItemSize = CGSize(width: 200, height: 40)
        return flowLayout
    }
}

extension FilterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(filterItem: filterItems[indexPath.row])
        cell.corneredRadius(radius: 13)
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
