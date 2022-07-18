//
//  PostPhotoCell.swift
//  GitVK
//
//  Created by Назар Ткаченко on 13.07.2022.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

final class PostPhotoCell: UITableViewCell {
    
    static let identifier = "PostPhotoCell"
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
//        image.contentMode = .scaleAspectFill
//        image.layer.cornerRadius = 25
//        image.clipsToBounds = true
        return image
    }()
    
    //MARK: - LifeCycle
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    func configure(_ cellModel: PostCellModel) {
        
        let url = URL(string: cellModel.photoUrl)
        self.photoImageView.sd_setImage(with: url)
    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {

        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.width) //квадратное фото
            make.top.left.right.bottom.equalTo(contentView).inset(0)
        }
    }
}
