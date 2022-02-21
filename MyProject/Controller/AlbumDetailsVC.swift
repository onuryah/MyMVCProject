//
//  AlbumDetailsVC.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import UIKit
import SDWebImage

class AlbumDetailsVC: UIViewController{
    
    @IBOutlet private weak var albumDetailsCollectionView: UICollectionView!
    private var photoArray = [Photo]()
    var selectedId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonAdded()
        setCollectionView()
        fetch()
        registerCellToCollectionView()
        layoutForCell()
    }
}

extension AlbumDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    fileprivate func itemsInCell(cell: PhotosCell, indexPath: IndexPath) {
        cell.photoNameLabelField.text = photoArray[indexPath.row].title.capitalizingFirstLetter()
        cell.photosImageView.sd_setImage(with: URL(string: photoArray[indexPath.row].thumbnailURL))
    }
    
    func fetch(){
        NetworkManager.fetchRequestGet(url: URLClass.photos, method: .GET) { (result: Result<PhotoArray>) in
            switch result{
            case .failure(let erro):
                print(erro)
            case .success(let sc):
                for i in sc{
                    if i.albumID == self.selectedId{
                        self.photoArray.append(i)
                        self.albumDetailsCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = albumDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCell
        itemsInCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "selectedPicture") as! PictureDetailsVC
        secondViewController.selectedPhoto = photoArray[indexPath.row]
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func backButtonAdded() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Albums", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
    }
    
    fileprivate func layoutForCell() {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.size.width - 16) / 2
        layout.estimatedItemSize = CGSize(width: width, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        albumDetailsCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    fileprivate func registerCellToCollectionView() {
        let cellNib = UINib(nibName: "PhotosCell", bundle: nil)
        albumDetailsCollectionView.register(cellNib, forCellWithReuseIdentifier: "photosCell")
    }
    
    fileprivate func setCollectionView() {
        albumDetailsCollectionView.delegate = self
        albumDetailsCollectionView.dataSource = self
        self.albumDetailsCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    }
    
    func makeAlert(){
        let alert = UIAlertController(title: "ERROR", message: "Error Found!", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
