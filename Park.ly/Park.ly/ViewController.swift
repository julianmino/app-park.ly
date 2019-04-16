//
//  ViewController.swift
//  Park.ly
//
//  Created by Julian Mino on 3/30/19.
//  Copyright © 2019 Julian Mino. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController{

    @IBOutlet weak var parkButton: RoundButton!
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 500
    
    var parkedCarAnnotation : ParkingSpot?
    override func viewDidLoad() {
        super.viewDidLoad()
       mapView.delegate = self
        LocationService.instance.locationManager.requestWhenInUseAuthorization()
        checkLocationAuthorizationStatus()
    }

    @IBAction func onPressedParkButton(_ sender: Any) {
                if mapView.annotations.count == 1 {
                    print("hola")
                mapView.addAnnotation(parkedCarAnnotation!)
                parkButton.setImage(UIImage(named: "foundCar.png"), for: .normal)
            } else {
                     print("chau")
                mapView.removeAnnotations(mapView.annotations)
                parkButton.setImage(UIImage(named: "parkCar.png"), for: .normal)
            }
            centerMapOnLocation(location: LocationService.instance.locationManager.location!)
        
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("entrò")
            mapView.showsUserLocation = true
            LocationService.instance.locationManager.delegate = self as CLLocationManagerDelegate
            LocationService.instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationService.instance.locationManager.distanceFilter = 50
            LocationService.instance.locationManager .startUpdatingLocation()
        }
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_mapView: MKMapView, viewFor annotation: MKAnnotation)-> MKAnnotationView {
        if let annotation = annotation as? ParkingSpot {
            print("que pasa aca?")
            let identifier = "pin"
            var view: MKPinAnnotationView
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            view.canShowCallout = true
            view.animatesDrop = true
            view.pinTintColor = UIColor.orange
            view.calloutOffset = CGPoint(x: -8, y: -3)
            view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIView
            return view
        } else {
            print("no devuelve una concha")
            return MKAnnotationView.init()
            
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view:
        MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        
        let location = view.annotation as! ParkingSpot
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:
            
            MKLaunchOptionsDirectionsModeWalking]
        location.mapItem(location:
            
            (parkedCarAnnotation?.coordinate)!).openInMaps(launchOptions:
                launchOptions)
    }
}


extension ViewController: CLLocationManagerDelegate {

    func mapView(_ mapView: MKMapView, didUpdate userLocation:
        MKUserLocation) {
        centerMapOnLocation(location: CLLocation(latitude:
            userLocation.coordinate.latitude, longitude:
            userLocation.coordinate.longitude))
        let locationServiceCoordinate =
            LocationService.instance.locationManager.location!.coordinate
        parkedCarAnnotation = ParkingSpot(title: "My Parking Spot", locationName: "Tap the 'i' for GPS", coordinate: CLLocationCoordinate2D(latitude: locationServiceCoordinate.latitude, longitude: locationServiceCoordinate.longitude))
    }
}
