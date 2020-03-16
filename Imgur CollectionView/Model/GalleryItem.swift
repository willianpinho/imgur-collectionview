//
//  GalleryItem.swift
//  Imgur CollectionView
//
//  Created by Willian Junior Peres De Pinho on 15/03/20.
//  Copyright © 2020 Willian Pinho. All rights reserved.
//

import Foundation
import SwiftyJSON

class GalleryItem {
    var itemUrl: String
    
    init(itemUrl: String) {
        self.itemUrl = itemUrl
    }
    
    func initFromJSON(json: JSON) -> GalleryItem? {
        if let link = json["link"].string {
            return GalleryItem(itemUrl: link)
        } else {
            debugPrint("bad json \(json)")
            return nil
        }
    }
}
