//
//  IAirbnbListData.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 23/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import Foundation

//Desacoplando todo, por eso creamos otras interfaces.

protocol IAirbnbListData {
    

    /**
        Retrieves a list of places.
     
     - parameter response: A List of places.
     - parameter err: If something goes wrong returns an NSError
     
     */
    func retrieveAll(CallBack:(_ response : AnyObject?,_ err: NSError?) -> Void)
    
    /**
     Retrieves a list of places, according to the NSpredicate.
     
     - parameter predicate: An NSPredicate.
     - parameter response: A List of places.
     - parameter err: If something goes wrong returns an NSError
     */
    func retrieveWithPredicate(predicate : NSPredicate, CallBack:(_ response : AnyObject?, _ err: NSError?) -> Void)
    /**
     Updates a place, according to the NSpredicate.
     
     - parameter predicate: An NSPredicate.
     - parameter dictionary: A dictionary with values to change.
     - returns an NSError If something goes wrong returns an NSError
     */
    func updateObjectInEntity(predicate: NSPredicate, withUpdatedValues dictionary :[String: AnyObject]) -> NSError?
    
    
    /**
     Insert a place.
     - parameter dictionary: A dictionary with values to change.
     - returns an NSError If something goes wrong returns an NSError
     */
    func insertObject(dictionary:[String: AnyObject]) -> NSError?
    /**
     Deletes a place, according to the NSpredicate.
     
     - parameter predicate: An NSPredicate.
     - returns an NSError If something goes wrong returns an NSError
     */
    func deleteObject(predicate: NSPredicate) -> NSError?

}
