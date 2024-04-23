//
//  ImageDetailsVC.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 31/03/24.
//  Copyright © 2024 Joy Banerjee. All rights reserved.
//

import UIKit

class ImageDetailsVC: UIViewController {
    //MARK: properties
    @IBOutlet private var imageView: UIImageView!
    
    var networkManager: NetworkManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = NetworkManager()
        
        
    }
    
}
