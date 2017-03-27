//
//  UIViewController+SingleAlert.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 17/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func showSingleAlertMessage(error: NSError?, title: String?, message: String?, completion:(()-> ())?) {
        
        var theTitle : String!
        var msage : String!
        
        if error != nil {
            theTitle = "Error"
            print(error!)
            msage = error?.userInfo[NSLocalizedDescriptionKey] != nil ? (error?.userInfo[NSLocalizedDescriptionKey])! as? String : error?.description
            
        }else {
            theTitle = title!
            msage = message!
        }
        
        let errorAlert : UIAlertController = UIAlertController(title: theTitle!, message: msage!, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.cancel) { (action) in
            
            
            if completion != nil{
                completion!()
            }
            
        }
        errorAlert.addAction(cancelAction)
        present(errorAlert, animated: true, completion: nil)
        
    }
    
}

