//
//  Extensions.swift
//  MeditateMe
//
//  Created by Satish Rajpurohit on 04/05/17.
//  Copyright © 2017 Satish Rajpurohit. All rights reserved.
//

import Foundation
import UIKit
// MARK: String Extensions
//--------------------------------------------------------------------------------------
extension String{
    
    
    //--------------------------------------------
    func trimWhiteSpace() -> String? {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    
    //--------------------------------------------
    func trimWhiteSpaceNNewLine() -> String? {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    //--------------------------------------------
    func trimString(_ text: String) -> String? {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: text))
    }
    
    
    
    //--------------------------------------------
    func isValidUrl() -> Bool {
        let urlRegex = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegex)
        return urlTest.evaluate(with: self)
    }
    
    //--------------------------------------------
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    //--------------------------------------------
    func isInValidEmail() -> Bool {
        return !isValidEmail()
    }
    
    //--------------------------------------------
    func isInValidPassword() -> Bool {
        return (self.characters.count < 6) ? (true) : (false)
    }
    
    
    //--------------------------------------------
    func isEmptyField() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

extension UINavigationBar {
    
    func setNavigationBarColor(navigationController : UINavigationController?,
                               color : UIColor,textColor:UIColor) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar .setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        if(color == UIColor.white){
            navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: UIColor(white:0.88, alpha:1.0))
        }
        else{
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = color
        navigationController?.navigationBar.backgroundColor =  color
        navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Gotham-Book", size: 16)!,  NSForegroundColorAttributeName: textColor]
    }
    
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
    class func imageWithColorSize(color: UIColor, size: CGSize) -> UIImage
    {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}


