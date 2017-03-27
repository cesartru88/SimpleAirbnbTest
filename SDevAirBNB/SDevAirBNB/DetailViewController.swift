//
//  DetailViewController.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 24/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit
import GoogleMaps
import RappleProgressHUD


class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPlaceType: UILabel!
    @IBOutlet weak var roomType: UILabel!
    @IBOutlet weak var lblGuestNum: UILabel!
    @IBOutlet weak var lblBedNum: UILabel!
    @IBOutlet weak var lblbedsNum: UILabel!
    @IBOutlet weak var lblBathroomNum: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var airbnbService : IAirbnbService!
    var airData : IAirbnbListData!
    var favData : IDataFavorite!
    
    private let placeHandler = PlacesManagement.sharedInstance
    private var isFavoriteEnabled : Bool!
    var dict : [String : AnyObject]?
    var favorite : FavoriteModel?
    private var place : PlaceModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Methods
    
    func setupUI(){
        self.title  = "Detail"
        if dict != nil{
            
            RappleActivityIndicatorView.startAnimatingWithLabel("Loading...", attributes: RappleModernAttributes)
            
            placeHandler.handlePlaceDetail(dictionary: self.dict!, airbnbData: self.airData, airService: self.airbnbService, CallBack: { (placeM, error) in
                
                RappleActivityIndicatorView.stopAnimating()

                if error != nil{
                    self.showSingleAlertMessage(error: error, title: nil, message: nil, completion: {
                        if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                        }
                    })
                    return
                }else{
                    self.place = placeM!
                    self.loadViewInfo(object: placeM)
                }
            })
        }else if favorite != nil{
        
            loadViewInfo(object: favorite!)
        }
    
        self.setRightButton()
    }

    func setRightButton(){
        
        if dict != nil{
            let placeId = dict?["placeId"]! as! Int64
            let locPredicate = NSPredicate(format: "placeId == %i", placeId)
            favData.retrieveWithPredicate(predicate: locPredicate, CallBack: { (object, error) in

                let btn1 = UIButton(type: .custom)
                btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                btn1.addTarget(self, action: #selector(self.handleFavoriteButton), for: .touchUpInside)
                let favBtn = UIBarButtonItem(customView: btn1)
                
                if error != nil{
                    self.showSingleAlertMessage(error: error, title: nil, message: nil, completion: nil)
                }else if (object?.count)! > 0{
                    self.isFavoriteEnabled = true
                    btn1.setImage(UIImage(named: "favOn"), for: .normal)
                }else if (object?.count)! == 0{
                    self.isFavoriteEnabled = false
                    btn1.setImage(UIImage(named: "favOff"), for: .normal)
                }
                self.navigationItem.rightBarButtonItem = favBtn
            })
        }
    }
    
    func handleFavoriteButton(){
        self.navigationItem.rightBarButtonItem = nil

        let btn1 = UIButton(type: .custom)

        if isFavoriteEnabled == true{
            isFavoriteEnabled = false
            btn1.setImage(UIImage(named: "favOff"), for: .normal)
            self.favoriteDBHandler()
        }else{
            isFavoriteEnabled = true
            btn1.setImage(UIImage(named: "favOn"), for: .normal)
            self.favoriteDBHandler()
        }
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.handleFavoriteButton), for: .touchUpInside)
        let favBtn = UIBarButtonItem(customView: btn1)
        self.navigationItem.rightBarButtonItem = favBtn
    }
    
    func favoriteDBHandler(){
        if isFavoriteEnabled == true{
            
            var favoriteDict = DBParser.parseFromAn(object: self.place)
            favoriteDict["favoriteId"] = UUID().uuidString as AnyObject?
            let error = favData.insertObject(dictionary: favoriteDict)
            if error != nil{
                self.showSingleAlertMessage(error: error, title: nil, message: nil, completion: nil)
            }

        }else{
            let placeId = dict?["placeId"]! as! Int64
            let favPredicate = NSPredicate(format: "placeId == %i", placeId)
            let error = favData.deleteObject(predicate: favPredicate)
            if error != nil{
                self.showSingleAlertMessage(error: error, title: nil, message: nil, completion: nil)
            }
        }
    
    }
    func loadViewInfo<T>(object : T){

        
        let place = object as! FavoriteModel
        
        if let imageData = place.image{
            self.imgView.image = UIImage(data: imageData)
        }else{
            self.imgView.downloadedFrom(link: place.imageURL!, Callback: { (response) in
            })
            self.imgView.contentMode = .scaleToFill
        }
        if let name = place.placeName{
            self.lblName.text = name
        }
        if let price = place.price{
            self.lblPrice.text = "$\(price) USD"
        }
        if let rooms = place.roomsNumber{
            self.lblBedNum.text = "\(rooms)"
        }
        if let address = place.address{
            self.lblAddress.text = address
        }
        if let guests = place.guestNumber{
            self.lblGuestNum.text = "\(guests)"
        }
        if let ptype = place.placeType{
            self.lblPlaceType.text = ptype
        }
        if let roomType = place.roomType{
            self.roomType.text = roomType
        }
        if let baths = place.bathNumber{
            self.lblBathroomNum.text = "\(baths)"
        }
        if let beds = place.bedsNumber{
            self.lblbedsNum.text = "\(beds)"
        }
        if let desc = place.placeDescription{
            self.textView.text = desc
        }
        
        if let coordinat3s = place.locationCoordinates{
            self.setMap(cordinates: coordinat3s)
        }

    }
    
    func setMap(cordinates : CoordinatesModel){
    
        let coord = CLLocationCoordinate2D(latitude: Double(cordinates.latitude), longitude: Double(cordinates.longitude))
        let camera = GMSCameraPosition.camera(withLatitude: coord.latitude,
                                              longitude: coord.longitude, zoom: 16)
        
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = coord
        marker.title = "Location"
        marker.map = self.mapView

    }
}
