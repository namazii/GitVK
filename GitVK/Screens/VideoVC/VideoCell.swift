//
//  VideoCell.swift
//  GitVK
//
//  Created by Назар Ткаченко on 16.07.2022.
//

import UIKit
import SnapKit
import SDWebImage

class VideoCell: UITableViewCell {
    
    static let identifier = "videoCell"
    
    var ButtonPressed = false
    
    let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        
        return photoImageView
    }()
    
    let playerImageView: UIImageView = {
        let playerImageView = UIImageView()
        
        playerImageView.image = UIImage(systemName: "play.fill")
        playerImageView.alpha = 0.7
        playerImageView.tintColor = .gray
        
        return playerImageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    //MARK: - LifeCycle
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
        photoImageView.sd_setImage(with: URL(string: video.image.last?.url ?? "" ))
    }
    
    //MARK: - PrivateMethods
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImageView)
        contentView.addSubview(playerImageView)
    }
    
    private func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.width)
            make.top.left.right.equalTo(contentView).inset(0)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(contentView).inset(20)
        }
        
        playerImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(photoImageView).inset(170)
            make.left.right.equalTo(photoImageView).inset(160)
            
        }
    }
}
