//
//  BoxBind.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 18/01/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

import Foundation


class BoxBind<T> {
    
//    typealias boxListener = (T) -> ()
    
    var listener: ((T) -> ())?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: ((T) -> ())?) {
        self.listener = listener
        listener?(value)
    }
    
}





class MyBox<T> {
    
    var listener: ((T) -> ())?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: ((T) -> ())?) {
        self.listener = listener
        listener?(value)
    }
}
