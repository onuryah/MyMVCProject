//
//  ViewController.swift
//  MyProject
//
//  Created by Ceren Çapar on 7.11.2021.
//

import UIKit

class ListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var albumNamesTableView: UITableView!
    var titleList = [Posts]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumNamesTableView.delegate = self
        albumNamesTableView.dataSource = self
        
        albumNamesTableView.reloadData()
        
        getData()
        
    }
    
    func getData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("Error")
            }else if data != nil {
                
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]{
                        print("kontrol : \(json)")
                        
                        
                        DispatchQueue.main.async {
                            self.albumNamesTableView.reloadData()
                        }
                    }
                
            }
        }.resume()
        

        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumNamesTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        return cell
    }
    

}

