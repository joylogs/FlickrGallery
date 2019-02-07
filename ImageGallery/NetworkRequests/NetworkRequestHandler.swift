//
//  NetworkRequestHandler.swift
//  TopNews
//
//  Created by Joy Banerjee on 20/01/19.
//  Copyright © 2019 Joy Banerjee. All rights reserved.
//

import Foundation

protocol NetworkRequestHandlerDelegate: class {
    
    func gotResults(data: Data)
    func gotError(error: Error?)
}

class NetworkRequestHandler {
    
    // MARK: - Constants
    let apiKey = "f9cc014fa76b098f9e82f1c288379ea1"
    let apiHost = "https://api.flickr.com"
    
    weak var delegate: NetworkRequestHandlerDelegate?
    
    let dispatchGroup = DispatchGroup()

    func makeNetworkRequest(with api: String, query: String, completion: @escaping (_ products: Photos?) -> ()) {
        
        let urlString = URL(string: "\(apiHost)/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&tags=\(query)&page=1&format=json&nojsoncallback=1")
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                    self.delegate?.gotError(error: error)
                } else {
                    if let usableData = data {
//                        print("1")
                        print(usableData)
                        //Success:
//                        self.delegate?.gotResults(data: usableData)
                        
                        do {
                            let decoder = JSONDecoder()
                            let photoMap = try decoder.decode(PhotosMap.self, from: usableData)
                            completion(photoMap.photos)
                        } catch {
                            print(error.localizedDescription)
                            completion(nil)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
    func makeSearchRequest(with query: String, _ dispatchGroup : DispatchGroup) {
        
        
//    https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f9cc014fa76b098f9e82f1c288379ea1&tags=kitten&page=1&format=json&nojsoncallback=1
//    https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=f9cc014fa76b098f9e82f1c288379ea1&photo_id=31456463045&format=json&nojsoncallback=1
//    https://farm6.staticflickr.com/5800/31456463045_5a0af4ddc8_q.jpg

        
        let urlString = URL(string: "\(apiHost)/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&tags=\(query)&page=1&format=json&nojsoncallback=1")
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                    self.delegate?.gotError(error: error)
                } else {
                    if let usableData = data {
//                        print("1")
                        print(usableData)
                        //Success:
                        self.delegate?.gotResults(data: usableData)
                    }
                }
                dispatchGroup.leave()
            }
            task.resume()
        }
    }
    
    func getSizes(for photoId: String, _ dispatchGroup : DispatchGroup, completion: @escaping (_ products: Sizes?) -> ()) {
        
        //    https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=f9cc014fa76b098f9e82f1c288379ea1&photo_id=31456463045&format=json&nojsoncallback=1
        
        let urlString = URL(string: "\(apiHost)/services/rest/?method=flickr.photos.getSizes&api_key=\(apiKey)&photo_id=\(photoId)&format=json&nojsoncallback=1")
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                    self.delegate?.gotError(error: error)
                } else {
                    if let usableData = data {
////                        print("2")
//                        print(usableData)
//                        //Success:
////                        self.delegate?.gotResults(data: usableData)
                        
                        do {
                            let decoder = JSONDecoder()
                            let sizesMap = try decoder.decode(SizesMap.self, from: usableData)
                            completion(sizesMap.sizes)
                        } catch {
                            print(error.localizedDescription)
                            completion(nil)
                        }
                        
                        
                    }
                }
                dispatchGroup.leave()
            }
            task.resume()
        }
    }
    
//    func fetchAllNews(for country: String) {
//
//        let urlString = URL(string: "\(apiHost)/v2/top-headlines?country=\(country)&apiKey=\(apiKey)")
//
//        if let url = urlString {
//            let task = URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
//                if error != nil {
//                    print(error.debugDescription)
//                    self.delegate?.gotError(error: error)
//                } else {
//                    if let usableData = data {
////                        print(usableData)
//                        //Success:
//                        self.delegate?.gotResults(data: usableData)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
}
