//
//  AirbnbListData.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 23/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class AirbnbListData: IAirbnbListData {

    let dataMgr : IDataManager!
    
    init(dataManager: IDataManager) {
        self.dataMgr = dataManager
    }
    
    
    func retrieveAll(CallBack:(_ response : AnyObject?,_ err: NSError?) -> Void)
    {
        
        dataMgr.retrieveAllFromEntity(entityName: "Places", CallBack: { (objects, error) in
            if error != nil{
                
                CallBack(nil, error)
            }else{
                var ArrModel = [PlaceModel]()
                
                for x in  objects as! NSArray{
                    
                    let dictX =  DBParser.fromNSManageObjectToDictionary(object: x as AnyObject)
                    let model : PlaceModel = DBParser.parseFrom(dictionary: dictX) as PlaceModel
                    ArrModel.append(model)
                }
                CallBack(ArrModel as AnyObject?, nil)
            }
        })
    }
    
    
    func retrieveWithPredicate(predicate : NSPredicate, CallBack:(_ response : AnyObject?, _ err: NSError?) -> Void){
        
        dataMgr.retrieveWithPredicate(predicate: predicate, fromEntity: "Places", CallBack: { (objects, error) in
            if error != nil{
                CallBack(nil, error)
            }else{
                var ArrModel = [PlaceModel]()
                
                for x in  objects as! NSArray{
                    
                    let dictX =  DBParser.fromNSManageObjectToDictionary(object: x as AnyObject)
                    let model : PlaceModel = DBParser.parseFrom(dictionary: dictX) as PlaceModel
                    ArrModel.append(model)
                }
                CallBack(ArrModel as AnyObject?, nil)
            }
        })
    }
    func insertObject(dictionary:[String: AnyObject]) -> NSError?{
        
        return dataMgr.insertObjectInEntity(entity: "Places", dictionary: dictionary)
    }
    
    
    func updateObjectInEntity(predicate: NSPredicate, withUpdatedValues dictionary :[String: AnyObject]) -> NSError?{
        
        return dataMgr.updateObjectInEntity(entityName: "Places", predicate: predicate, withUpdatedValues: dictionary)
    }
    
    
    func deleteObject(predicate: NSPredicate) -> NSError?{
        
        return dataMgr.deleteObjectInEntity(entityName: "Places", predicate: predicate)
    }

}
