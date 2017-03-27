//
//  AirbnbService.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 22/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class AirbnbService: IAirbnbService {

    
    let proxy : IProxyService!
    let config : ConfigApp!
    
    init(proxy: IProxyService) {
        self.proxy = proxy
        self.config = ConfigApp.sharedInstance
    }
    
    func getListFrom(currentLocation: LocationModel, client: ClientModel, CallBack:@escaping (_ response : AnyObject?, _ err: NSError?) -> Void){
        
        
        var parameters = ["client_id": client.clientId!,
                          "locale" : currentLocation.locale!,  "currency" : currentLocation.currency!,
                          "guests" : client.guests!, "min_beds": client.min_beds!, "_format": "for_search_results_with_minimal_pricing", "_limit": 30, "ib_add_photo_flow" : true, "min_num_pic_urls" : 1, "sort" : 1] as [String : Any]
        
        if let location = currentLocation.locationName{
            parameters["location"] = location
        }
        
        if let location : CoordinatesModel = currentLocation.coordinates{
            parameters["user_lat"] = location.latitude
            parameters["user_lng"] = location.longitude
        }
        
        let encodedURL = "\(self.config.getServerURL())search_results"
        proxy.getFromAPI(URL: encodedURL, parameters: parameters as [String : AnyObject] , headers: nil, timeOutInterval: nil) { (response, error) in
            
            if error != nil {
                CallBack(nil, error)
            }else{
                CallBack(response as AnyObject?, nil)
            }
        }
        
    }
    
    
    func getPlaceDetailFrom(placeM : PlaceModel, client: ClientModel, CallBack:@escaping (_ response : AnyObject?, _ err: NSError?) -> Void){
    
        let encodedURL = "\(self.config.getServerURL())listings/\(placeM.placeId!)"
        
        let parameters = ["client_id" : "3092nxybyb0otqw18e8nh5nty" as AnyObject,
                          "_format" : "v1_legacy_for_p3" as AnyObject ] as [String : AnyObject]
        
        proxy.getFromAPI(URL: encodedURL, parameters: parameters as [String : AnyObject], headers: nil, timeOutInterval: nil) { (response, error) in
            
            if error != nil {
                CallBack(nil, error!)
            }else{
                CallBack(response as AnyObject?, nil)
            }
        }

    }
}
