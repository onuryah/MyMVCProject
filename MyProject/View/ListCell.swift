//
//  ListCell.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var albumNamesLabelField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
