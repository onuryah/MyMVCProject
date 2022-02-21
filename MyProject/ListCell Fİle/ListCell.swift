//
//  ListCell.swift
//  MyProject
//
//  Created by Ceren Çapar on 16.11.2021.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var albumNamesLabelField: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        fixLabelField()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
extension ListCell{
    fileprivate func fixLabelField() {
        albumNamesLabelField.lineBreakMode = .byWordWrapping
        albumNamesLabelField.numberOfLines = 0
    }
}
