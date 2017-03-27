//
//  ConfigApp.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 17/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class ConfigApp: NSObject {
    
    
    let path : String!
    let dictionary : NSDictionary!
    
    
    static let sharedInstance : ConfigApp = {
        let instance = ConfigApp()
        return instance
    }()
    
    override  init() {
        
        path  = Bundle.main.path(forResource: "ConfigApp", ofType: "plist")
        dictionary = NSDictionary(contentsOfFile: path!)
    }
    
    
    func isInProductionEnviroment() -> Bool{
        
        return  dictionary!["production"] as! Bool
    }
    
    
    func getServerURL() -> String{
        
        return  (dictionary!["production"] as! Bool) ? dictionary!["url_release"] as! String : dictionary!["url_debug"] as! String
    }
    
    
    
}
