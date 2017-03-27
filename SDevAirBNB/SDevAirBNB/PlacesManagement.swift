//
//  PlacesManagement.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 24/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class PlacesManagement: NSObject {

    
    //MARK: Shared Instance
    
    static let sharedInstance : PlacesManagement = {
        let instance = PlacesManagement()
        return instance
    }()
    
    func handleReceivedInformationFromServer(dictionary : [String : AnyObject], airbnbData : IAirbnbListData) -> PlaceModel{
        var aPlace = PlaceModel()
        
        if let placeId = dictionary["placeId"] as? Int64{
           
            let predicate = NSPredicate(format: "placeId == %i", placeId)

            
            airbnbData.retrieveWithPredicate(predicate: predicate, CallBack: { (object, error) in
                if error == nil && (object?.count)! > 0{
                
                    let places = object as! [PlaceModel]
                    aPlace = places[0]
                    
                }else if((object?.count)! == 0){
                    
                    aPlace.placeId = placeId
                    aPlace.placeName = dictionary["placeName"] as! String!
                    var coordintes = CoordinatesModel()
                    if let latitude = dictionary["latitude"] as? Float{
                        coordintes.latitude = latitude
                    
                    }
                    if let longitude = dictionary["longitude"] as? Float{
                        coordintes.longitude = longitude
                        aPlace.locationCoordinates = coordintes
                    }
                    
                    aPlace.imageURL = dictionary["imageURL"] as! String!
                    aPlace.placeType = dictionary["placeType"] as! String!
                    aPlace.price = dictionary["price"] as! Float!
                    let theError = (airbnbData.insertObject(dictionary: dictionary))
                    if theError != nil{
                        print(theError!)
                    }
                    
                }else if error != nil{
                
                    print(error!)
                }
                
            })
        }
        
        return aPlace
    }
    
    func handlePlaceDetail(dictionary : [String : AnyObject], airbnbData : IAirbnbListData, airService : IAirbnbService, CallBack:@escaping(_ aPlace : PlaceModel?, _ errorx : NSError?) -> Void){
        var aPlace = PlaceModel()
        
        if let placeId = dictionary["placeId"] as? Int64{
            
            let predicatePlace = NSPredicate(format: "placeId == %i", placeId)
            
            
            airbnbData.retrieveWithPredicate(predicate: predicatePlace, CallBack: { (object, error) in
                //If Object exists in DB
                if error == nil && (object?.count)! > 0{
                    
                    //Verify if it already has detailed information
                    let hasDetailPredicate = NSPredicate(format: "placeId == %i && hasDetail == %@", placeId, NSNumber(booleanLiteral: true))
                    airbnbData.retrieveWithPredicate(predicate: hasDetailPredicate, CallBack: { (place, error_) in
                        if error_ != nil{
                            print(error!)
                            CallBack(nil, error)
                            //if it has information return it back
                        }else if place != nil && (place?.count)! > 0{
                            let places = place as! [PlaceModel]
                            aPlace = places[0]
                            CallBack(aPlace, nil)

                            //Doesn't exist lets updateTheObject
                        }else if place != nil && (place?.count)! == 0{
        
                            var newDict = [String : AnyObject]()
                            let placeM = PlaceModel()
                            placeM.placeId = placeId
                            
                            airService.getPlaceDetailFrom(placeM: placeM, client: ClientModel(), CallBack: { (response, sError) in
                                newDict = ServiceParser.parseResponseTo(dictionary: response as! [String : AnyObject])
                                
                                newDict["hasDetail"] = true as AnyObject?
                                let erro = airbnbData.updateObjectInEntity(predicate: predicatePlace, withUpdatedValues: newDict)
                                if erro != nil{
                                    print(erro!)
                                    CallBack(nil, error)
                                }
                                
                                airbnbData.retrieveWithPredicate(predicate: predicatePlace, CallBack: { (plac3, error) in
                                    if error == nil && (plac3?.count)! > 0{
                                        let places = plac3 as! [PlaceModel]
                                        aPlace = places[0]
                                        CallBack(aPlace, nil)
                                        
                                    }else if error != nil{
                                        CallBack(nil, error)
                                    }
                                })
                            })
                        }
                    })
                    
                }else if error != nil{
                    CallBack(nil, error)
                    print(error!)
                }
            })
        }
    }
}
