//
//  GalleryService.swift
//  Imgur CollectionView
//
//  Created by Willian Junior Peres De Pinho on 15/03/20.
//  Copyright © 2020 Willian Pinho. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GalleryService {
    static func getCats(completion: @escaping (_ message: String?, _ galleryItems: [GalleryItem]?) -> Void) {
        let clientID: String = "1ceddedc03a5d71"
        let secretID: String = "63775118a9f912fd91ed99574becf3b375d9eeca"
        let urlPath: String = "https://api.imgur.com/3/gallery/search/"
        
        let parameters = [
            "client_id" : clientID,
            "client_secret" : secretID,
            "grant_type" : "client_credentials",
            "q": "cats"
        ]
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID \(clientID) ",
            "Accept": "application/json"
        ]
        
        guard let url = URL(string: urlPath) else {
            completion("Não foi possível obter a url", nil)
            return
        }
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = json["data"].array
                    var galleryItems = [GalleryItem]()
                    for item in data ?? [] {
                        let gi = GalleryItem(itemUrl: item["images"][0]["link"].stringValue)
                        galleryItems.append(gi)
                    }
                    completion(nil, galleryItems)
                case .failure(let error):
                    completion(error.errorDescription, nil)
                }
        }
        
    }
}
