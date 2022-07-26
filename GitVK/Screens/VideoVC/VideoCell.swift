//
//  VideoCell.swift
//  GitVK
//
//  Created by Назар Ткаченко on 16.07.2022.
//

import UIKit
import SnapKit
import SDWebImage
import WebKit

class VideoCell: UITableViewCell {
    
    static let identifier = "videoCell"
    
    var ButtonPressed = false
    
//    private let photoImageView: UIImageView = {
//        let photoImageView = UIImageView()
//
//        return photoImageView
//    }()
    
    private let playerVideo: WKWebView = {
        let webView = WKWebView()
        
        return webView
    }()
    
//    private let playerImageView: UIImageView = {
//        let playerImageView = UIImageView()
//
//        playerImageView.image = UIImage(systemName: "play.fill")
//        playerImageView.alpha = 0.7
//        playerImageView.tintColor = .gray
//
//        return playerImageView
//    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    //MARK: - LifeCycle
    override func prepareForReuse() {
//        playerVideo.reload()
//        photoImageView.image = nil
//        playerImageView.image = nil
        nameLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public
    func configure(_ video: Video) {
        nameLabel.text = video.title
//        photoImageView.sd_setImage(with: URL(string: video.image.last?.url ?? "" ))
        
        guard let videoURL = URL(string: video.player ?? "") else { return }
        let request = URLRequest(url: videoURL)
        playerVideo.load(request)
    }
    
    //MARK: - PrivateMethods
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(playerVideo)
//        contentView.addSubview(photoImageView)
//        contentView.addSubview(playerImageView)
    }
    
    private func setupConstraints() {
//        photoImageView.snp.makeConstraints { make in
//            make.width.equalTo(contentView.snp.width)
//            make.height.equalTo(contentView.snp.width).multipliedBy(0.6)
//            make.top.left.right.equalTo(contentView).inset(0)
//
//        }
        
        playerVideo.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.6)
            make.top.left.right.equalTo(contentView).inset(0)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(playerVideo.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(contentView).inset(20)
        }
        
//        playerImageView.snp.makeConstraints { make in
//            make.center.equalTo(photoImageView.snp.center).inset(0)
//            make.height.equalTo(photoImageView.snp.width).multipliedBy(0.2)
//            make.width.equalTo(photoImageView.snp.width).multipliedBy(0.2)
////            make.left.right.equalTo(contentView).inset(170)
//            
//        }
    }
}
