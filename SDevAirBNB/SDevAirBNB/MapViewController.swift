//
//  MapViewController.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 21/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: GMapsCLLocationVC, GMSMapViewDelegate{

    var airData : IAirbnbListData!
    var places : [PlaceModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        airData.retrieveAll { (objects, error) in
            if error != nil{
                self.showSingleAlertMessage(error: error, title: nil, message: nil, completion: nil)
            }else{
                if (objects?.count)! > 0{
                    places = objects as! [PlaceModel]
                    for place in places{
                        self.setMarkerWith(place: place)
                    
                    }
                }

            }
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Map"
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Methods
    
    func setupUI(){
        self.title = "Map"
        
        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.latitude,
                                              longitude: currentLocation.longitude, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        self.view = mapView
    
    }
    
    func setMarkerWith(place : PlaceModel){
        
        let markerMap = PlaceMarker(place: place)
        markerMap.map = mapView
        
    }
    
    //MARK: MapDelegation
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        if marker is PlaceMarker {
            let placeData = marker as! PlaceMarker
            let dict = ["placeId": placeData.place.placeId]
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            detailVC.dict = dict as [String : AnyObject]?
            self.navigationController?.pushViewController(detailVC, animated: true)

        }
    }
    


    

}
