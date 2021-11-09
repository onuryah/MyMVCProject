//
//  AlbumDetailsVC.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import UIKit

class AlbumDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var albumDetailsTableView: UITableView!
    var photoArray = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumDetailsTableView.delegate = self
        albumDetailsTableView.dataSource = self
        albumDetailsTableView.reloadData()
        
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
                        self.albumDetailsTableView.reloadData()
                    }
                }
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumDetailsTableView.dequeueReusableCell(withIdentifier: "albumDetailsCell", for: indexPath) as! AlbumCell
        
        let orderedRow = indexPath.row / 4
        cell.firstTitleLabelField.text = self.photoArray[orderedRow].title.capitalizingFirstLetter()
        cell.secondTitleLabelField.text = self.photoArray[indexPath.row].title.capitalizingFirstLetter()
        cell.thirdTitleLabelField.text = self.photoArray[indexPath.row].title.capitalizingFirstLetter()
        cell.fourthTitleLabelField.text = self.photoArray[indexPath.row + 4].title.capitalizingFirstLetter()
        
        print(indexPath.row)
        return cell
    }
    



}
