//
//  APIManager.swift
//  ISO
//

//
import Foundation

import AFNetworking
import CoreLocation


// we need a custom serializer for AFNetworking to be able to get at response data after an error (particularly for registration errors)
class JobaloJSONResponseSerializer: AFJSONResponseSerializer {
    
    
    
}

enum APIResult : NSInteger
{
    case APISuccess = 0,APIFail,APIError
}

public class APIManager {
    
    //service complition block
    typealias ServiceComplitionBlock = ([String : AnyObject]? ,APIResult)  -> Void
    
    // static properties get lazy evaluation and dispatch_once_t for free
    struct Static {
        static let instance = APIManager()
    }
    
    // this is the Swift way to do singletons
    class var apiManager: APIManager {
        return Static.instance
    }
    
    public class APIConstants {
        
        // URL construction
      
        //static let baseUrl: String = "http://simform.solutions/meditate-me-backend/public/api/v1/"
        static let baseUrl: String = "http://brainsync.simform.solutions/api/v1/"
      //  static let baseUrl: String = "http://simform.solutions/meditemp/public/api/v1/"
        static let signup : String = "signup"
        static let login : String = "login"
        static let verificationEmail : String = "email-resend"
        static let forgotPassword : String = "forgot-password"
        static let category : String = "category"
        static let meditation : String = "meditation/"
        static let allMeditation : String = "meditation"
        static let purchase : String = "meditation/purchase"
        static let logout: String = "logout"
        static let trackHistory:String = "play-history"
    }
    // needed for all AFNetworking requests
    let manager =  AFHTTPSessionManager()
    
    // needed for session token persistence
    let userDefaults = UserDefaults.standard
    
    
    init()
    {
        
    }
    func clearSession() {
        
        
    }
    
    
    
    
    func SignUp(params : [String : AnyObject],loaderText:String , successClosure: @escaping ServiceComplitionBlock) {
        
        self.showLoader(message: loaderText)
        
        let url = APIConstants.baseUrl + APIConstants.signup
        
        self.postDatadicFromUrl(url: url, dic: params) { (response, result) -> Void in
            
            
            if (result == APIResult.APISuccess) {
                
                
                successClosure(response , result)
                 self.hideLoader()
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
            }
           
        }
    }
    
    func Login(params : [String : AnyObject],loaderText:String , successClosure: @escaping ServiceComplitionBlock) {
        
        self.showLoader(message: loaderText)
        
        let url = APIConstants.baseUrl + APIConstants.login
        
        self.postDatadicFromUrl(url: url, dic: params) { (response, result) -> Void in
            
            
            if (result == APIResult.APISuccess) {
                
               
                successClosure(response , result)
                 self.hideLoader()
                
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                //self.hideLoader()
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
                //self.hideLoader()
            }
            
        }
    }
    
    func Logout(loaderText:String , successClosure: @escaping ServiceComplitionBlock) {
        
        self.showLoader(message: loaderText)
        
        let url = APIConstants.baseUrl + APIConstants.logout
        self.getDatadicFromUrl(url: url, dic: [:]) { (response, result) in
            if (result == APIResult.APISuccess) {
                
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
            }
            self.hideLoader()
        }
    }

    
    func verificationEmail(params : [String : AnyObject],loaderText:String , successClosure: @escaping ServiceComplitionBlock) {
        
        self.showLoader(message: loaderText)
        
        let url = APIConstants.baseUrl + APIConstants.verificationEmail
        
        self.postDatadicFromUrl(url: url, dic: params) { (response, result) -> Void in
            
            
            if (result == APIResult.APISuccess) {
                
                
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
            }
            self.hideLoader()
        }
    }

    
    func forgotPasword(params : [String : AnyObject],loaderText:String , successClosure: @escaping ServiceComplitionBlock) {
        
        self.showLoader(message: loaderText)
        
        let url = APIConstants.baseUrl + APIConstants.forgotPassword
        
        self.postDatadicFromUrl(url: url, dic: params) { (response, result) -> Void in
            
            
            if (result == APIResult.APISuccess) {
                
                
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
            }
            self.hideLoader()
        }
    }
    
    func getCategorys(params:[String : AnyObject],loaderText:String,ShowLoader:Bool,successClosure: @escaping ServiceComplitionBlock){
        if(ShowLoader == true){
            self.showLoader(message: loaderText)
        }
        let url = APIConstants.baseUrl + APIConstants.category
        self.getDatadicFromUrl(url: url, dic: params) { (response, result) -> Void in
            
            if (result == APIResult.APISuccess) {
                
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
            }
           // self.hideLoader()
            
        }
    }
    
