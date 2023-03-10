//
//  CategoryTableViewCell.swift
//  Recipe App
//
//  Created by Kullanici on 1.02.2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        categoryLabel.adjustsFontSizeToFitWidth = true
        // Configure the view for the selected state
    }

}
