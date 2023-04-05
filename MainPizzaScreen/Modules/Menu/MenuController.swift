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
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }
    
    struct Advertisement: Hashable {
        let title: String
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    struct Menu: Hashable {
        let title: String
        let menuItems: [MenuItem]
        
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    var menuItems: [Menu] {
        return _menuItems
    }
    
    var advertisements: [Advertisement] {
        return _advertisements
    }

    init() {
        generateMenuItem()
        generateAdvertisement()
    }
}

extension MenuController {
    func generateMenuItem() {
        _menuItems = [
            Menu(title: "App Store Connect",
                 menuItems: [MenuItem(title: "App Store Connect Basics", category: "App Store Connect"),
                             MenuItem(title: "App Analytics Retention", category: "App Store Connect"),
                             MenuItem(title: "App Analytics Metrics", category: "App Store Connect"),
                             MenuItem(title: "App Analytics Overview", category: "App Store Connect"),
                             MenuItem(title: "TestFlight", category: "App Store Connect"),
                             
                             MenuItem(title: "What's new in watchOS", category: "Conference 2018"),
                             MenuItem(title: "Updating for Apple Watch Series 3", category: "Tech Talks"),
                             MenuItem(title: "Planning a Great Apple Watch Experience",
                                      category: "Conference 2017"),
                             MenuItem(title: "News Ways to Work with Workouts", category: "Conference 2018"),
                             MenuItem(title: "Siri Shortcuts on the Siri Watch Face",
                                      category: "Conference 2018"),
                             MenuItem(title: "Creating Audio Apps for watchOS", category: "Conference 2018"),
                             MenuItem(title: "Designing Notifications", category: "Conference 2018"),
                             MenuItem(title: "Introduction to Siri Shortcuts", category: "Conference 2018"),
                             MenuItem(title: "Building for Voice with Siri Shortcuts",
                                      category: "Conference 2018"),
                             MenuItem(title: "What's New in SiriKit", category: "Conference 2017"),
                             MenuItem(title: "Making Great SiriKit Experiences", category: "Conference 2017"),
                             MenuItem(title: "Increase Usage of You App With Proactive Suggestions",
                                      category: "Conference 2018")
                            ])]
    }
}


extension MenuController {
    func generateAdvertisement() {
        _advertisements = [
            Advertisement(title: "Rectangle1"),
            Advertisement(title: "Rectangle1"),
            Advertisement(title: "Rectangle1"),
            Advertisement(title: "Rectangle1"),
        ]
    }
}
