//
//  IProxyService.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 22/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import Foundation

protocol IProxyService {
    
    /**
     Use Get Method from HTTP to exchange information with the server.
     
     - parameter URL: URL From server.
     - parameter paramters: Dictionary from parameters to send to the server.
     - parameter headers: Dictionary from headers [string: string] to send to the server.
     - parameter timeOutInterval : A period of time in seconds for timeout if nil take default value
     - parameter response: Response if everything goes right.
     - parameter err: NSerror if something goes wrong during the operation.
     
     */
    func getFromAPI(URL: String, parameters : [String : AnyObject]?, headers: [String: String]?, timeOutInterval : Int?, CallBack:@escaping (_ response : AnyObject?, _ err: NSError?) -> Void)
    /**
     Use POST Method from HTTP to exchange information with the server.
     
     - parameter URL: URL From server.
     - parameter paramters: Dictionary from parameters to send to the server.
     - parameter headers: Dictionary from headers [string: string] to send to the server.
     - parameter timeOutInterval : A period of time in seconds for timeout if nil take default value
     - parameter response: Response if everything goes right.
     - parameter err: NSerror if something goes wrong during the operation.
     
     */
    func postToAPI(URL : String, parameters : [String : AnyObject]?, headers: [String: String]?,  timeOutInterval : Int?, CallBack:@escaping (_ response : AnyObject?, _ err: NSError?) -> Void)
    
    

}
