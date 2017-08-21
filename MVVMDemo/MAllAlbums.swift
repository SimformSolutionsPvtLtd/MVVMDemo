//
//  AllAlbums.swift
//  MeditateMe
//
//  Created by Satish Rajpurohit on 30/05/17.
//  Copyright © 2017 Satish Rajpurohit. All rights reserved.
//

import UIKit
import ObjectMapper


class MAllAlbums : Mappable{
    
    var androidId : String?
    var audio : String?
    var avatar : String?
    var categoryMeditation : [CategoryMeditation]?
    var createdAt : String?
    var descriptionField : String?
    var descriptionHtml : String?
    var id : Int?
    var instructions : String?
    var iphoneId : String?
    var isPurchased : Bool?
    var name : String?
    var price : Int?
    var subliminal : String?
    var track : [Track]?
    
    
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map)
    {
        androidId <- map["android_id"]
        audio <- map["audio"]
        avatar <- map["avatar"]
        categoryMeditation <- map["category_meditation"]
        createdAt <- map["created_at"]
        descriptionField <- map["description"]
        descriptionHtml <- map["description_html"]
        id <- map["id"]
        instructions <- map["instructions"]
        iphoneId <- map["iphone_id"]
        isPurchased <- map["is_purchased"]
        name <- map["name"]
        price <- map["price"]
        subliminal <- map["subliminal"]
        track <- map["track"]
        
    }
}





