//
//  ReturnedAlbumDetailsVC.swift
//  MyProject
//
//  Created by Ceren Çapar on 12.11.2021.
//

import UIKit
import SDWebImage

class RotatedAlbumDetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var rotatedAlbumDetailsCollectionView: UICollectionView!
    var photoArray = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rotatedAlbumDetailsCollectionView.delegate = self
        rotatedAlbumDetailsCollectionView.dataSource = self
        
        self.rotatedAlbumDetailsCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        getData()
    }
    
    
    func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("error")
            }else if data != nil {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]{
                    for data in json{
                        if let albumIdToListCheck = data["albumId"] as? Int{
                            
                            if albumIdToListCheck == Albums.selectedId{
                                let albumIdToList = albumIdToListCheck
                                
                                if let titleToList = data["title"] as? String{
                                    if let photoUrlToList = data["url"] as? String{
                                        if let thumbnailUrlToList = data["thumbnailUrl"] as? String{
                                            let photo = Photos(title: titleToList, albumId: albumIdToList, photoUrl: photoUrlToList, thumbnailUrl: thumbnailUrlToList)
                                            self.photoArray.append(photo)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    DispatchQueue.main.async{
                        self.rotatedAlbumDetailsCollectionView.reloadData()
                    }
                }
            }
        }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 134, height: 174)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = rotatedAlbumDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "rotatedPhotosCell", for: indexPath) as! RotatedPhotosCell
        
        cell.rotatedPhotoNameLabelField.lineBreakMode = .byWordWrapping
        cell.rotatedPhotoNameLabelField.numberOfLines = 0
        
       
        
        cell.rotatedPhotoNameLabelField.text = photoArray[indexPath.row].title.capitalizingFirstLetter()
        cell.rotatedPhotosImageView.sd_setImage(with: URL(string: photoArray[indexPath.row].thumbnailUrl))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Photos.selectedPhotoUrl = photoArray[indexPath.row].photoUrl
        Photos.selectedPhotoname = photoArray[indexPath.row].title.capitalizingFirstLetter()
        
        print("Kontrol : \(Photos.selectedPhotoUrl) ve \(Photos.selectedPhotoname)")
        performSegue(withIdentifier: "fromRotatedAlbumDetailsVCToPictureDetailsVC", sender: nil)
    }
    
    
    
    
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "fromRotatedAlbumDetailsVCToListVC", sender: nil)
    }

}
