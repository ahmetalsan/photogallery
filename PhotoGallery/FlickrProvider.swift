//
//  FlickrProvider.swift
//  PhotoGallery
//
//  Created by Ahmet Alsan on 17/02/2017.
//  Copyright © 2017 photogallery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FlickrProvider: BaseProvider {
    
    //https://www.flickr.com/services/api/
    
    let API_URL: String = "https://api.flickr.com/services/rest"
    let API_KEY: String = "93784dfecd6f390c159f7dd1dbb1ba0c"
    let METHOD: String = "flickr.photos.search"
    let FORMAT: String = "json"
    
    func getPhotosByTag(tag: String, callback:@escaping (([Photo]?) -> Void)) {
        //sample flickr get request: https://api.flickr.com/services/rest/?api_key=93784dfecd6f390c159f7dd1dbb1ba0c&method=flickr.photos.search&tags=moda&format=rest
        
        let parameters: Parameters = [
            "api_key": API_KEY,
            "method": METHOD,
            "format": FORMAT,
            "nojsoncallback": "1", //disable json callback
            "tags": tag
        ]
        
        var photos = [Photo]()
        
        Alamofire.request(API_URL, parameters: parameters).responseJSON { response in
            print(response.request!)
            print(response.response!)
            print(response.data!)
            print(response.result)
            
            if let jsonObject = response.result.value {
                let json = JSON(jsonObject)
                let photosJson = json["photos"]["photo"].arrayValue
                
                for photoJson in photosJson {
                    
                    let farmId = photoJson["farm"].stringValue
                    let serverId = photoJson["server"].stringValue
                    let id = photoJson["id"].stringValue
                    let secret = photoJson["secret"].stringValue
                    
                    print("Photo download start with id \(id)")
                    
                    self.downloadImage(farmId: farmId, serverId: serverId, id: id, secret: secret, callback: { image in
                        let photo = Photo(path: "", image: image, description: "")
                        photos.append(photo)
                        
                        print("Photo downloaded with id \(id)")
                        
                        if(photosJson.count == photos.count) {
                            callback(photos)
                        }
                    })
                    
                }
            }
        }
    }
    
    private func downloadImage(farmId: String, serverId: String, id: String, secret: String, callback:@escaping ((UIImage) -> Void)) {
        //flickr farm pattern: https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        
        let url = URL(string: "https://farm\(farmId).staticflickr.com/\(serverId)/\(id)_\(secret).jpg")

        ImageDownloader.downloadImage(url: url!) { image in
            callback(image)
        }
    }
    
    
}
