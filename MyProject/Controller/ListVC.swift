//
//  ViewController.swift
//  MyProject
//
//  Created by Ceren Çapar on 7.11.2021.
//

import UIKit

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var albumNamesTableView: UITableView!
    var albumArray = [Albums]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Setting delegates
        albumNamesTableView.delegate = self
        albumNamesTableView.dataSource = self
        
//        Calling func to get data
        getData()
        
        
    }
    
    
//    This func gets albums id and title from given url.
    func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "ERROR", message: "Error!", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else if data != nil {
                
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]{
                        for data in json {
                            if let titleToList = data["title"] as? String{
                                if let idToList = data["id"] as? Int{
                                    let albumsId = Albums(id: idToList, title: titleToList)
                                    self.albumArray.append(albumsId)
                            }
                        }
                    }
                        DispatchQueue.main.async {
                            self.albumNamesTableView.reloadData()
                        }
                    }
            }
        }.resume()
    }
    
    
//    To determine total rows number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArray.count
    }
    
    
//    Connected to ListCell and wrote desire datas to labelField.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumNamesTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        
//        Gives to the label dynamic property.
        cell.albumNamesLabelField.lineBreakMode = .byWordWrapping
        cell.albumNamesLabelField.numberOfLines = 0
        
        cell.albumNamesLabelField.text = self.albumArray[indexPath.row].title.capitalizingFirstLetter()
        return cell
    }
    
    
//    Got information clicked row and wrote to static object to handle it in AlbumDetailsVC.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Albums.selectedId = albumArray[indexPath.row].id
        
//        To go AlbumDetailsVC.
        performSegue(withIdentifier: "toAlbumDetailsVC", sender: nil)
    }
    
    
}

