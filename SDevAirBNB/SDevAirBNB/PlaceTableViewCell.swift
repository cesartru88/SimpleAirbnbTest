//
//  PlaceTableViewCell.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 21/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWith<T>(model: AnyObject, airData : T){
       
        let placeM = model as! PlaceModel
        
        if let img = placeM.image{
        
            self.imgView.image = UIImage(data: img)
        }else if let imgURL = placeM.imageURL{
            self.imgView.downloadedFrom(link: imgURL, Callback: { (ready) in
                                
                let image = UIImagePNGRepresentation((self.imgView.image)!)!
                if airData is IAirbnbListData{
                
                    let data = airData as! IAirbnbListData
                    let predicateData = NSPredicate(format: "placeId = %i", placeM.placeId)
                    let errorx =  data.updateObjectInEntity(predicate: predicateData, withUpdatedValues: ["image": image as AnyObject])
                    if errorx != nil{
                        print(errorx!)
                    }
                }else if airData is IDataFavorite{
                    let data = airData as! IDataFavorite
                    let predicateData = NSPredicate(format: "placeId = %i", placeM.placeId)
                    let errorx =  data.updateObjectInEntity(predicate: predicateData, withUpdatedValues: ["image": image as AnyObject])
                    if errorx != nil{
                        print(errorx!)
                    }
                }
            })

        }
        
        if let name = placeM.placeName{
            self.lblName.text = name
        }
        if let type = placeM.placeType{
            self.lblType.text = type
        }
        if let price = placeM.price{
            self.lblCost.text = "$\(price) USD"
        }
    }

    
}
