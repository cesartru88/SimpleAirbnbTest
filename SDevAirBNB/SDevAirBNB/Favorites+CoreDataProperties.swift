//
//  Favorites+CoreDataProperties.swift
//  
//
//  Created by Cesar Trujillo Cetina on 24/03/17.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites");
    }

    @NSManaged public var favoriteId: String?

}
