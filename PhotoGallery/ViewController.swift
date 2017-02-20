//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Ahmet Alsan on 17/02/2017.
//  Copyright © 2017 photogallery. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var photos:[Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flickrProvider = FlickrProvider()
        flickrProvider.getPhotosByTag(tag: "moda") { photos in
            self.photos = photos
            self.collectionView?.reloadData()
        }
        
        let screenWidth = UIScreen.main.bounds.width
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! PhotoCell
        
        cell.imageView.image = photos?[indexPath.row].image
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }


}

