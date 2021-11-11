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
        albumDetailsCollectionView.delegate = self
        albumDetailsCollectionView.dataSource = self
        
        self.albumDetailsCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
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
                        self.albumDetailsCollectionView.reloadData()
                    }
                }
            }
        }.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCell
        
        cell.photoNameLabelField.lineBreakMode = .byWordWrapping
        cell.photoNameLabelField.numberOfLines = 0
        
        cell.photoNameLabelField.text = photoArray[indexPath.row].title.capitalizingFirstLetter()
        cell.photosImageView.sd_setImage(with: URL(string: photoArray[indexPath.row].thumbnailUrl))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Photos.selectedPhotoUrl = photoArray[indexPath.row].photoUrl
        Photos.selectedPhotoname = photoArray[indexPath.row].title.capitalizingFirstLetter()
        
        print("Kontrol : \(Photos.selectedPhotoUrl) ve \(Photos.selectedPhotoname)")
        performSegue(withIdentifier: "toPictureDetailsVC", sender: nil)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
