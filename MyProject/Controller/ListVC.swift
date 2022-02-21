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
        registerCellToTableView()
    }
    
    fileprivate func fetchData(){
        NetworkManager.fetchRequestGet(url: URLClass.albums, method: .GET) { (result: Result<AlbumArray>) in
            DispatchQueue.main.async {
                
            
            switch result {
            case .success(let u):
                self.albumArray = u
                self.albumNamesTableView.reloadData()
            case .failure(let error):
                print("kontrol1: \(error)")
            }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumNamesTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListCell
        cell.albumNamesLabelField.text = albumArray[indexPath.row].title.capitalizingFirstLetter()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "toAlbumDetailsVC") as! AlbumDetailsVC
        secondViewController.selectedId = albumArray[indexPath.row].id
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}
extension ListVC: UITableViewDelegate, UITableViewDataSource{
    fileprivate func setTableViewDelegates() {
        albumNamesTableView.delegate = self
        albumNamesTableView.dataSource = self
    }
    fileprivate func registerCellToTableView(){
        let cellNib = UINib(nibName: "ListCell", bundle: nil)
        albumNamesTableView.register(cellNib, forCellReuseIdentifier: "listCell")
    }
    
    func makeAlert(){
        let alert = UIAlertController(title: "ERROR", message: "Error Found!", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

