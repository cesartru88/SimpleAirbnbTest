//
//  ProxyService.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 22/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit
import Alamofire


class ProxyService: IProxyService {

    var manager = Alamofire.SessionManager.default
    
    //MARK: - Get Values
    
    func getFromAPI(URL: String, parameters : [String : AnyObject]?, headers: [String: String]?, timeOutInterval : Int?, CallBack:@escaping (_ response : AnyObject?, _ err: NSError?) -> Void){
        
        var interval = 60
        if timeOutInterval != nil{
            interval = timeOutInterval!
        }
        manager.session.configuration.timeoutIntervalForRequest = TimeInterval(interval)
        
        let headersx: HTTPHeaders? = headers
        
        manager.request(URL, parameters: parameters, headers : headersx)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                if(response.result.error != nil){
                    CallBack(nil, response.result.error as NSError?)
                }
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    CallBack(JSON as AnyObject?, nil)
                }
        }
        
    }
    
    func postToAPI(URL : String, parameters : [String : AnyObject]?, headers: [String: String]?,  timeOutInterval : Int?, CallBack:@escaping (_ response : AnyObject?, _ err: NSError?) -> Void){
        
        var interval = 60
        if timeOutInterval != nil{
            interval = timeOutInterval!
        }
        manager.session.configuration.timeoutIntervalForRequest = TimeInterval(interval)
        
        let headersx: HTTPHeaders? = headers
        
        manager.request(URL, method: .post, parameters: parameters, headers : headersx)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                if(response.result.error != nil){
                    CallBack(nil, response.result.error as NSError?)
                }
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    CallBack(JSON as AnyObject?, nil)
                }
        }
        
    }
}
