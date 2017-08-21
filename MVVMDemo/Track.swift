//
//  Track.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 10/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import Foundation
import ObjectMapper

class Track : Mappable{
    
    var audio : String?
    var createdAt : String?
    var id : Int?
    var meditationId : Int?
    var meditationType : Int?
    var name : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        audio <- map["audio"]
        createdAt <- map["created_at"]
        id <- map["id"]
        meditationId <- map["meditation_id"]
        meditationType <- map["meditation_type"]
        name <- map["name"]
        
    }
    
}
