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
final class NetworkManager: NSObject {
    
    enum failEnum: Error {
        case serilizationError
    }
    
    enum HttpMethods: String {
        case POST
        case GET
    }
    
    static func fetchRequest<T>(url: String, method: HttpMethods ,model: T, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask where T: Codable {
        let stornUrl = URL(string: url)!
        var request = URLRequest(url: stornUrl)
        request.timeoutInterval = 300
        request.httpMethod = method.rawValue
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(failEnum.serilizationError))
                }
              
            }
        }
        task.resume()
        return task
    }
    
}
