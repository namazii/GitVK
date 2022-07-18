//
//  GroupsVC.swift
//  GitVK
//
//  Created by Назар Ткаченко on 22.06.2022.
//

import UIKit

class GroupsVC: UIViewController {
    
    var viewModel = GroupsViewModel()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.identifier)
        
        return tableView
    }()

    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        
        return refreshControl
    }()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchGroups(offset: 0) {
        self.tableView.reloadData()
        }
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        
        tableView.pinEdgesToSuperView()
        tableView.refreshControl = refreshControl
        
    }
    
   
    
    //MARK: - Actions
    @objc private func pullToRefreshAction() {
        refreshControl.beginRefreshing()
        
        
        
        refreshControl.endRefreshing()
    }
    
}

extension GroupsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as? GroupCell else { return UITableViewCell() }
        
        let group = viewModel.groups[indexPath.row]
        
        cell.configure(group)
//        cell.textLabel?.text = friend.name
        
        return cell
    }
    
    
}
extension GroupsVC: UITableViewDelegate {
    
}
extension GroupsVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
//        print(indexPaths)
        
        let maxRow = indexPaths.map { $0.last ?? 0 }.max() ?? 0
        
//        print(maxRow)
        
        if maxRow > viewModel.groups.count - 5, viewModel.isGroupsLoading == false {
            
            viewModel.isGroupsLoading = true
            
            viewModel.fetchGroups(offset: viewModel.groups.count) {
                tableView.reloadData()
            }
        }
    }
}
