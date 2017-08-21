//
//  User.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 10/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import Foundation
import ObjectMapper
class User : NSObject, NSCoding, Mappable{
    
    var createdAt : String?
    var deletedAt : AnyObject?
    var email : String?
    var facebookId : String?
    var id : Int?
    var isEmailVerified : Int?
    var name : String?
    var roleId : Int?
    var updatedAt : String?
    var verificationToken : String?
    
    
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        createdAt <- map["created_at"]
        deletedAt <- map["deleted_at"]
        email <- map["email"]
        facebookId <- map["facebook_id"]
        id <- map["id"]
        isEmailVerified <- map["is_email_verified"]
        name <- map["name"]
        roleId <- map["role_id"]
        updatedAt <- map["updated_at"]
        verificationToken <- map["verification_token"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        deletedAt = aDecoder.decodeObject(forKey: "deleted_at") as? AnyObject
        email = aDecoder.decodeObject(forKey: "email") as? String
        facebookId = aDecoder.decodeObject(forKey: "facebook_id") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        isEmailVerified = aDecoder.decodeObject(forKey: "is_email_verified") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        roleId = aDecoder.decodeObject(forKey: "role_id") as? Int
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        verificationToken = aDecoder.decodeObject(forKey: "verification_token") as? String
        
    }
    
    func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if deletedAt != nil{
            aCoder.encode(deletedAt, forKey: "deleted_at")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if facebookId != nil{
            aCoder.encode(facebookId, forKey: "facebook_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isEmailVerified != nil{
            aCoder.encode(isEmailVerified, forKey: "is_email_verified")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if roleId != nil{
            aCoder.encode(roleId, forKey: "role_id")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }
        if verificationToken != nil{
            aCoder.encode(verificationToken, forKey: "verification_token")
        }
        
    }
    
}
