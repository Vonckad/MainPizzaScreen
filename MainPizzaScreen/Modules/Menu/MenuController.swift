/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Controller object that manages the videos and video collection for the sample app
*/

import Foundation

class MenuController {

    fileprivate var _menuItems = [Menu]()
    fileprivate var _advertisements = [Advertisement]()
    
    struct MenuItem: Hashable {
        let title: String
        let category: String
        let imageUrl: String
        let description: String
        let price: Float
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    struct Advertisement: Hashable {
        let imageName: String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    struct Menu: Hashable {
        let items: [MenuItem]
        
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    func addMenuItems(menu: Menu) {
        _menuItems.append(menu)
    }

    var menuItems: [Menu] {
        return _menuItems
    }
    
    var advertisements: [Advertisement] {
        return _advertisements
    }

    init() {
        generateAdvertisement()
    }
}

extension MenuController {
    private func generateAdvertisement() {
        _advertisements = [
            Advertisement(imageName: "Rectangle1"),
            Advertisement(imageName: "Rectangle1"),
            Advertisement(imageName: "Rectangle1"),
            Advertisement(imageName: "Rectangle1"),
        ]
    }
}
