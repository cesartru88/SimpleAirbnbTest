//
//  PlaceMarker.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 26/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import GoogleMaps

class PlaceMarker: GMSMarker {
    
    let place: PlaceModel
    
    
    init(place: PlaceModel) {
        self.place = place
        super.init()
        
        let coord = CLLocationCoordinate2D(latitude: Double((place.locationCoordinates?.latitude)!), longitude: Double((place.locationCoordinates?.longitude)!))
        
        if let price = place.price{
            self.title = "$\(price) USD"
        }else{
            self.title = "$ 0.0 USD"
            
        }
        
        self.position = coord


        icon = UIImage(named: "PlaceMarker")
        appearAnimation = kGMSMarkerAnimationPop
    }

    
}
