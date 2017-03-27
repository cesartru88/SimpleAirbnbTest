//
//  IDataManager.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 17/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import Foundation

protocol IDataManager {
    /**
     Retrieves all information from an Entity or Table from Database (Select * From ).
     
     - parameter entityName: Entity Name or Table name.
     - parameter response: response if everything goes right.
     - parameter err: NSerror if something goes wrong during the operation.
     
     
     */
    func retrieveAllFromEntity(entityName : String, CallBack:(_ response : AnyObject?,_ err: NSError?) -> Void)
    
    
    /**
     Returns objects that match the predicate.
     
     - parameter predicate: NSPredicate rule to find in table.
     - parameter entity: Entity Name or Table name.
     - parameter response: response if everything goes right.
     - parameter err: NSerror if something goes wrong during the operation.
     */
    func retrieveWithPredicate(predicate : NSPredicate, fromEntity entity : String, CallBack:(_ response : AnyObject?, _ err: NSError?) -> Void)
    
    
    /**
     Inserts a register into DB.
     
     - parameter entity: Entity Name or Table name.
     - parameter dictionary: NSDictionary that contains object information.
     
     - returns: NSError if something goes wrong.
     */
    func insertObjectInEntity(entity: String, dictionary:[String: AnyObject]) -> NSError?
    
    /**
     Updates a register into DB according to the predicate.
     
     - parameter entityName: Entity Name or Table name.
     - parameter predicate: NSPredicate rule to find in table.
     - parameter dictionary: NSDictionary that contains object information.
     
     - returns: NSError if something goes wrong.
     */
    func updateObjectInEntity(entityName : String, predicate: NSPredicate, withUpdatedValues dictionary :[String: AnyObject]) -> NSError?
    
    
    /**
     Removes a register from DB according to the predicate.
     
     - parameter entityName: Entity Name or Table name.
     - parameter predicate: NSPredicate rule to find in table.
     
     - returns: NSError if something goes wrong.
     */
    func deleteObjectInEntity(entityName : String, predicate: NSPredicate) -> NSError?
    
}

