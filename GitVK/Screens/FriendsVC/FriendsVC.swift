//
//  FriendsVC.swift
//  GitVK
//
//  Created by Назар Ткаченко on 21.06.2022.
//

import UIKit

final class FriendsVC: UIViewController {
    
    var rootView: FriendsView { return self.view as! FriendsView }
    
    var friendsAPI = FriendsAPI()
    
    var friends: [Friend] = []
    
    var isFriendsLoading = false

    //MARK: - Lifecycle
    override func loadView() {
        self.view = FriendsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFriends()
        setupDelegates()
    }
    
    //MARK: - Private Methods
    
    private func fetchFriends(offset: Int = 0) {
        friendsAPI.fetchFriends(offset: offset) { [weak self] friends in
            
            guard let self = self else { return }
            
            self.isFriendsLoading = false
            
            if offset == 0 {
                self.friends = friends
                self.rootView.tableView.reloadData()
                return
            }
            
            self.friends.append(contentsOf: friends)
            self.rootView.tableView.reloadData()
        }
    }
    
    private func setupDelegates() {
        
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.prefetchDataSource = self
    }
}

//MARK: - Extension
extension FriendsVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
//        print(indexPaths)
        
        let maxRow = indexPaths.map { $0.last ?? 0 }.max() ?? 0
        
//        print(maxRow)
        
        if maxRow > friends.count - 5, isFriendsLoading == false {
            
            isFriendsLoading = true
            
            fetchFriends(offset: friends.count)
        }
    }
}

extension FriendsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as? FriendCell else { return UITableViewCell() }
        
        let friend = self.friends[indexPath.row]
        
        cell.configure(friend)
//        cell.textLabel?.text = friend.name
        
        return cell
    }
    
    
}

extension FriendsVC: UITableViewDelegate {
    
}

