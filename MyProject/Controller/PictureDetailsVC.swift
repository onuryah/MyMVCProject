//
//  PictureDetailsVC.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import UIKit
import SDWebImage

class PictureDetailsVC: UIViewController {
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showItems()

        
    }
    
    func showItems() {
        
        resultNameLabel.lineBreakMode = .byWordWrapping
        resultNameLabel.numberOfLines = 0
        
        resultImageView.sd_setImage(with: URL(string: Photos.selectedPhotoUrl))
        resultNameLabel.text = Photos.selectedPhotoname
        
    }

}
