//
//  Posts.swift
//  MyProject
//
//  Created by Ceren Çapar on 8.11.2021.
//

import Foundation

struct Albums: Decodable, Encodable {
 
    let id : Int
    let title  : String
    static var selectedId = Int()
}
typealias AlbumArray = [Albums]
