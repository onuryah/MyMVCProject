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
        
        
//        Call to func to set imageView and labelField as requested.
        showItems()
       
    }
    
//    Sets objects from noted information.
    func showItems() {
        
        
//        Gives to the label dynamic property.
        resultNameLabel.lineBreakMode = .byWordWrapping
        resultNameLabel.numberOfLines = 0
        
//        Gives corners radius.
        resultImageView.layer.cornerRadius = 50

        
        resultImageView.sd_setImage(with: URL(string: Photos.selectedPhotoUrl))
        resultNameLabel.text = Photos.selectedPhotoname
        
    }
    
//    To move back and change to columns numbers.
    @IBAction func backButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toRotatedAlbumDetailsVC", sender: nil)
    }
    
}
