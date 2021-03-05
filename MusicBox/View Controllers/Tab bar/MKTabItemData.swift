//
//  MKTabBarItemData.swift
//  MusicBox
//
//  Created by Ko Kyaw on 26/02/2021.
//

import UIKit

enum MKTabItemData: CaseIterable {
    
    case home, search, addNew, notification, profile
    
    var icon: UIImage {
        get {
            switch self {
            case .search:
                return UIImage(systemName: "magnifyingglass")!
            case .addNew:
                return UIImage(systemName: "plus")!
            case .notification:
                return UIImage(systemName: "bell")!
            case .profile:
                return UIImage(systemName: "person")!
            default:
                return UIImage(systemName: "house")!
            }
        }
    }
    
    var iconSelected: UIImage {
        get {
            switch self {
            case .search:
                return UIImage(systemName: "magnifyingglass")!
            case .addNew:
                return UIImage(systemName: "plus")!
            case .notification:
                return UIImage(systemName: "bell.fill")!
            case .profile:
                return UIImage(systemName: "person.fill")!
            default:
                return UIImage(systemName: "house.fill")!
            }
        }
    }
    
    var viewController: UIViewController {
        get {
            switch self {
            case .search:
                return SearchVC()
            case .addNew:
                return AddNewVC()
            case .notification:
                return NotificationVC()
            case .profile:
                return ProfileVC()
            default:
                let homeVC = UINavigationController(rootViewController: HomeVC())
                homeVC.navigationBar.prefersLargeTitles = true
                return homeVC
            }
        }
    }
}
