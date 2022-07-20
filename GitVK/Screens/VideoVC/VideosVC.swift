//
//  VideosVC.swift
//  GitVK
//
//  Created by Назар Ткаченко on 16.07.2022.
//

import UIKit
import AVKit

class VideosVC: UIViewController {
    
    //MARK: Properties
    var videos: [Video] = []
    var videosAPI = VideosAPI()
    var isVideosLoading = false
    
    //MARK: - lazy var
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.identifier)
        
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        fetchVideos(offset: 0)
    }
    
    //MARK: PrivateMethods
    private func setupViews() {
        view.addSubview(tableView)
        
        view.backgroundColor = .systemBackground
        
        tableView.pinEdgesToSuperView()
    }

    private func fetchVideos(offset: Int = 0) {
        Task {
            do {
                let videos = try await videosAPI.fetchVideos(offset: videos.count)
                
                self.videos = videos
                self.tableView.reloadData()
                
                return
            } catch {
                
            }
        }
    }

}
//MARK: Extensions
extension VideosVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell else { return UITableViewCell() }
        
        let video = self.videos[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(video)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let video = videos[indexPath.row]
        
        guard let videoURL = URL(string: video.player ?? "") else { return }
        let player = AVPlayer(url: videoURL) //контроллер воспроизведения видеофайла
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        present(playerVC, animated: true) {
            player.play()
        }
    }
}
