//
//  LocationModel.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 22/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class LocationModel: NSObject {

    var locationName : String!
    var coordinates : CoordinatesModel?
    var locale : String!
    var currency : String!

    override init(){
        self.locale = "en-US"
        self.currency = "USD"
        self.locationName = "Los Angeles, CA"
    }

}
