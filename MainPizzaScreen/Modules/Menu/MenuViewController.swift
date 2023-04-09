//
//  MenuViewController.swift
//  MainPizzaScreen
//
//  Created by Vlad Ralovich on 03.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MenuDisplayLogic: AnyObject
{
    func displayProducts(viewModel: Menu.Facestore.ViewModel.viewModelData)
}

class MenuViewController: UIViewController, MenuDisplayLogic
{
    
    enum Section: Int, Hashable, CaseIterable, CustomStringConvertible {
        case advertisement, menu
        
        var description: String {
            switch self {
            case .advertisement: return "Advertisement"
            case .menu: return "Menu"
            }
        }
    }
    
    private var isScrollNow = false
    
    private lazy var menuCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        return collectionView
    }()
    
    private let filterHeaderRegistration = UICollectionView.SupplementaryRegistration
    <FilterView>(elementKind: "sectionHeaderElementKind") {
        (supplementaryView, string, indexPath) in
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, AnyHashable>! = nil
    
  var interactor: MenuBusinessLogic?
  var router: (NSObjectProtocol & MenuRoutingLogic & MenuDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = MenuInteractor()
    let presenter = MenuPresenter()
    let router = MenuRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
      configureDataSource()
      requestProducts()
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(white: 0.95, alpha: 1)
        tabBarController?.tabBar.backgroundColor = .white
    }
  
  // MARK: Do something
  func requestProducts()
  {
      interactor?.doInteractor(request: .getProducts)
  }
  
    func displayProducts(viewModel: Menu.Facestore.ViewModel.viewModelData)
  {
      switch viewModel {
      case .products(let menuController, let category):
          updateCurrentSnapshot(menuController: menuController)
          guard let filterView = menuCollectionView.visibleSupplementaryViews(ofKind: "sectionHeaderElementKind").first as? FilterView else { return }
          filterView.filterItems = category
          filterView.delegate = self
      }
  }
}

//MARK: - UICollectionViewDelegate
extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("section = \(indexPath.section), row = \(indexPath.row)")
    }
}

//MARK: - UICollectionViewLayout
extension MenuViewController {
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .advertisement {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(100.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                       heightDimension: .absolute(123.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets.leading = 10
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 20)
                
            } else if sectionKind != .advertisement {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(230.0))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
                section.interGroupSpacing = 1
                
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(60)),
                    elementKind: "sectionHeaderElementKind",
                    alignment: .top)
                sectionHeader.pinToVisibleBounds = true
                section.boundarySupplementaryItems = [sectionHeader]
            } else {
                fatalError("unknown section")
            }
            
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider,
                                                         configuration: config)
        return layout
    }
}

//MARK: - dataSource, currentSnapshot
extension MenuViewController {
    private func createAdvertisementCellRegistration() -> UICollectionView.CellRegistration<AdvertisementCollectionViewCell, MenuController.Advertisement> {
        return UICollectionView.CellRegistration<AdvertisementCollectionViewCell, MenuController.Advertisement> { (cell, indexPath, advertisement) in
            cell.imageView.image = UIImage(named: advertisement.imageName)
        }
    }
    
    private func createMenuCellRegistration() -> UICollectionView.CellRegistration<MenuCollectionViewCell, MenuController.MenuItem> {
        return UICollectionView.CellRegistration<MenuCollectionViewCell, MenuController.MenuItem> { (cell, indexPath, menuItem) in
            
            if indexPath == .init(row: 0, section: 1) {
                cell.corneredRadius(radius: 22.0)
                cell.layer.maskedCorners = [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner]
            }
            cell.clipsToBounds = true
            cell.backgroundColor = .white
            cell.setupData(item: menuItem)
        }
    }
    
    private func configureDataSource() {
        let advertisementCellRegistration = createAdvertisementCellRegistration()
        let menuCellRegistration = createMenuCellRegistration()
        
        dataSource = UICollectionViewDiffableDataSource
        <Section, AnyHashable>(collectionView: menuCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            
            switch section {
            case .advertisement:
                return collectionView.dequeueConfiguredReusableCell(using: advertisementCellRegistration, for: indexPath, item: item as? MenuController.Advertisement)
            case .menu:
                return collectionView.dequeueConfiguredReusableCell(using: menuCellRegistration, for: indexPath, item: item as? MenuController.MenuItem)
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.menuCollectionView.dequeueConfiguredReusableSupplementary(using: self.filterHeaderRegistration, for: index)
        }
    }
    
    private func updateCurrentSnapshot(menuController: MenuController) {
        currentSnapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        Section.allCases.forEach { (sectionKind) in
            switch sectionKind {
            case .advertisement:
                currentSnapshot.appendSections([.advertisement])
                currentSnapshot.appendItems(menuController.advertisements)
            case .menu:
                currentSnapshot.appendSections([.menu])
                for menuItem in menuController.menuItems {
                    currentSnapshot.appendItems(menuItem.items)
                }
            }
        }
        
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
}

//MARK: - ViewScroll
extension MenuViewController {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isScrollNow = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let filterView = menuCollectionView.visibleSupplementaryViews(ofKind: "sectionHeaderElementKind").first as? FilterView else { return }
        
        if scrollView === menuCollectionView && !isScrollNow {
            
            guard let selectedFilter = filterView.selectedFilterItem() else {
                print("Error ger selected filter")
                return
            }
            
            guard let topSectionIndex = self.menuCollectionView.indexPathsForVisibleItems.filter({$0.section == 1}).sorted().map({ $0.row + 1}).first else {
                print("Error get topSectionIndex")
                return
            }
            
            guard let items = dataSource.snapshot(for: Section.menu).items as? [MenuController.MenuItem] else {
                print("Error get items")
                return
            }

            if selectedFilter.title != items[topSectionIndex].category {
                filterView.selectItem(item: .init(title: items[topSectionIndex].category))
            }
        }
    }
}

//MARK: - FilterViewDelegate
extension MenuViewController: FilterViewDelegate {
    func didSelectFilter(filterItem: FilterItem) {
        
        isScrollNow = true
        
        guard let items = dataSource.snapshot(for: Section.menu).items as? [MenuController.MenuItem] else {
            print("Error get items")
            return
        }
        
        guard let item = items.first(where: {$0.category == filterItem.title}) else {
            print("Error get 1 item")
            return
        }
        
        guard let index = dataSource.indexPath(for: item) else {
            print("Error get index")
            return
        }
        
        menuCollectionView.scrollToItem(at: index, at: .top, animated: true)
    }
}
