//
//  NetworkRouter.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 27/03/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

import Foundation

typealias Completion<T> = (_ json: T?, _ error: Error?) -> ()

protocol NetworkBindable {
    associatedtype EndPoint: EndPointType
    func handleAPIRequest<T: Codable>(_ endPoint: EndPoint, _ completion: @escaping Completion<T>)
}

struct NetworkRouter<EndPoint: EndPointType>: NetworkBindable {
    func handleAPIRequest<T: Codable>(_ endPoint: EndPoint, _ completion: @escaping Completion<T>) {
        
        if let request = buildRequest(endPoint) {
           let urlSessionDataTask = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                if let useableData = data {
                    let decoder = JSONDecoder()
                    do {
                        let jsonData = try decoder.decode(T.self, from: useableData)
                        completion(jsonData, nil)
                    } catch(let error) {
                        print(error.localizedDescription)
                        completion(nil, error)
                    }
                }
            }
            urlSessionDataTask.resume()
        }
    }
}


private extension NetworkRouter {
    func buildRequest(_ endPoint: EndPoint) -> URLRequest? {
        guard let url = URL(string: endPoint.path, relativeTo: endPoint.baseURL) else { return nil }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 100)
        return request
    }
}
