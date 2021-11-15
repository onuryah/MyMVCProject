//
//  AlbumDetailsVC.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import UIKit
import SDWebImage

class AlbumDetailsVC: UIViewController{
    
    @IBOutlet private weak var albumDetailsCollectionView: UICollectionView!
    private var photoArray = [Photos]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        fetchPhotoDatas()
    }
    
    fileprivate func fetchPhotoDatas() {
        FetchPhoto().getData { photos in
            if photos != nil {
                self.photoArray = photos!
            }
            self.albumDetailsCollectionView.reloadData()
        }
    }
    
    fileprivate func setCollectionView() {
        albumDetailsCollectionView.delegate = self
        albumDetailsCollectionView.dataSource = self
        self.albumDetailsCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCell
        shortCut(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Photos.selectedPhotoUrl = photoArray[indexPath.row].photoUrl
        Photos.selectedPhotoname = photoArray[indexPath.row].title.capitalizingFirstLetter()
        
        performSegue(withIdentifier: "toPictureDetailsVC", sender: nil)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension AlbumDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func shortCut(cell: PhotosCell, indexPath: IndexPath) {
        cell.photoNameLabelField.lineBreakMode = .byWordWrapping
        cell.photoNameLabelField.numberOfLines = 0
        
        cell.photoNameLabelField.text = photoArray[indexPath.row].title.capitalizingFirstLetter()
        cell.photosImageView.sd_setImage(with: URL(string: photoArray[indexPath.row].thumbnailUrl))
    }
}
