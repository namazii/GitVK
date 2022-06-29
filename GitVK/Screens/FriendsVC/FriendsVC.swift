//
//  FriendsVC.swift
//  GitVK
//
//  Created by Назар Ткаченко on 21.06.2022.
//

import UIKit

final class FriendsVC: UIViewController {
    
    var friendsAPI = FriendsAPI()
    
    var friends: [Friend] = []
    
    var isFriendsLoading = false
    
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        
        return refreshControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchFriends()
    }
    
    //MARK: - Private Methods
    
    private func fetchFriends(offset: Int = 0) {
        friendsAPI.fetchFriends(offset: offset) { [weak self] friends in
            
            guard let self = self else { return }
            
            self.isFriendsLoading = false
            
            if offset == 0 {
                self.friends = friends
                self.tableView.reloadData()
                return
            }
            
            self.friends.append(contentsOf: friends)
            self.tableView.reloadData()
        }
    }
    
    private func setupViews() {
        view?.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        
        tableView.pinEdgesToSuperView()
        tableView.refreshControl = refreshControl
        
    }
    
    //MARK: - Actions
    @objc private func pullToRefreshAction() {
        refreshControl.beginRefreshing()
        
        fetchFriends()
        
        refreshControl.endRefreshing()
    }
}

//MARK: - Extension
extension FriendsVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        print(indexPaths)
        
        let maxRow = indexPaths.map { $0.last ?? 0 }.max() ?? 0
        
        print(maxRow)
        
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

