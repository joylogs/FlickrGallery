//
//  EndPointType.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 27/03/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

import Foundation

enum Method: String {
    case GET
    case POST
}

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }    
    var apiKey: String { get }
}
