//
//  NetworkRouter.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 27/03/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

import Foundation

typealias Completion = ()->()

protocol NetworkBindable {
    associatedtype EndPoint = EndPointType
    func handleAPIRequest(_ endPoint: EndPoint, _ completion: @escaping Completion)
}

struct NetworkRouter: NetworkBindable {
    
}
