//
//  FriendsVC.swift
//  GitVK
//
//  Created by Назар Ткаченко on 21.06.2022.
//

import UIKit

struct Friend {
    var name = "test user"
    var image = UIImage(named: "avatar")
}

final class FriendsVC: UIViewController {
    
    var friends: [Friend] = [Friend()]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        view?.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        
        tableView.pinEdgesToSuperView()
        
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

