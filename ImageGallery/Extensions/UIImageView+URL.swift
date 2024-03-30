//
//  UIImageView+URL.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 19/01/19.
//  Copyright © 2019 Joy Banerjee. All rights reserved.
//

import Foundation
import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    public func imageFromURL(imageUrl: URL) {
        
        let cachedImage = imageCache.object(forKey: NSString(string: imageUrl.absoluteString))
        
        if cachedImage != nil {
            // If the image is already cached, serve it
            self.image = cachedImage
            return
        }
        else {
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            activityIndicator.startAnimating()
            if self.image == nil{
                self.addSubview(activityIndicator)
            }
            
            let session = URLSession(configuration: .default)
            
            // This download task will download the contents of the URL
            let downloadTask = session.dataTask(with: imageUrl) { (data, response, error) in
                // The download has finished.
                if let error = error {
                    print("Error downloading the image: \(error)")
                } else {
                    // No errors found.
                    // if we didn't have a response, so checking for that too.
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            // converting that Data into an image
                            DispatchQueue.main.async(execute: { () -> Void in
                                let image = UIImage(data: imageData)
                                activityIndicator.removeFromSuperview()
                                
                                self.image = image
                                imageCache.setObject(image!, forKey: NSString(string: imageUrl.absoluteString)) //cache it
                            })
                        } else {
                            activityIndicator.removeFromSuperview()
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        activityIndicator.removeFromSuperview()
                        print("Couldn't get response code for some reason")
                    }
                }
            }
            downloadTask.resume()
        }
    }
}
