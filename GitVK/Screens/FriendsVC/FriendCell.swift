//
//  FriendCell.swift
//  GitVK
//
//  Created by Назар Ткаченко on 22.06.2022.
//

import UIKit
import SDWebImage

class FriendCell: UITableViewCell {

    static let identifier = "FriendCell"
    
    let photoImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        
        return imageView
    }()
    let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    func configure(_ friend: Friend) {
        nameLabel.text = "\(friend.firstName) \(friend.lastName)"
        photoImageView.sd_setImage(with: URL(string: friend.photo50))
    }
    
    //MARK: - Private methods
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 50),
            photoImageView.heightAnchor.constraint(equalToConstant: 50),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
