//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Ankit Panchal on 09/08/17.
//  Copyright © 2017 Ankit Panchal. All rights reserved.
//

import UIKit
import ObjectMapper
import SVProgressHUD
class ViewController: UIViewController {

    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_email.text = "ankit.p@simformsolutions.com"
        self.txt_password.text = "12345678"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(_ sender: Any) {
//        if(connected() == false){
//            //showNavigationPop(title: Warning, message: MCheckInternet, AlertType: 2)
//            return
//        }
        
        if(self.txt_email.text!.isEmptyField())
        {
            //showNavigationPop(title: Warning, message: MEmptyEmail, AlertType: 2)
            return
        }
        
        if(self.txt_email.text?.isValidEmail() == false)
        {
            //showNavigationPop(title: Warning, message: MValidEmail, AlertType: 2)
            return
        }
        
        if(self.txt_email.text!.isEmptyField())
        {
            //showNavigationPop(title: Warning, message: MEmptyPassword, AlertType: 2)
            return
        }
        
        if(self.txt_email.text?.isInValidPassword() == true)
        {
            //showNavigationPop(title: Warning, message: MValidPassword, AlertType: 2)
            return
        }
        
        self.view.endEditing(true)
        
        self.Login()
    }
    func Login()
    {
        var strDeviceToken:NSString? =  UserDefaults.standard.object(forKey: "DeviceToken") as? NSString
        
        if(strDeviceToken == nil)
        {
            strDeviceToken = ""
        }
        SVProgressHUD.show()
        let strToken = UUID().uuidString
        let params:NSDictionary = ["email":self.txt_email.text!,"password":self.txt_password.text!,"device_type":"2","device_id":strToken]
        
        _ = APIManager.apiManager.Login(params: params as! [String : AnyObject],loaderText: "") { (dict, result) in
            
            if(result == APIResult.APISuccess){
                let objUser = Mapper<MUserDetail>().map(JSON: dict!)
                SVProgressHUD.dismiss()
                if(objUser?.result?.user?.isEmailVerified == 1)
                {
                    UserManager.sharedInstance.CurrentUser = objUser
                    UserManager.sharedInstance.saveSharedManager()                    
                   self.performSegue(withIdentifier: "login", sender: self)
                }
                else{
                  
                }
            }
            
        }
        
    }

}

