//
//  Result.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 10/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import Foundation
import ObjectMapper
class Result : NSObject, NSCoding, Mappable{
    
    var user : User?
    var userSession : UserSession?
    
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        user <- map["user"]
        userSession <- map["user_session"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        user = aDecoder.decodeObject(forKey: "user") as? User
        userSession = aDecoder.decodeObject(forKey: "user_session") as? UserSession
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        if userSession != nil{
            aCoder.encode(userSession, forKey: "user_session")
        }
        
    }
    
}
