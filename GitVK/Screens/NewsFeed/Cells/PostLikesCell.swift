//
//  PostLikesCell.swift
//  GitVK
//
//  Created by Назар Ткаченко on 13.07.2022.
//

import Foundation
import UIKit
import SnapKit

final class PostLikesCell: UITableViewCell {
    
    static let identifier = "PostLikesCell"
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        self.likesLabel.text = "❤️ 0"
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
        self.likesLabel.text = "♥️ \(cellModel.likesCount)"
    }
    
    //MARK: - Private
    private func setupViews() {
        contentView.addSubview(likesLabel)
        contentView.addSubview(separatorView)
    }
    
    private func setupConstraints() {
        likesLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(20)
        }
        
        separatorView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(contentView)
            make.height.equalTo(5)
        }
    }
}
