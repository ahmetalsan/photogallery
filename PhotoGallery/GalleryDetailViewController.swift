//
//  GalleryDetailViewController.swift
//  PhotoGallery
//
//  Created by Ahmet Alsan on 20/02/2017.
//  Copyright © 2017 photogallery. All rights reserved.
//

import UIKit

class GalleryDetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = photo?.image
        
        //TODO
        //Add photo desc
        //Add photo title
        
    }
    
}
