//
//  ViewController.swift
//  GPS lection
//
//  Created by Lina Li on 2020-10-16.
//

import UIKit
import MapKit
import CoreLocation

class ownPin: NSObject, MKAnnotation
{
    var title: String?
    var subtitle: String?
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 55.609172, longitude: 12.997648)
    var storeId = 0
}

class ViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager : CLLocationManager!
   
    @IBOutlet weak var theMap: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
         
        locationManager = CLLocationManager()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        theMap.delegate = self
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let initialLocation = CLLocation(latitude: 55.609172, longitude: 12.997648)
        let regionRadius: CLLocationDistance = 1000
        let cooordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        theMap.setRegion(cooordinateRegion, animated: true)
        
        let myPin = ownPin()
        myPin.title = "Hej"
        myPin.subtitle = "Tjena"
        myPin.storeId = 123
        theMap.addAnnotation(myPin)
        
        let myPin2 = ownPin()
        myPin.title = "Andra"
        myPin.subtitle = "Butiken"
        myPin.storeId = 999
        theMap.addAnnotation(myPin2)
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization")
        if CLLocationManager.locationServicesEnabled(){
            print ("LOCATION ENABLED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations [0]
        let lng = userLocation.coordinate.longitude
        let lat = userLocation.coordinate.latitude
        
        print("\(lat) \(lng)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? ownPin{
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else{
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            view.pinTintColor = MKPinAnnotationView.greenPinColor()
            return view
}
        return nil

}
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print ("calloutAccessoaryControlTapped")
        
        if let pinnen = view.annotation as? ownPin
        {
            print ("Klick på butik med id \(pinnen.storeId)")
        }
    }
}
