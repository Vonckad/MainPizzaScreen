//
//  FilterView.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 05.04.2023.
//

import UIKit

protocol FilterViewDelegate {
    func didSelectFilter(filterItem: String)
}

class FilterView: UICollectionReusableView {
    
    static let reuseIdentifier = "title-supplementary-reuse-identifier"
    
    var filterItems: [String] = [] {
        didSet {
            filterCollectionView.reloadData()
            filterCollectionView.selectItem(at: .init(row: 0, section: 0), animated: false, scrollPosition: .left)
        }
    }
    
    var delegate: FilterViewDelegate?
    
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
    
    //MARK: - Private
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 32)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.estimatedItemSize = CGSize(width: 200, height: 40)
        return flowLayout
    }
    
    //MARK: - Public
    func selectedFilterItem() -> String? {
        if let index = filterCollectionView.indexPathsForSelectedItems?.sorted().first?.row {
            return filterItems[index]
        } else {
            return nil
        }
    }
    
    func selectItem(item: String?) {
        let index = filterItems.firstIndex(where: {$0 == item})
        filterCollectionView.selectItem(at: .init(row: index!, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
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
        delegate?.didSelectFilter(filterItem: filterItems[indexPath.row])
        filterCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}
