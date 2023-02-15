//
//  SubTableViewCell.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import UIKit

class SubTableViewCell: UITableViewCell {

    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var subCategoryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        subCategoryLabel.lineBreakMode = .byWordWrapping
        subCategoryLabel.numberOfLines = 0
        
        // Configure the view for the selected state
    }

}
