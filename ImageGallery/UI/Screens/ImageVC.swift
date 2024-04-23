//
//  ImageVC.swift
//  ImageGallery
//
//  Created by Joy Banerjee on 20/01/19.
//  Copyright © 2019 Joy Banerjee. All rights reserved.
//

import UIKit

class ImageVC: UICollectionViewController, UISearchBarDelegate, NetworkRequestHandlerDelegate, UICollectionViewDelegateFlowLayout {
    
    private var networkManager: NetworkManager!
    private var photos: [Safe<Photo>]?
    private var sizes: [Safe<Size>]?
    private let dispatchGroup = DispatchGroup()
    private var spinner : UIView?
    
    private let imageLength : CGFloat = 150.0
    private let itemsPerRow = 2
    
    private let reuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.title = "Image Gallery"
        networkManager = NetworkManager(dispatchGroup: dispatchGroup)
        makeSearchQuery(with: "kitten")
    }
    
    func startRequests(for tag: String) {
        networkManager.getSearchResult(with: tag, completion: { [unowned self] (json: PhotosMap?, error: Error?) in
            self.photos = json?.photos.photo
            UIViewController.removeSpinner(spinner: spinner!)
            DispatchQueue.main.async{
                self.collectionView?.reloadData()
            }
        })
        
        dispatchGroup.notify(queue: .main) {
            //            self.collectionView?.reloadData()
        }
    }
    
    private func makeSearchQuery(with searchText: String?) {
        
        guard let searchText = searchText else { return }
        
        spinner = UIViewController.displaySpinner(onView: self.view)
        startRequests(for: searchText)
    }
    
    // MARK: - NetworkRequestHandler delegate
    func gotResults(data: Data) {
        //JSONSerialization
        
        do {
            let photosMap = try JSONDecoder().decode(PhotosMap.self, from: data)
            self.photos = photosMap.photos.photo
            print("status: \(photosMap.stat))")
            UIViewController.removeSpinner(spinner: spinner!)
        }
        catch {
            print(error.localizedDescription)
            UIViewController.removeSpinner(spinner: spinner!)
            showErrorAlert()
        }
        
    }
    func gotError(error: Error?) {
        //Have to Handle the error
        print(error.debugDescription)
        UIViewController.removeSpinner(spinner: spinner!)
        showErrorAlert()
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
}


// MARK: UICollectionViewDataSource
extension ImageVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionCell
        
        // Configuring the cell
        if let photos = self.photos {
            let photo = photos[indexPath.row]
            if let photoId = photo.value?.id {
                networkManager.getSizes(for: photoId, completion: { [unowned self] (json: SizesMap?, error: Error?) in
                    self.sizes = json?.sizes.size
                    
                    if let sizes = self.sizes, let imageURL = sizes[1].value?.source {
                        print(imageURL)
                        DispatchQueue.main.async(execute: {
                            cell.imgView?.imageFromURL(imageUrl: imageURL)
                        })
                    }
                })
            }
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath) as! SearchCollectionReusableView
            
            if let text = headerView.searchBar.text, !text.isEmpty {
                self.title = text
            }
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let size = self.sizes?[1] {
            if let dimension = (size.value?.height.value ?? size.value?.width.value), let length = Float(dimension) {
                return CGSize(width: CGFloat(length), height: CGFloat(length))
            }
        }
        return CGSize(width: imageLength, height: imageLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (self.view.bounds.width - 2*imageLength)/CGFloat(itemsPerRow+1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellInset = (self.view.bounds.width - 2*imageLength)/CGFloat(itemsPerRow+1)
        return UIEdgeInsets(top: cellInset, left: cellInset, bottom: 0, right: cellInset)
    }
}

//MARK: UISearchbar delegate

extension ImageVC {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        makeSearchQuery(with: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
