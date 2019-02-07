//
//  SizesMap.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 20/01/19.
//  Copyright © 2019 Joy Banerjee. All rights reserved.
//

import Foundation

enum SizeType : String, Codable {
    case square
    case largeSquare
    case thumbnail
    case small
    case small320
    case medium
    case medium640
    case medium800
    case large
    case large1600
    case large2048
    case original
    case unknown

    init(type : String) {
        switch type {
        case "Square":
            self = .square
        case "Large Square":
            self = .largeSquare
        case "Thumbnail":
            self = .thumbnail
        default:
            self = .unknown
        }
    }
    
}

struct SizesMap: Codable {
    let stat: String
    let sizes: Sizes
}

struct Sizes: Codable {
    
    let canblog: Int?
    let canprint: Int?
    let candownload: Int?
    let size: [Safe<Size>]
}

struct Size: Codable {
    
    let label : String
    let width: Safe<String>
    let height: Safe<String>
    let source: URL?
    let url: URL?
    let media: String?
}
