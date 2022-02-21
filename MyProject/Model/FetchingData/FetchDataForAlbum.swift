//
//  FetchDataForAlbum.swift
//  MyProject
//
//  Created by Ceren Çapar on 15.11.2021.
//

import Foundation
import UIKit

final class NetworkManager: NSObject {
    
    enum failEnum: Error {
        case serilizationError
    }
    
    enum HttpMethods: String {
        case POST
        case GET
    }
    
    static func fetchRequestPost<Body, Response>(url: String, method: HttpMethods ,model: Body, completion: @escaping (Result<Response>) -> Void) where Body: Codable, Response: Codable {
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
                    let result = try decoder.decode(Response.self, from: data)
                    completion(.success(result))
                } catch{
                    completion(.failure(failEnum.serilizationError))
                }
            }
        }
        task.resume()
    }
    
    static func fetchRequestGet<Response>(url: String,method: HttpMethods, completion: @escaping (Result<Response>) -> Void) where Response: Codable {
        let stornUrl = URL(string: url)!
        var request = URLRequest(url: stornUrl)
        request.timeoutInterval = 250
        request.httpMethod = method.rawValue
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(Response.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(failEnum.serilizationError))
                    }
                }
            }
        }
        task.resume()
    }
}

enum Result<U> {
    case success(U)
    case failure(Error)
}
