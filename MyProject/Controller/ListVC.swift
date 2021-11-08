//
//  ViewController.swift
//  MyProject
//
//  Created by Ceren Çapar on 7.11.2021.
//

import UIKit

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var albumNamesTableView: UITableView!
    var titleList = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumNamesTableView.delegate = self
        albumNamesTableView.dataSource = self
        
        getData()
        
    }
    
    func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("Error")
            }else if data != nil {
                
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]{
                        for data in json {
                            if let dataToList = data["title"] as? String{
                                self.titleList.append(dataToList)
                            }
                        }
                        print(self.titleList)
                        
                        
                        DispatchQueue.main.async {
                            self.albumNamesTableView.reloadData()
                        }
                    }
                
            }
        }.resume()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumNamesTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        
        cell.albumNamesLabelField.lineBreakMode = .byWordWrapping
        cell.albumNamesLabelField.numberOfLines = 0
        
        cell.albumNamesLabelField.text = self.titleList[indexPath.row].capitalizingFirstLetter()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAlbumDetailsVC", sender: nil)
    }
    

}

