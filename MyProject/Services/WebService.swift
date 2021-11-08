//
//  WebService.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import Foundation

class Webservice{
    func downloadDatas(url : URL,completion : @escaping([Posts]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else {
                if let data = data {
                    let postList = try? JSONDecoder().decode([Posts].self, from: data)
                    
                    if let postList = postList {
                        completion(postList)
                    }
                }
            }
        }.resume()
    }
}
