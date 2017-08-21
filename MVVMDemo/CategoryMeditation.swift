//
//  CategoryMeditation.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 10/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryMeditation : Mappable{
    
    var categoriesId : Int?
    var createdAt : AnyObject?
    var id : Int?
    var meditationsId : Int?
    required init?(map: Map) {
        
    }
    func mapping(map: Map)
    {
        categoriesId <- map["categories_id"]
        createdAt <- map["created_at"]
        id <- map["id"]
        meditationsId <- map["meditations_id"]
        
    }
    
}
