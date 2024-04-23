//
//  BoxBind.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 18/01/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

//import Foundation

class Bind<T> {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
