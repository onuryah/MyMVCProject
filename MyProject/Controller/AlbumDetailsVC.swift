//
//  AlbumDetailsVC.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import UIKit

class AlbumDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var albumDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumDetailsTableView.delegate = self
        albumDetailsTableView.dataSource = self
        albumDetailsTableView.reloadData()

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumDetailsTableView.dequeueReusableCell(withIdentifier: "albumDetailsCell", for: indexPath) as! AlbumCell
        
        return cell
    }
    



}
