//
//  DataManager.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 17/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit
import CoreData


class DataManager: IDataManager {
    
    let MOC : NSManagedObjectContext!
    
    init(moc : NSManagedObjectContext!) {
        self.MOC = moc!
    }
    
    func retrieveAllFromEntity(entityName : String, CallBack:(_ response : AnyObject?,_ err: NSError?) -> Void){
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: MOC)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try MOC.fetch(fetchRequest)
            
            CallBack(result as AnyObject?, nil)
            
            
        } catch {
            let fetchError = error as NSError
            CallBack(nil, fetchError)
            
        }
    }
    
    func retrieveWithPredicate(predicate : NSPredicate, fromEntity entity : String, CallBack:(_ response : AnyObject?, _ err: NSError?) -> Void){
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        fetchRequest.predicate = predicate
        
        do{
            let fr = try MOC.fetch(fetchRequest)
            CallBack( fr as AnyObject?, nil)
            
        }catch{
            let error = error as NSError
            CallBack(nil, error)
        }
        
    }
    
    
    func insertObjectInEntity(entity: String, dictionary:[String: AnyObject]) -> NSError?{
        
        // Create Entity
        let entityGlobal = NSEntityDescription.entity(forEntityName: entity, in: MOC)
        let entity = NSManagedObject(entity: entityGlobal!, insertInto: MOC)
        
        let keysArray = [String] (dictionary.keys)
        let componentArray = Array(dictionary.values)
        
        for i in 0 ..< dictionary.count {
            entity.setValue(componentArray[i], forKey: keysArray[i])
        }
        
        do {
            try entity.managedObjectContext?.save()
            return nil
        } catch {
            let saveError = error as NSError
            return saveError
        }
    }
    
    
    func updateObjectInEntity(entityName : String, predicate: NSPredicate, withUpdatedValues dictionary :[String: AnyObject]) -> NSError?{
        
        var manageObjects : [NSManagedObject]?
        var saveError : NSError?
        
        self.retrieveWithPredicate(predicate: predicate, fromEntity: entityName) { (response, err) in
            if (err != nil){
                saveError = err
            }else{
                manageObjects = response as? [NSManagedObject]
            }
        }
        if (saveError != nil) {
            return saveError
        }
        
        let entity : NSManagedObject? =  (manageObjects != nil && (manageObjects?.count)! > 0) ? manageObjects![0] : nil
        
        if entity != nil {
            
            let keysArray = [String] (dictionary.keys)
            let componentArray = Array(dictionary.values)
            
            for i in 0 ..< dictionary.count {
                entity!.setValue(componentArray[i], forKey: keysArray[i])
            }
            
            do {
                try entity!.managedObjectContext?.save()
                return nil
            } catch {
                saveError = error as NSError
                return saveError
            }
            
        }
        
        return nil
        
    }
    
    func deleteObjectInEntity(entityName : String, predicate: NSPredicate) -> NSError?{
        
        var manageObjects : [NSManagedObject]?
        var deleteError : NSError?
        
        self.retrieveWithPredicate(predicate: predicate, fromEntity: entityName) { (response, err) in
            if (err != nil){
                deleteError = err
            }else{
                manageObjects = response as? [NSManagedObject]
            }
        }
        if (deleteError != nil) {
            return deleteError
        }
        
        let entity : NSManagedObject? =  (manageObjects != nil && (manageObjects?.count)! > 0) ? manageObjects![0] : nil
        
        if entity != nil {
            
            MOC.delete(entity!)
            
            do {
                try MOC.save()
                return nil
            } catch {
                deleteError = error as NSError
                return deleteError
            }
            
        }
        
        return nil
    }
    
}

