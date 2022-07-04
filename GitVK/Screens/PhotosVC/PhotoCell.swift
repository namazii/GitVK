//
//  PhotoCell.swift
//  GitVK
//
//  Created by Назар Ткаченко on 03.07.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let identifier = "PhotoCell"
    
    //MARK: - Private properties
    private lazy var photoImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let likesLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Public
    func configure(_ photo: Photo) {
        let sizePhotos = photo.sizes
        
        guard let urlPhoto = sizePhotos.last else { return }
        
        photoImageView.sd_setImage(with: URL(string: urlPhoto.url))
        
        likesLabel.text = String(photo.likes.count)
    }
    
    //MARK: - Private methods
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(likesLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            likesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: 0),
            likesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])

    }
}
