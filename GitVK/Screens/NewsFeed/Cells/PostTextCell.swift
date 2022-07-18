//
//  PostTextCellTableViewCell.swift
//  GitVK
//
//  Created by Назар Ткаченко on 09.07.2022.
//

import UIKit
import SnapKit

final class PostTextCell: UITableViewCell {

    static let identifier = "PostTextCell"
    
    let fullTextLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    //MARK: - LifeCycle
    //Перед переиспользованием обнулить внутренние данные
    override func prepareForReuse() {
        fullTextLabel.text = nil
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
        fullTextLabel.text = cellModel.text
    }
    
    //MARK: - Private methods
    private func setupViews() {
        contentView.addSubview(fullTextLabel)
    }
    
    private func setupConstraints() {
        fullTextLabel.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(contentView).inset(20)
        }
    }
}

