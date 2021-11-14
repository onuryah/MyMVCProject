//
//  AlbumDetailsVC.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import UIKit
import SDWebImage

class AlbumDetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var albumDetailsCollectionView: UICollectionView!
    
    var photoArray = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Setting delegates
        albumDetailsCollectionView.delegate = self
        albumDetailsCollectionView.dataSource = self
        
//        Giving to collectionView background color
        self.albumDetailsCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        
//        Calling func to get data
        getData()
        
    }
 
//    This func gets to pair with clicked id of the album datas to show.
    func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "ERROR", message: "Error!", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
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
                        self.albumDetailsCollectionView.reloadData()
                    }
                }
            }
        }.resume()
    }
    
//    To determine total rows number
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
//    This func is about to how much to repeat given items.
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    Connected to PhotosCell and wrote desire datas to labelField and ImageView.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCell
        
//        Gives to the label dynamic property.
        cell.photoNameLabelField.lineBreakMode = .byWordWrapping
        cell.photoNameLabelField.numberOfLines = 0
        
        
        cell.photoNameLabelField.text = photoArray[indexPath.row].title.capitalizingFirstLetter()
        cell.photosImageView.sd_setImage(with: URL(string: photoArray[indexPath.row].thumbnailUrl))
        
        return cell
    }
    
    
//    Got photoUrl from clicked row and wrote to static object to show in PictureDetailsVC.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Photos.selectedPhotoUrl = photoArray[indexPath.row].photoUrl
        Photos.selectedPhotoname = photoArray[indexPath.row].title.capitalizingFirstLetter()
        
//        Going to PictureDetailsVC.
        performSegue(withIdentifier: "toPictureDetailsVC", sender: nil)
    }
    
//    To move to ListVC to show albums.
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
