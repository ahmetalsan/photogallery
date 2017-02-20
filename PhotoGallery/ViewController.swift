//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Ahmet Alsan on 17/02/2017.
//  Copyright © 2017 photogallery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let flickrProvider = FlickrProvider()
        flickrProvider.getPhotosByTag(tag: "moda") { photos in
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

