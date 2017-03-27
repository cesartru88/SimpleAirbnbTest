//
//  PlaceModel.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 22/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class PlaceModel: NSObject {

    var placeId : Int64!
    var placeName : String?
    var price : Float?
    var placeType : String?
    var image : Data?
    var imageURL : String?
    
    var locationCoordinates : CoordinatesModel?
    var placeDescription : String?
    var bedsNumber : Int?
    var roomsNumber : Int?
    var roomType : String?
    var bathNumber : Float?
    var address : String?
    var guestNumber : Int?
    var hasDetail : Bool!
    
    override init() {
        self.hasDetail = false
    }
    
}
