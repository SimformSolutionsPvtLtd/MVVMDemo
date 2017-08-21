//
//  UserSession.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 10/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import Foundation
import ObjectMapper
class UserSession : NSObject, NSCoding, Mappable{
    
    var createdAt : String?
    var deviceId : String?
    var id : Int?
    var sessionToken : String?
    var updatedAt : String?
    var userId : Int?
    
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        createdAt <- map["created_at"]
        deviceId <- map["device_id"]
        id <- map["id"]
        sessionToken <- map["session_token"]
        updatedAt <- map["updated_at"]
        userId <- map["user_id"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        deviceId = aDecoder.decodeObject(forKey: "device_id") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        sessionToken = aDecoder.decodeObject(forKey: "session_token") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        userId = aDecoder.decodeObject(forKey: "user_id") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if deviceId != nil{
            aCoder.encode(deviceId, forKey: "device_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if sessionToken != nil{
            aCoder.encode(sessionToken, forKey: "session_token")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }
        
    }
    
}
