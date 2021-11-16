//
//  FetchDataForAlbum.swift
//  MyProject
//
//  Created by Ceren Çapar on 15.11.2021.
//

import Foundation
import UIKit

class FetchAlbum {
    private var albumArray = [Albums]()
    
    public func getData(completion : @escaping([Albums]?) -> ()) {
        URLSession.shared.dataTask(with: AlbumUrl().albumUrl!) { data, response, error in
                DispatchQueue.main.async {
                if error != nil {
                    let alert = UIAlertController(title: "ERROR", message: "Error!", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    ListVC().present(alert, animated: true, completion: nil)
                    completion(nil)
                }else if data != nil {
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]{
                            for data in json {
                                if let titleToList = data["title"] as? String{
                                    if let idToList = data["id"] as? Int{
                                        let albumsId = Albums(id: idToList, title: titleToList)
                                        self.albumArray.append(albumsId)
                                        completion(self.albumArray)
                                }
                            }
                        }
                    }
                }
           }
        }.resume()
    }
}
