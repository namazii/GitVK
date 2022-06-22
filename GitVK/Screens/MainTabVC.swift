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
        
        let navigationFriendsVC = UINavigationController(rootViewController: friendsVC)
        let navigationGroupsVC = UINavigationController(rootViewController: groupsVC)
        
        // добавление 2 контролеров в таб бар
        self.viewControllers = [navigationFriendsVC, navigationGroupsVC]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
