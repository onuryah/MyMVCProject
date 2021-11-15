//
//  ViewController.swift
//  MyProject
//
//  Created by Ceren Çapar on 7.11.2021.
//

import UIKit

class ListVC: UIViewController{

    @IBOutlet private weak var albumNamesTableView: UITableView!
    var albumArray = [Albums]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setTableViewDelegates()
    }
    
    fileprivate func fetchData(){
        FetchAlbum().getData { album in
            if album != nil {
                self.albumArray = album!
            }
            self.albumNamesTableView.reloadData()
        }
    }
    
    fileprivate func setTableViewDelegates() {
        albumNamesTableView.delegate = self
        albumNamesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumNamesTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        
        cell.albumNamesLabelField.lineBreakMode = .byWordWrapping
        cell.albumNamesLabelField.numberOfLines = 0
        
        cell.albumNamesLabelField.text = albumArray[indexPath.row].title.capitalizingFirstLetter()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Albums.selectedId = albumArray[indexPath.row].id
        
        performSegue(withIdentifier: "toAlbumDetailsVC", sender: nil)
    }
}
extension ListVC: UITableViewDelegate, UITableViewDataSource{
}