    func getMeditation(params:[String : AnyObject],mediateId:Int,loaderText:String,ShowLoader:Bool,successClosure: @escaping ServiceComplitionBlock){
        
        if(ShowLoader == true){
            self.showLoader(message: loaderText)
        }
        let url = APIConstants.baseUrl + APIConstants.meditation + "\(mediateId)"
        self.getDatadicFromUrl(url: url, dic: params) { (response, result) -> Void in
            
            if (result == APIResult.APISuccess) {
                
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
            }
            self.hideLoader()
            
        }
    }

    func getAllMeditation(params:[String : AnyObject],loaderText:String,ShowLoader:Bool,successClosure: @escaping ServiceComplitionBlock){
        
       
        
        if(ShowLoader == true){
            self.showLoader(message: loaderText)
        }
        let url = APIConstants.baseUrl + APIConstants.allMeditation
        self.getDatadicFromUrl(url: url, dic: params) { (response, result) -> Void in
            
            if (result == APIResult.APISuccess) {
                
                successClosure(response , result)
                self.hideLoader()
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                //self.hideLoader()
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
                self.hideLoader()
            }
            
            
        }
    }
    func trakHistory(params:[String : AnyObject],loaderText:String,ShowLoader:Bool,successClosure: @escaping ServiceComplitionBlock){
        if(ShowLoader == true){
            self.showLoader(message: loaderText)
        }
        let url = APIConstants.baseUrl + APIConstants.trackHistory
        self.postDatadicFromUrl(url: url, dic: params) { (response, result) -> Void in
            
            if (result == APIResult.APISuccess) {
                
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
            }
            // self.hideLoader()
            
        }
    }
    
