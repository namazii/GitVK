//
//  NewsFeed.swift
//  GitVK
//
//  Created by Назар Ткаченко on 09.07.2022.
//

import Foundation
import UIKit

enum PostCellType: Int, CaseIterable {
    
    case author = 0
    case text = 1
    case photos = 2
    case likes = 3
}

final class NewsFeedVC: UIViewController {
    
    //MARK: Properties
    var posts: [PostCellModel] = []
    //var profiles: [Profile] = []
    //var newsGroups: [NewsGroup] = []
    
    let newsFeedAPI = NewsFeedAPI()
    
    //способ создания UI через клоужер
    
    //MARK: - lazy var
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(PostTextCell.self, forCellReuseIdentifier: PostTextCell.identifier)
        tableView.register(PostAuthorCell.self, forCellReuseIdentifier: PostAuthorCell.identifier)
        tableView.register(PostPhotoCell.self, forCellReuseIdentifier: PostPhotoCell.identifier)
        tableView.register(PostLikesCell.self, forCellReuseIdentifier: PostLikesCell.identifier)
        
        tableView.delegate = self // отвечает за данные
        tableView.dataSource = self// отвечает за поведение
        
        tableView.separatorColor = .clear

        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        fetchNewsFeed()
    }
    
    //MARK: - PrivateMethods
    private func fetchNewsFeed() {
        Task {
            do {
                let postModels = try await newsFeedAPI.fetchNewsFeed(offset: 0)
                self.posts = postModels
                //self.profiles = profiles
                //self.newsGroups = groups
                self.tableView.reloadData()
                
            } catch {
                
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        
        view.backgroundColor = .systemGray
        
        tableView.pinEdgesToSuperView()
       
    }
    //MARK: - Actions
    
}
extension NewsFeedVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension NewsFeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostCellType.allCases.count
    }
    //1 секция = 1 новости
    //секция = контейнер для ячеек
    //новость : несколько частей где часть новости -> 1 ячейка
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellType = PostCellType(rawValue: indexPath.row)
        let cellModel = posts[indexPath.section]
        
        switch cellType {
        case .text:
            if cellModel.text.isEmpty {
                return 0
            }
        case .photos:
            if cellModel.photoUrl.isEmpty {
                return 0
            }
        default: return UITableView.automaticDimension
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellType = PostCellType(rawValue: indexPath.row)
        let cellModel = posts[indexPath.section]
        
        #warning("рефакторинг сделать 1-2 return")
        //let cellContainer: UITableViewCell?
        
        switch cellType {
            
        case .author:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostAuthorCell.identifier, for: indexPath) as? PostAuthorCell else  { return UITableViewCell() }
            cell.configure(cellModel)
            return cell
            
        case .text:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTextCell.identifier, for: indexPath) as? PostTextCell else  { return UITableViewCell() }
            cell.configure(cellModel)
            return cell
            
        case .photos:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostPhotoCell.identifier, for: indexPath) as? PostPhotoCell else  { return UITableViewCell() }
            cell.configure(cellModel)
            return cell
            
        case .likes:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostLikesCell.identifier, for: indexPath) as? PostLikesCell else  { return UITableViewCell() }
            cell.configure(cellModel)
            return cell

        default: return UITableViewCell()
        }
        //return  UITableViewCell()
    }
    
    private func vkResponseNews() {
        
        
        // конструктор URL - URLComponents ( ascii, persent encoding )
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userId)"),
            URLQueryItem(name: "filters", value: "post, photo, friend, wall_photo"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else { return }
            
        print(url)
    }
}

