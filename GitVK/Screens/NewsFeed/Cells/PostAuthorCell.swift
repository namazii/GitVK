//
//  PostAuthorCell.swift
//  GitVK
//
//  Created by Назар Ткаченко on 13.07.2022.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

final class PostAuthorCell: UITableViewCell {
    
    static let identifier = "PostAuthorCell"

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        authorLabel.text = nil
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
        self.authorLabel.text = cellModel.authorName
        self.photoImageView.sd_setImage(with: URL(string: cellModel.authorImageUrl))
    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(authorLabel)
    }
    
    private func setupConstraints() {

        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.top.left.bottom.equalTo(contentView).inset(20)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.left.equalTo(photoImageView.snp.right).offset(20)
            make.top.right.bottom.equalTo(contentView).inset(20)
        }
    }
    
}
