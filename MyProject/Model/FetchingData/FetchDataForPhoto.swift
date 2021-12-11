//
//  FetchDataForPhoto.swift
//  MyProject
//
//  Created by Ceren Çapar on 15.11.2021.
//

import Foundation
import UIKit

class FetchPhoto{
    private var photoArray = [Photos]()
    
    public func getData(completion : @escaping([Photos]?) -> ()) {
        guard let url = URL(string: URLClass.photos) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
            if error != nil {
                completion(nil)
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
                                            completion(self.photoArray)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }.resume()
  }
}