    func purchaseMeditate(params:[String : AnyObject],loaderText:String,successClosure: @escaping ServiceComplitionBlock){
        
        self.showLoader(message: loaderText)
        let url = APIConstants.baseUrl + APIConstants.purchase
        self.postDatadicFromUrl(url: url, dic: params) { (response, result) -> Void in
            
            if (result == APIResult.APISuccess) {
                
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIError) {
                successClosure(response , result)
                
            }
                
            else if (result == APIResult.APIFail) {
                successClosure(response , result)
            }
            self.hideLoader()
            
        }
    }

    
    //MARK: - POST methods -
    func postDicMethodForStoreHistory(url : String, dic : [String : AnyObject] , block: @escaping ServiceComplitionBlock)  {
        do{
            let config = URLSessionConfiguration.default
            let man = AFURLSessionManager.init(sessionConfiguration: config)
            let urlS = URL(string: url)
            var request = URLRequest(url: urlS!)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if (UserManager.sharedInstance.CurrentUser?.result?.userSession?.sessionToken != nil) {
                if let session = UserManager.sharedInstance.CurrentUser?.result?.userSession?.sessionToken {
                    request.setValue(session, forHTTPHeaderField: "session-token")
                }else{
                    request.setValue("", forHTTPHeaderField: "session-token")
                }
            }
            request.httpMethod = "POST"
            let reqData = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = reqData
            
            let dataTask = man.dataTask(with: request) { (resps, data, error) in
                if (error != nil){
                    print(error!)
                    if let _ : Data = (error! as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data
                    {
                        if let  errResponse: String = String(data: ((error! as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as! Data), encoding: String.Encoding.utf8)
                        {
                            
                            let responseHeader = resps as! HTTPURLResponse
                            
                            if (responseHeader.statusCode == 403) {
                                
                            }
                            
                            NSLog("%@", errResponse)
                            
                            if let dictError = self.convertToDictionary(text: errResponse)
                            {
                                let message:String = dictError["message"]! as! String
                               
                            }
                            
                        }
                    }
                    
                }else{
                    
                    print(data!)
                    let responseDict: [String : AnyObject]
                    if let resdata = data as? Data{
                          responseDict = try! JSONSerialization.jsonObject(with: resdata, options: .allowFragments) as! [String : AnyObject]
                    }else{
                        responseDict = data as! [String : AnyObject]
                    }
                    
                    let responseHeader = resps as! HTTPURLResponse
                    
                    self.printJsonFromParams(Printdict: responseDict,Printurl: url)
                    
                    if (responseHeader.statusCode == 200) {
                        
                        block(responseDict , APIResult.APISuccess)
                    }
                    else{
                        block(responseDict , APIResult.APIError)
                    }

                }
            }
            dataTask.resume()

        }catch{
            print(exception())
        }
        block([:],APIResult.APIError)
    }
    func postDatadicFromUrl(url : String, dic : [String : AnyObject] , block: @escaping ServiceComplitionBlock)
    {
        
        self.printJsonFromParams(Printdict: dic,Printurl: url)
        manager.requestSerializer = AFJSONRequestSerializer()
        //        manager.requestSerializer.cachePolicy = .returnCacheDataElseLoad
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        manager.requestSerializer.timeoutInterval = 30
        
        if (UserManager.sharedInstance.CurrentUser?.result?.userSession?.sessionToken != nil) {
            
            if let session = UserManager.sharedInstance.CurrentUser?.result?.userSession?.sessionToken {
                manager.requestSerializer.setValue(session, forHTTPHeaderField: "session-token")
            }else{
                manager.requestSerializer.setValue("", forHTTPHeaderField: "session-token")
            }
        }
        manager.post(url, parameters: dic, progress: nil, success: { (sessiondata, result) in
            
            do {
                
                let responseDict = try JSONSerialization.jsonObject(with: (result as! NSData) as Data, options: .allowFragments) as! [String : AnyObject]
                
                let responseHeader = sessiondata.response as! HTTPURLResponse
                
                self.printJsonFromParams(Printdict: responseDict,Printurl: url)
                
                if (responseHeader.statusCode == 200) {
                    
                    block(responseDict , APIResult.APISuccess)
                }
                else{
                    block(responseDict , APIResult.APIError)
                }
                
                
            } catch let error as NSError {
                print(error)
                self.hideLoader()
                
            }
            
        }) { (errorSessionData, result) -> Void in
            
            
            self.hideLoader()
            
            if let _ : Data = (result as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data
            {
                if let  errResponse: String = String(data: ((result as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as! Data), encoding: String.Encoding.utf8)
                {
                    
                    let responseHeader = errorSessionData?.response as! HTTPURLResponse
                    
                    if (responseHeader.statusCode == 403) {
                      
                    }
                    
                    NSLog("%@", errResponse)
                    
                    if let dictError = self.convertToDictionary(text: errResponse)
                    {
                        let message:String = dictError["message"]! as! String
                        
                    }
                    
                }
            }
        }
        
        block([:],APIResult.APIError)
        
    }
    
    
    //Multipart
    func uploadDataWithMultipart(url : String, dic : [String : AnyObject] , multipartImageData : Data? , block: @escaping ServiceComplitionBlock)
    {
        self.printJsonFromParams(Printdict: dic,Printurl: url)
        
        manager.requestSerializer = AFHTTPRequestSerializer()
        //        manager.requestSerializer.cachePolicy = .returnCacheDataElseLoad
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.timeoutInterval = 30
//        
//        if (UserManager.sharedInstance.CurrentUser?.result?.userSession?.sessionToken != nil) {
//            
//            let session:String =  (UserManager.sharedInstance.CurrentUser?.result?.userSession?.sessionToken!)!
//            manager.requestSerializer.setValue(session, forHTTPHeaderField: "session-token")
//            
//        }
        
        
        manager.post(url, parameters: dic, constructingBodyWith: { (multipartData) in
            
            if (multipartImageData != nil) {
                //let imgData = UIImageJPEGRepresentation(multipartImageData!, 0.3)
                
                multipartData.appendPart(withFileData: multipartImageData! as Data, name: "avatar", fileName: "icon.jpg", mimeType: "image/jpeg")
                
            }
            
            
        }, progress: {(progress) in }, success: {(sessionDatatask , responseObject) in
            
            do {
                let responseDict = try JSONSerialization.jsonObject(with: (responseObject as! NSData) as Data, options: .allowFragments) as! [String : AnyObject]
                print ("responseDict====\(responseDict)")
                self.hideLoader()
                let responseHeader = sessionDatatask.response as! HTTPURLResponse
                
                if (responseHeader.statusCode ==  200) {
                    
                    block(responseDict , APIResult.APISuccess)
                    
                }
                else {
                    block(responseDict , APIResult.APIError)
                }
                
                
                // use jsonObject here
            } catch {
                
                print("json error: \(error)")
                self.hideLoader()
            }
            
            
            
        }) { (errorSessionData, result) -> Void in
            
            
            self.hideLoader()
            
            if let _ : Data = (result as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data
            {
                if let  errResponse: String = String(data: ((result as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as! Data), encoding: String.Encoding.utf8)
                {
                    
                    let responseHeader = errorSessionData?.response as! HTTPURLResponse
                    
                    if (responseHeader.statusCode == 403) {
                    }
                    
                    NSLog("%@", errResponse)
                    
                    if let dictError = self.convertToDictionary(text: errResponse)
                    {
                        let message:String = dictError["message"]! as! String
                       // AGPushNoteView.show(withNotificationMessage: message)
                    }
                    
                }
            }
        }
        block([:],APIResult.APIError)
        
    }
    
    
    //GET
    func getDatadicFromUrl(url : String, dic : [String : AnyObject] , block: @escaping ServiceComplitionBlock)
    {
        self.printJsonFromParams(Printdict: dic,Printurl: url)
        
        manager.requestSerializer = AFHTTPRequestSerializer()
        //manager.requestSerializer.cachePolicy = .returnCacheDataElseLoad
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.timeoutInterval = 30
        
        if (UserManager.sharedInstance.CurrentUser?.result?.userSession?.sessionToken != nil) {
            
            let session:String =  (UserManager.sharedInstance.CurrentUser?.result?.userSession?.sessionToken!)!
            manager.requestSerializer.setValue(session, forHTTPHeaderField: "session-token")
            
        }
        
        manager.get(url, parameters: dic, progress: nil, success: {(sessionDatatask , responseObject) in
            do {
                let responseDict = try JSONSerialization.jsonObject(with: (responseObject as! NSData) as Data, options: .allowFragments) as! [String : AnyObject]
               // print ("responseDict====\(responseDict)")
                self.printJsonFromParams(Printdict: responseDict,Printurl: url)
                let responseHeader = sessionDatatask.response as! HTTPURLResponse
                
                if (responseHeader.statusCode ==  200) {
                    
                    block(responseDict , APIResult.APISuccess)
                }
                else {
                    block(responseDict , APIResult.APIError)
                }
                
                
                // use jsonObject here
            } catch {
                //KVNProgress.dismiss()
                print("json error: \(error)")
                self.hideLoader()
            }
            
        }) { (errorSessionData, result) -> Void in
            
            self.hideLoader()
            
            if let _ : Data = (result as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data
            {
                if let  errResponse: String = String(data: ((result as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as! Data), encoding: String.Encoding.utf8)
                {
                    let responseHeader = errorSessionData?.response as! HTTPURLResponse
                    
                    if (responseHeader.statusCode == 403) {
                       
                    }
                    
                    NSLog("%@", errResponse)
                    
                    if let dictError = self.convertToDictionary(text: errResponse)
                    {
                        let message:String = dictError["message"]! as! String
                       // AGPushNoteView.show(withNotificationMessage: message)
                    }
                    
                }
            }
            
            
        }
        
        block([:],APIResult.APIError)
    }
    
    //DELETE
    
    func deleteDatadicFromUrl(url : String, dic : [String : AnyObject] , block: @escaping ServiceComplitionBlock)
    {
        self.printJsonFromParams(Printdict: dic,Printurl: url)
        
        manager.requestSerializer = AFHTTPRequestSerializer()
        //        manager.requestSerializer.cachePolicy = .returnCacheDataElseLoad
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.timeoutInterval = 30
        
        manager.delete(url, parameters: dic, success: {(sessionDatatask , responseObject) in
            do {
                let responseDict = try JSONSerialization.jsonObject(with: (responseObject as! NSData) as Data, options: .allowFragments) as! [String : AnyObject]
                print ("responseDict====\(responseDict)")
                
                let responseHeader = sessionDatatask.response as! HTTPURLResponse
                
                if (responseHeader.statusCode ==  200) {
                    
                    
                    let dicResult =  String(describing: responseDict["result"]!)
                    
                    
                    if dicResult  == "1"
                    {
                        block(responseDict , APIResult.APISuccess)
                    }
                    else
                    {
                        
                        
                        block(responseDict , APIResult.APIError)
                    }
                }
                else {
                    block(responseDict , APIResult.APIError)
                }
                
                
                // use jsonObject here
            } catch {
                
                print("json error: \(error)")
                self.hideLoader()
            }
            
        }) { (data, result) -> Void in
            
            
            self.hideLoader()
            
            if let _ : Data = (result as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? Data
            {
                if let  errResponse: String = String(data: ((result as NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as! Data), encoding: String.Encoding.utf8)
                {
                    
                    NSLog("%@", errResponse)
                    
                    if let dictError = self.convertToDictionary(text: errResponse)
                    {
                        let message:String = dictError["message"]! as! String
                        //AGPushNoteView.show(withNotificationMessage: message)
                    }
                    
                }
            }
        }
        
        block([:],APIResult.APIError)
    }
    
    
    func printJsonFromParams(Printdict:[String : AnyObject],Printurl:String)
    {
        
        print(Printurl)
        
        do {
            
            //Convert to Data
            let jsonData = try JSONSerialization.data(withJSONObject: Printdict, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            
            //In production, you usually want to try and cast as the root data structure. Here we are casting as a dictionary. If the root object is an array cast as [AnyObject].
            var json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject]
            
            print(json)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    func showLoader(message:String)
    {
        DispatchQueue.main.async{
           
        }
        
    }
    
    func hideLoader()
    {
        
    }
    
    
}
