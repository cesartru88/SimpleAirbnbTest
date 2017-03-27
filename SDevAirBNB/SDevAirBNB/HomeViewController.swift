//
//  HomeViewController.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 21/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit
import RappleProgressHUD
import GoogleMaps


class HomeViewController: GMapsCLLocationVC,  UITableViewDelegate, UITableViewDataSource {

    var airbnbService : IAirbnbService!
    var airData : IAirbnbListData!
    let placeHandler = PlacesManagement.sharedInstance
    var places : [PlaceModel]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Home"

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Custom Methods
    
    func setupUI(){

        
        places = [PlaceModel]()
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Loading...", attributes: RappleModernAttributes)
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(locationHandler), userInfo: nil, repeats: false)
    }
    
    
    func locationHandler(){

        if CLLocationManager.locationServicesEnabled() == true
        {
            
            let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
            if status == CLAuthorizationStatus.notDetermined
            {
                locationManager.requestWhenInUseAuthorization()
            }else if status == CLAuthorizationStatus.authorizedWhenInUse || status == CLAuthorizationStatus.authorizedAlways{
                self.getPlaces(isLocationEnabled: true)
            }else if status == CLAuthorizationStatus.denied{
                self.getPlaces(isLocationEnabled: false)
            }
            
        } else {
            self.getPlaces(isLocationEnabled: false)
            print("locationServices disenabled")
        }
    }
    
    func getPlaces(isLocationEnabled : Bool){
        
        if isLocationEnabled == true{
        
            geocoder.reverseGeocodeCoordinate(currentLocation) { response, error in
                if let location = response?.firstResult() {

                    let locationM = LocationModel()
                    if let locName = location.locality, let area = location.administrativeArea{
                        if area.lengthOfBytes(using: .utf8) > 0{
                            locationM.locationName = "\(locName), \(area)"
                        }else{
                            locationM.locationName = "\(locName)"
                        }
                    }
                    var coord = CoordinatesModel()
                    coord.latitude = Float(self.currentLocation.latitude)
                    coord.longitude = Float(self.currentLocation.longitude)
                    locationM.coordinates = coord
                    self.requestServicePlace(location: locationM)

                    
                }else if (error != nil){
                    self.showSingleAlertMessage(error: error as NSError?, title: nil, message: nil, completion: nil)
                    RappleActivityIndicatorView.stopAnimating()
                }
            }
        
        }else{
        
            self.requestServicePlace(location: LocationModel())
        }
    }
    
    func requestServicePlace(location : LocationModel){
    
        self.airbnbService.getListFrom(currentLocation: location, client: ClientModel()) { (response, error) in
            if error != nil{
                RappleActivityIndicatorView.stopAnimating()
                self.showSingleAlertMessage(error: error!, title: nil, message: nil, completion: nil)
            }else{
                //print(response!)
                if let successResponse = response as? [String: AnyObject]{
                    
                    let  values : [[String : AnyObject]] = successResponse["search_results"]! as! [[String : AnyObject]]
                    
                    for value in values
                    {
                        
                        let place = self.placeHandler.handleReceivedInformationFromServer(dictionary: ServiceParser.parseResponseTo(dictionary: value), airbnbData: self.airData)
                        self.places.append(place)
                    }
                    self.tableView.reloadData()
                }
                RappleActivityIndicatorView.stopAnimating()
            }
            
        }
    }
    
    //MARK: Location Manager
    
    override func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        super.locationManager(manager, didChangeAuthorization: status)
        if status == CLAuthorizationStatus.authorizedWhenInUse || status == CLAuthorizationStatus.authorizedAlways{
            self.locationManager.startUpdatingHeading()
            Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(locationHandler), userInfo: nil, repeats: false)
        }else{
            
            self.locationHandler()
        }
    }
    
    
    //MARK: - Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return places.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let identifier : String = "PlaceTableViewCell"
        
        let cell: PlaceTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: identifier) as! PlaceTableViewCell
        let placeModel : PlaceModel = places[indexPath.row]
        cell.configureCellWith(model: placeModel, airData: airData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let dict = ["placeId": places[indexPath.row].placeId]
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.dict = dict as [String : AnyObject]?
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    


}
