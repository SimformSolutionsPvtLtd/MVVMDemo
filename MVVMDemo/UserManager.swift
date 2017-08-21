//
//  UserManager.swift
//  Jobalo
//
//  Created by Satish Rajpurohit on 25/01/17.
//  Copyright © 2017 Satish Rajpurohit. All rights reserved.
//

import UIKit

//
//  SharedManager.swift

import Foundation

//
//  SharedManager.swift


import UIKit
import ObjectMapper

class UserManager : NSObject,NSCoding {
    
    var CurrentUser : MUserDetail?


    
    struct Static {
        
        static let instance = UserManager().loadInstance()
    }
    
    // this is the Swift way to do singletons
    class var sharedInstance: UserManager
    {
        return Static.instance
    }
    
    
    override init() {
    }
    
    func filePath() -> String {
        
        let filePath : String
        //
        //        if (filePath != nil)  {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        filePath = documents.appending("/UserManager")
        //        }
        
        return filePath
    }
    
    func loadInstance() -> UserManager {
        
        
        let decodedData = NSData(contentsOfFile: UserManager().filePath())
        
        if decodedData != nil {
            
            
            let data = NSKeyedUnarchiver.unarchiveObject(with: decodedData as! Data) //NSKeyedUnarchiver.unarchiveObject(with: decodedData! as Data) as! UserManager
            print("test1")
            return data as! UserManager
            
        }
        
        print("test2")
        return UserManager()
        
    }
    
    func saveSharedManager() {
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self)
        do {
            
            try encodedData.write(to: URL(fileURLWithPath: self.filePath()))
        } catch {
            print("error :\(error)")
        }
       
    }
    
    func resetSharedManager() {
        
       self.CurrentUser = nil
        self.saveSharedManager()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
         self.CurrentUser = aDecoder.decodeObject(forKey: "123") as? MUserDetail
      
        super.init()
    }
    
    
    
    public func encode(with aCoder: NSCoder) {
        
        if self.CurrentUser != nil{
            aCoder.encode(self.CurrentUser, forKey: "123")
        }
        
        

    }
    
    
}
