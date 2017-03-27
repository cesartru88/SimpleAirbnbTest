//
//  DataFavorite.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 23/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class DataFavorite: IDataFavorite {
    
    
    let dataMgr : IDataManager!
    
    init(dataManager: IDataManager) {
        self.dataMgr = dataManager
    }
    
    
    func retrieveAll(CallBack:(_ response : AnyObject?,_ err: NSError?) -> Void)
    {
        
        dataMgr.retrieveAllFromEntity(entityName: "Favorites", CallBack: { (objects, error) in
            if error != nil{
                
                CallBack(nil, error)
            }else{
                var ArrModel = [FavoriteModel]()
                
                for x in  objects as! NSArray{
                    
                    let dictX =  DBParser.fromNSManageObjectToDictionary(object: x as AnyObject)
                    let model : FavoriteModel = DBParser.parseFrom(dictionary: dictX) as FavoriteModel
                    ArrModel.append(model)
                }
                CallBack(ArrModel as AnyObject?, nil)
            }
        })
    }
    
    
    func retrieveWithPredicate(predicate : NSPredicate, CallBack:(_ response : AnyObject?, _ err: NSError?) -> Void){
        
        dataMgr.retrieveWithPredicate(predicate: predicate, fromEntity: "Favorites", CallBack: { (objects, error) in
            if error != nil{
                CallBack(nil, error)
            }else{
                var ArrModel = [FavoriteModel]()
                
                for x in  objects as! NSArray{
                    
                    let dictX =  DBParser.fromNSManageObjectToDictionary(object: x as AnyObject)
                    let model : FavoriteModel = DBParser.parseFrom(dictionary: dictX) as FavoriteModel
                    ArrModel.append(model)
                }
                CallBack(ArrModel as AnyObject?, nil)
            }
        })
    }
    func insertObject(dictionary:[String: AnyObject]) -> NSError?{
        
        return dataMgr.insertObjectInEntity(entity: "Favorites", dictionary: dictionary)
    }
    
    
    func updateObjectInEntity(predicate: NSPredicate, withUpdatedValues dictionary :[String: AnyObject]) -> NSError?{
        
        return dataMgr.updateObjectInEntity(entityName: "Favorites", predicate: predicate, withUpdatedValues: dictionary)
    }
    
    
    func deleteObject(predicate: NSPredicate) -> NSError?{
        
        return dataMgr.deleteObjectInEntity(entityName: "Favorites", predicate: predicate)
    }
}
