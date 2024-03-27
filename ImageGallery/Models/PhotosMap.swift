//
//  QueryResponse.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 19/01/19.
//  Copyright © 2019 Joy Banerjee. All rights reserved.
//

import Foundation

struct PhotosMap: Codable {
    let stat: String
    let photos: Photos
}

struct Photos: Codable {
    
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    let photo: [Safe<Photo>]
}

struct Photo: Codable {
    
    let id: String
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let ispublic: Int?
    let isfriend: Int?
    let isfamily: Int?
    
}

public struct Safe<Base: Codable>: Codable {
    public let value: Base?
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
//            assertionFailure("ERROR: \(error)")
            self.value = nil
        }
    }
}

