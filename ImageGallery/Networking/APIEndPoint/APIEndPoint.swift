//
//  APIEndPoint.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 27/03/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

import Foundation

enum APIEndPoint {
    case search
    case getSizes
}


extension APIEndPoint: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://baseURL.com") else { fatalError("Invalid baseURL") }
        return url
    }
    var method: Method {
        return .GET
    }
    var path: String {
        switch self {
        case .search:
            return "thisPath"
        case .getSizes:
            return "thisPath"
        }
    }
}
