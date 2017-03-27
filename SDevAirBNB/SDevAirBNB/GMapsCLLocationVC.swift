//
//  GMapsCLLocationVC.swift
//  SDevAirBNB
//
//  Created by Cesar Trujillo Cetina on 25/03/17.
//  Copyright © 2017 CESARTRUJILLOSOFT. All rights reserved.
//

import UIKit
import GoogleMaps

class GMapsCLLocationVC: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()

    var mapView = GMSMapView()
    var counter : Int = 0
    let geocoder = GMSGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()

        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - CoreLocationDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse || status == CLAuthorizationStatus.authorizedAlways{
            mapView.isMyLocationEnabled = true
            self.locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if counter < 7{
            
            counter += 1
            let location = locations.last
            if location?.coordinate.latitude != nil{
                
                
                self.currentLocation = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
                let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!,
                                                      longitude: (location?.coordinate.longitude)!, zoom: self.mapView.camera.zoom)
                mapView.animate(to: camera)
            }
        }else{
            
            self.locationManager.stopUpdatingLocation()
            counter = 0
        }
    }
    
    //MARK: - GoogleMaps

}
