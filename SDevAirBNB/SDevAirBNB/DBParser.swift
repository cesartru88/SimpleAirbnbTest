//
//  DBParser.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 23/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit
import CoreData

extension NSObject {
    class func entity() -> Self {
        return self.init()
    }
}
class DBParser: NSObject {
    
    class func fromNSManageObjectToDictionary(object : AnyObject) -> [String: AnyObject]{
        
        let theObject: NSManagedObject = object as! NSManagedObject
        
        let keys = Array(theObject.entity.attributesByName.keys)
        let dict = theObject.dictionaryWithValues(forKeys: keys)
        return dict as [String : AnyObject]
        
    }
    
    class func parseFrom<T>(dictionary : [String : AnyObject]) -> T{
    
        let model = FavoriteModel()
        
        if let favoriteId = dictionary["favoriteId"] as? String{
            
            model.favoriteId = favoriteId
        }
        
        if let placeId = dictionary["placeId"] as? Int64{
            model.placeId = placeId
        }
        if let placeName = dictionary["placeName"] as? String{
            model.placeName = placeName
        }
        if let price = dictionary["price"] as? Float{
            model.price = price
        }
        if let placeType = dictionary["placeType"] as? String{
            model.placeType = placeType
        }
        if let imageURL = dictionary["imageURL"] as? String{
            model.imageURL = imageURL
        }
        if let hasDetail = dictionary["hasDetail"] as? Bool{
            model.hasDetail = hasDetail
        }
        if let image = dictionary["image"] as? Data{
            model.image = image
        }
        var coordinate : CoordinatesModel = CoordinatesModel()
        var latitude = Float()
        var longitude = Float()
        
        if let lat = dictionary["latitude"] as? Float{
            latitude = lat
        }
        if let lng = dictionary["longitude"] as? Float{
            longitude = lng
        }
        coordinate.latitude = latitude
        coordinate.longitude = longitude
        
        model.locationCoordinates = coordinate
    
        if let placeDescription = dictionary["placeDescription"] as? String{
            model.placeDescription = placeDescription
        }
        if let bedsNumber = dictionary["bedsNumber"] as? Int{
            model.bedsNumber = bedsNumber
        }
        if let roomsNumber = dictionary["roomsNumber"] as? Int{
            model.roomsNumber = roomsNumber
        }
        if let roomType = dictionary["roomType"] as? String{
            model.roomType = roomType
        }
        if let bathNumber = dictionary["bathNumber"] as? Float{
            model.bathNumber = bathNumber
        }
        if let address = dictionary["address"] as? String{
            model.address = address
        }
        if let guestNumber = dictionary["guestNumber"] as? Int{
            model.guestNumber = guestNumber
        }
        
        return model as! T
    }
    
    
    //MODEL TO DICTIONARY
    class func parseFromAn<T>(object : T) -> [String : AnyObject]{
        
        var dictionary = [String : AnyObject]()

        let favoriteModel = object as! FavoriteModel
        
        if let favoriteId = favoriteModel.favoriteId{
            dictionary["favoriteId"] = favoriteId as AnyObject?
        }
        
        if let placeId = favoriteModel.placeId{
            dictionary["placeId"] = placeId as AnyObject?
        }
        
        if let placeName = favoriteModel.placeName{
             dictionary["placeName"] = placeName as AnyObject?
        }
        if let price = favoriteModel.price{
           dictionary["price"] = price as AnyObject?
        }
        if let placeType = favoriteModel.placeType{
             dictionary["placeType"] = placeType as AnyObject?
        }
        if let imageURL = favoriteModel.imageURL{
            dictionary["imageURL"] = imageURL as AnyObject?
        }
        if let hasDetail = favoriteModel.hasDetail{
            dictionary["hasDetail"] = hasDetail as AnyObject?
        }
        if let image = favoriteModel.image{
            dictionary["image"]  = image as AnyObject?
        }
        if let coordinates = favoriteModel.locationCoordinates{
            dictionary["latitude"] = coordinates.latitude as AnyObject?
            dictionary["longitude"] = coordinates.longitude as AnyObject?
        }
        
        if let placeDescription = favoriteModel.placeDescription{
             dictionary["placeDescription"] = placeDescription as AnyObject?
        }
        if let bedsNumber =  favoriteModel.bedsNumber{
            dictionary["bedsNumber"] = bedsNumber as AnyObject?
        }
        if let roomsNumber = favoriteModel.roomsNumber{
            dictionary["roomsNumber"] = roomsNumber as AnyObject?
        }
        if let roomType = favoriteModel.roomType{
             dictionary["roomType"] = roomType as AnyObject?
        }
        if let bathNumber = favoriteModel.bathNumber{
             dictionary["bathNumber"] = bathNumber as AnyObject?
        }
        if let address = favoriteModel.address{
            dictionary["address"] = address as AnyObject?
        }
        if let guestNumber = favoriteModel.guestNumber{
             dictionary["guestNumber"] = guestNumber as AnyObject?
        }
        
        return dictionary
        
    }

}

