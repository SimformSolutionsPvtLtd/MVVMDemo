//
//  ContainerViewModel.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 10/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import UIKit

class ContainerViewModel: UIView {
   @IBOutlet weak var btnRefresh : UIButton!
    
    //MARK:- Public variables
    var btnRefreshComplition : ((_ btnRefresh : UIButton) -> Void)? = nil //btn close clouser
    var beforeComplition: (() -> Void)? = nil
    var Completion: (([String : AnyObject]?) -> Void)? = nil
    var Failure: (() -> Void)? = nil
    @IBAction func btnCloseClick(button:UIButton) {
        
        guard btnRefreshComplition != nil else {
            return
        }
        
        btnRefreshComplition!(button)
    }
    func requestAlbumList() -> Void {
        callHideUnHideCompletion()
        _ = APIManager.apiManager.getAllMeditation(params: [:], loaderText: "",ShowLoader: false, successClosure: { (dict, result) in
            
            if(result == APIResult.APISuccess){
                self.callCompletion(dict: dict!)
            }else{
                self.callFailure()
            }
        })
        
    }
    func callHideUnHideCompletion() -> Void {
        guard self.beforeComplition != nil else {
            return
        }
        self.beforeComplition!()
    }
    func callCompletion(dict:[String:AnyObject]) -> Void {
        guard self.Completion != nil else {
            return
        }
        self.Completion!(dict)
    }
    func callFailure() -> Void {
        guard self.Failure != nil else {
            return
        }
        self.Failure!()
        
    }
}
