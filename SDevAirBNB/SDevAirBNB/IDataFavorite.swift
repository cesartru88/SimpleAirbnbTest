//
//  IDataFavorite.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 23/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import Foundation

protocol IDataFavorite {
    
    /**
     Function for favoriteModel that retrieves information from the DataBase.
     
     - parameter response: response if everything goes right.
     - parameter err: NSerror if something goes wrong during the operation.
     */
    func retrieveAll(CallBack:(_ response : AnyObject?,_ err: NSError?) -> Void)
    
    /**
     Function to retrieve information from the DataBase with a NSPredicate .
     
     - parameter predicate: NSPredicate to generate query.
     - parameter response: response if everything goes right.
     - parameter err: NSerror if something goes wrong during the operation.
     */
    func retrieveWithPredicate(predicate : NSPredicate, CallBack:(_ response : AnyObject?, _ err: NSError?) -> Void)
    
    
    /**
     insert favoriteModel to DB according to the predicate.
     
     - returns: NSError if something goes wrong.
     */
    func insertObject(dictionary:[String: AnyObject]) -> NSError?
    
    
    /**
     updates favoriteModel from DB according to the predicate.
     
     - parameter predicate: NSPredicate rule to find in table.
     - returns: NSError if something goes wrong.
     */
    func updateObjectInEntity(predicate: NSPredicate, withUpdatedValues dictionary :[String: AnyObject]) -> NSError?
    
    
    /**
     Removes a register from DB according to the predicate.
     
     - parameter predicate: NSPredicate rule to find in table.
     - returns: NSError if something goes wrong.
     */
    func deleteObject(predicate: NSPredicate) -> NSError?
}
