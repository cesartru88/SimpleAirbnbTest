//
//  ServiceParser.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 23/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class ServiceParser: NSObject {

    class func parseResponseTo(dictionary: [String : AnyObject]) -> [String: AnyObject]{
    
        var objecDict = [String : AnyObject]()
        
        if let listing = dictionary["listing"] as? [String : AnyObject],
            let placeName = listing["name"] as? String{
            
            objecDict["placeName"] = placeName as AnyObject
            
            if let imageURL = listing["picture_url"] as? String{
                objecDict["imageURL"] = imageURL as AnyObject
            }
            if let placeId = listing["id"] as? Int64{
                objecDict["placeId"] = placeId as AnyObject
            }
            if let latitude = listing["lat"] as? Float{
                objecDict["latitude"] = latitude as AnyObject
            }
            if let longitude = listing["lng"] as? Float{
                objecDict["longitude"] = longitude as AnyObject
            }
            
            if let placeType = listing["property_type"] as? String{
                objecDict["placeType"] = placeType as AnyObject
            }
            if let placeDescription = listing["description"] as? String{
                objecDict["placeDescription"] = placeDescription as AnyObject
            }
            if let bedsNumber = listing["beds"] as? Int{
                objecDict["bedsNumber"] = bedsNumber as AnyObject
            }
            if let roomsNumber = listing["bedrooms"] as? Int{
                objecDict["roomsNumber"] = roomsNumber as AnyObject
            }
            if let roomType = listing["room_type"] as? String{
                objecDict["roomType"] = roomType as AnyObject
            }
            if let address = listing["address"] as? String{
                objecDict["address"] = address as AnyObject
            }
            if let bathNumber = listing["bathrooms"] as? Float{
                objecDict["bathNumber"] = bathNumber as AnyObject
            }
            if let guestNumber = listing["guests_included"] as? Int{
                objecDict["guestNumber"] = guestNumber as AnyObject
            }
        }
        
        if let pricingQ = dictionary["pricing_quote"] as? [String : AnyObject],
            let rate = pricingQ["rate"] as? [String : AnyObject],
            let price = rate["amount"] as? Float{
            objecDict["price"] = price as AnyObject
        }
        
        return objecDict
    }
    
}
