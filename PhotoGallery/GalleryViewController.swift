//
//  GalleryViewController.swift
//  PhotoGallery
//
//  Created by Ahmet Alsan on 17/02/2017.
//  Copyright © 2017 photogallery. All rights reserved.
//

import UIKit

class GalleryViewController: UICollectionViewController {

    var photos:[Photo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loadingGroup = STLoadingGroup(side: 50, style: .zhihu)
        loadingGroup.show(view)
        loadingGroup.startLoading()
        
        let flickrProvider = FlickrProvider()
        flickrProvider.getPhotosByTag(tag: "moda") { photos in
            loadingGroup.stopLoading()
            self.photos = photos
            self.collectionView?.reloadData()
        }
        
        makeEqualSizeOfCells(horizontalCellCount: 3)
    }
    
    func makeEqualSizeOfCells(horizontalCellCount: Int) {
        let screenWidth = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth/CGFloat(horizontalCellCount), height: screenWidth/CGFloat(horizontalCellCount))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! PhotoViewCell
        cell.photo = photos?[indexPath.row]
        cell.imageView.image = photos?[indexPath.row].image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! GalleryDetailViewController
        let photoCell = sender as! PhotoViewCell
        
        vc.photo = photoCell.photo
    }

}

