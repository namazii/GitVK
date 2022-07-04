//
//  MainTabVC.swift
//  GitVK
//
//  Created by Назар Ткаченко on 22.06.2022.
//

import UIKit

class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let friendsVC = FriendsVC()
        let friendsTabBarItem = UITabBarItem()
        friendsTabBarItem.title = "Друзья"
        friendsTabBarItem.image = UIImage(systemName: "person")
        friendsVC.tabBarItem = friendsTabBarItem
        
        let groupsVC = GroupsVC()
        let groupsTabBarItem = UITabBarItem()
        groupsTabBarItem.title = "Группы"
        groupsTabBarItem.image = UIImage(systemName: "person.3")
        groupsVC.tabBarItem = groupsTabBarItem
        
        let photosVC = PhotosVC()
        let photosTabBarItem = UITabBarItem()
        photosTabBarItem.title = "Галерея"
        photosTabBarItem.image = UIImage(systemName: "photo")
        photosVC.tabBarItem = photosTabBarItem
        
        
        let navigationFriendsVC = UINavigationController(rootViewController: friendsVC)
        let navigationGroupsVC = UINavigationController(rootViewController: groupsVC)
        let navigationPhotosVC = UINavigationController(rootViewController: photosVC)
        
        // добавление 2 контролеров в таб бар
        self.viewControllers = [ navigationFriendsVC, navigationGroupsVC, navigationPhotosVC ]
    }
}
