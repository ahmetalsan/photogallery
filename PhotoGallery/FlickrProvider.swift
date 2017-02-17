//
//  FlickrProvider.swift
//  PhotoGallery
//
//  Created by Ahmet Alsan on 17/02/2017.
//  Copyright © 2017 photogallery. All rights reserved.
//

import UIKit
import Alamofire

class FlickrProvider: BaseProvider {
    
    static let URL: String = "https://api.flickr.com/services/rest"
    static let API_KEY: String = "93784dfecd6f390c159f7dd1dbb1ba0c"
    static let METHOD: String = "flickr.photos.search"
    static let FORMAT: String = "json"
    
    static func getPhotosByTag(tag: String, callback:(([Photo]) -> Void)) {
        //sample flickr get request: https://api.flickr.com/services/rest/?api_key=93784dfecd6f390c159f7dd1dbb1ba0c&method=flickr.photos.search&tags=moda&format=rest
        
        let parameters: Parameters = [
            "api_key": API_KEY,
            "method": METHOD,
            "format": FORMAT,
            "nojsoncallback": "1", //disable json callback
            "tags": tag
        ]
        
        Alamofire.request(URL, parameters: parameters).responseJSON { response in
            print(response.request!)
            print(response.response!)
            print(response.data!)
            print(response.result)
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}
