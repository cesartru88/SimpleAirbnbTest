//
//  IAirbnbService.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 22/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

protocol IAirbnbService {

    
    /**
     Request Search List from endpoint of AirB&B to get a list of places according to the coordinates or place name.
     
     - parameter currentLocation: A location Model to get user's current location.
     - parameter client : ClientModelId
     - parameter response: Response if everything goes right.
     - parameter err: NSerror if something goes wrong during the operation.
     
     */
    func getListFrom(currentLocation: LocationModel, client: ClientModel, CallBack:@escaping (_ response : AnyObject?, _ err: NSError?) -> Void)
    
    /**
     Request Detail if placeModel from endpoint of AirB&B to get a list of places according to the coordinates or place name.
     
     - parameter placeM: PlaceModel.
     - parameter client : ClientModelId
     - parameter response: Response if everything goes right.
     - parameter err: NSerror if something goes wrong during the operation.
     
     */
    func getPlaceDetailFrom(placeM : PlaceModel, client: ClientModel, CallBack:@escaping (_ response : AnyObject?, _ err: NSError?) -> Void)

}
