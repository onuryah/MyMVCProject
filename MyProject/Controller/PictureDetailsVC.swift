//
//  PictureDetailsVC.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import UIKit
import SDWebImage

class PictureDetailsVC: UIViewController {
    @IBOutlet private weak var resultImageView: UIImageView!
    @IBOutlet private weak var resultNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showItems()
    }
    func showItems() {
        
        resultNameLabel.lineBreakMode = .byWordWrapping
        resultNameLabel.numberOfLines = 0
        resultImageView.layer.cornerRadius = 50

        resultImageView.sd_setImage(with: URL(string: Photos.selectedPhotoUrl))
        resultNameLabel.text = Photos.selectedPhotoname
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
