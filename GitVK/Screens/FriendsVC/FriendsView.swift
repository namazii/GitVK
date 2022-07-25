//
//  FriendsVIew.swift
//  GitVK
//
//  Created by Назар Ткаченко on 02.07.2022.
//

import UIKit

final class FriendsView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        
        return searchBar
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        
        return refreshControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    //MARK: - View Hierarchy
    private func setupViews() {
        self.addSubview(tableView)
        
        
        self.backgroundColor = .systemBackground
        
        tableView.pinEdgesToSuperView()
        tableView.refreshControl = refreshControl
        
    }
    
    //MARK: - Actions
    @objc private func pullToRefreshAction() {
        refreshControl.beginRefreshing()
        
        
        
        refreshControl.endRefreshing()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
