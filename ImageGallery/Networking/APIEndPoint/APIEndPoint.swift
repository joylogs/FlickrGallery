//
//  APIEndPoint.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 27/03/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

import Foundation

enum APIEndPoint {
    case search(_ : String)
    case getSizes(_: String)
}

extension APIEndPoint: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.flickr.com") else { fatalError("Invalid baseURL") }
        return url
    }
    
    var apiKey: String {
        return "f9cc014fa76b098f9e82f1c288379ea1"
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        switch self {
        case .search(let query):
            return "/services/rest?method=flickr.photos.search&api_key=\(apiKey)&tags=\(query)&page=1&format=json&nojsoncallback=1"
        case .getSizes(let photoId):
            return "/services/rest?method=flickr.photos.getSizes&api_key=\(apiKey)&photo_id=\(photoId)&format=json&nojsoncallback=1"
        }
    }
}
