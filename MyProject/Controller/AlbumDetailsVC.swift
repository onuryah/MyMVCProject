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
        if photoArray.count % 4 == 0 {
            let returning = (photoArray.count / 4)
            return returning
        }else {
            let returning = (photoArray.count / 4) + 1
            return returning
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumDetailsTableView.dequeueReusableCell(withIdentifier: "albumDetailsCell", for: indexPath) as! AlbumCell
        
        cell.firstTitleLabelField.lineBreakMode = .byWordWrapping
        cell.firstTitleLabelField.numberOfLines = 0
        
        cell.secondTitleLabelField.lineBreakMode = .byWordWrapping
        cell.secondTitleLabelField.numberOfLines = 0
        
        cell.thirdTitleLabelField.lineBreakMode = .byWordWrapping
        cell.thirdTitleLabelField.numberOfLines = 0
        
        cell.fourthTitleLabelField.lineBreakMode = .byWordWrapping
        cell.fourthTitleLabelField.numberOfLines = 0
        
        
        let orderedRow = indexPath.row * 4
        cell.firstTitleLabelField.text = self.photoArray[orderedRow].title.capitalizingFirstLetter()
        
        if photoArray.count >= orderedRow + 2 {
            cell.secondTitleLabelField.text = self.photoArray[orderedRow + 1].title.capitalizingFirstLetter()
        }else {
            cell.secondTitleLabelField.text = ""
        }
        
        if photoArray.count >= orderedRow + 3 {
            cell.thirdTitleLabelField.text = self.photoArray[orderedRow + 2].title.capitalizingFirstLetter()
        }else {
            cell.thirdTitleLabelField.text = ""
        }
        
        if photoArray.count >= orderedRow + 4 {
            cell.fourthTitleLabelField.text = self.photoArray[orderedRow + 3].title.capitalizingFirstLetter()
        }else {
            cell.fourthTitleLabelField.text = ""
        }
        
        print(indexPath.row)
        return cell
    }
    



}
