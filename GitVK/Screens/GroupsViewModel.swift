//
//  GroupsViewModel.swift
//  GitVK
//
//  Created by Назар Ткаченко on 02.07.2022.
//

import Foundation

class GroupsViewModel {
    
    var groupsAPI = GroupsAPI()
    
    var groups: [Group] = []
    
    var isGroupsLoading = false
    
    func fetchGroups(offset: Int = 0, completion: @escaping () -> ()) {
        groupsAPI.fetchGroups(offset: offset) { [weak self] groups  in
            guard let self = self else { return }
            
            self.isGroupsLoading = false
            
            if offset == 0 {
                self.groups = groups
                completion()
//                self.tableView.reloadData()
                return
            }
            
            self.groups.append(contentsOf: groups)
            completion()
//            self.tableView.reloadData()
        }
    }
}
