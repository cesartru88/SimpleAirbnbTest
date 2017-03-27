//
//  Places+CoreDataProperties.swift
//  
//
//  Created by Cesar Trujillo Cetina on 24/03/17.
//
//

import Foundation
import CoreData


extension Places {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Places> {
        return NSFetchRequest<Places>(entityName: "Places");
    }

    @NSManaged public var address: String?
    @NSManaged public var bathNumber: String?
    @NSManaged public var bedsNumber: Int16
    @NSManaged public var guestNumber: Int16
    @NSManaged public var image: NSData?
    @NSManaged public var imageURL: String?
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var placeDescription: String?
    @NSManaged public var placeId: Int64
    @NSManaged public var placeName: String?
    @NSManaged public var placeType: String?
    @NSManaged public var price: Float
    @NSManaged public var roomsNumber: Int16
    @NSManaged public var roomType: String?
    @NSManaged public var hasDetail: Bool

}
