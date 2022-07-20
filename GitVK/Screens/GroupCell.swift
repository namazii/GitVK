//
//  GroupCell.swift
//  GitVK
//
//  Created by Назар Ткаченко on 02.07.2022.
//

import UIKit
import SDWebImage

class GroupCell: UITableViewCell {

    static let identifier = "GroupCell"
    
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
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    func configure(_ group: Group) {
        nameLabel.text = "\(group.name) \(group.itemDescription)"
        photoImageView.sd_setImage(with: URL(string: group.photo50))
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
