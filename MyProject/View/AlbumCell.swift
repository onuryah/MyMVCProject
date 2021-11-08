//
//  AlbumCell.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import UIKit

class AlbumCell: UITableViewCell {
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var firstTitleLabelField: UILabel!
    @IBOutlet weak var secondTitleLabelField: UILabel!
    @IBOutlet weak var thirdTitleLabelField: UILabel!
    @IBOutlet weak var fourthTitleLabelField: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
