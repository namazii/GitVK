//
//  VideosVC.swift
//  GitVK
//
//  Created by Назар Ткаченко on 16.07.2022.
//

import UIKit
import AVKit
import SafariServices
import WebKit

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
        
//        guard let url = URL(string: "https://file-examples.com/storage/fefbfe84f862d721699d168/2017/04/file_example_MP4_480_1_5MG.mp4") else { return }
        
        
        //guard let url = URL(string: "https://cs535321.vk.me/u14818493/videos/3c213c1ad1.240.mp4?extra=IGU4-xUtkuePl3KO4XSss0M9fyv4eQ5jcJtaYA4ZSITqo7uE4wqNthricD3kQdjwJLgWp5D7-rENdsZN8gM3BaE94rAw7uM") else { return }"
        
//        let player = AVPlayer(url: url) //контроллер воспроизведения видеофайла
//        let playerVC = AVPlayerViewController()
//        playerVC.player = player
//
//        present(playerVC, animated: true) {
//            player.play()
//        }
        

        
        //Загрузка видео через UIApplication
        //UIApplication.shared.open(videoURL, options: [:], completionHandler: nil)
        
        //Загрузка видео через Safari Browser
        #warning("Поискать как запускать видео сразу")
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let safariVC = SFSafariViewController(url: videoURL, configuration: config)
        present(safariVC, animated: true)
        
//        //Загрузка видео через WKWebView
//        let webView = WKWebView(frame: UIScreen.main.bounds)
//        view.addSubview(webView)
//        let request = URLRequest(url: videoURL)
//        webView.load(request)
        
        
    }
}
