//
//  Photos.swift
//  MyProject
//
//  Created by Ceren Çapar on 9.11.2021.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let title: String
    let albumID: Int
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case albumID = "albumId"
        case url
        case thumbnailURL = "thumbnailUrl"
    }
}


typealias PhotoArray = [Photo]
