//
//  NetworkManager.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 27/03/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

import Foundation

class Network: NSObject {
    static var shared = NetworkManager()
}


struct NetworkManager {
    private let networkRouter: NetworkRouter<APIEndPoint>
    
    init(networkRouter: NetworkRouter<APIEndPoint> = .init()) {
        self.networkRouter = networkRouter
    }
    
    func getSearchResult(for keyword: String, completion: @escaping Completion<Photos>) {
        networkRouter.handleAPIRequest(.search, completion)
    }
}
