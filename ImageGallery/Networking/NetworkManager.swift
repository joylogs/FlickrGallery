//
//  NetworkManager.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 27/03/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

import Foundation

struct NetworkManager {
    private let networkRouter: NetworkRouter<APIEndPoint>
    private let dispatchGroup: DispatchGroup?
    
    init(_ networkRouter: NetworkRouter<APIEndPoint> = .init(), dispatchGroup: DispatchGroup? = nil) {
        self.networkRouter = networkRouter
        self.dispatchGroup = dispatchGroup
    }
    
    func getSearchResult(with query: String, completion: @escaping Completion<PhotosMap>) {
        dispatchGroup?.enter()
        networkRouter.handleAPIRequest(.search(query), completion)
        dispatchGroup?.leave()
    }
    
    func getSizes(for photoID: String, completion: @escaping Completion<SizesMap>) {
        dispatchGroup?.enter()
        networkRouter.handleAPIRequest(.getSizes(photoID), completion)
        dispatchGroup?.leave()
    }
    
}
