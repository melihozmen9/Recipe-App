//
//  SubTableViewCell.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import UIKit

class SubTableViewCell: UITableViewCell {
    
    var subCategoryLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.numberOfLines = 0
        return label
    }()
    
    var subCategoryImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "sun"))
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let customView = UIView(frame: contentView.frame)
        customView.backgroundColor = .white
        customView.layer.masksToBounds = true
        customView.layer.cornerRadius = 10
        contentView.addSubview(customView)
        customView.addSubview(subCategoryLabel)
        customView.addSubview(subCategoryImage)
        
        subCategoryLabel.snp.makeConstraints { make in
            make.centerY.equalTo(customView.snp.centerY)
            make.right.equalTo(customView.snp.right)
            make.width.equalTo(customView.snp.width).multipliedBy(0.7)
            make.height.equalTo(customView.snp.height).multipliedBy(0.5)
        }
        
        subCategoryImage.snp.makeConstraints { make in
            make.centerY.equalTo(subCategoryLabel.snp.centerY)
            make.width.height.equalTo(customView.snp.width).multipliedBy(0.2)
            make.left.equalTo(customView.snp.left).offset(customView.frame.size.width * 0.03)
        }
        
        customView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.snp.edges).inset(3)
        }
    }

}

