//
//  MapController.swift
//  AirPortStoryboard
//
//  Created by Juan Jose Mendez Rojas on 27/10/23.
//

import CoreLocation
import MapKit
import UIKit

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var MapView: MKMapView!
    var locationManager = CLLocationManager()
    var radius = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if let radioGuardado = UserDefaults.standard.string(forKey: "radius") {
            print("Radio guardado: \(radioGuardado)")
            radius = Int(radioGuardado) ?? 0
        } else {
            print("No se encontró ningún dato guardado.")
        }
        AirportSearchViewModel.shared.getAirport(lat: locationManager.location?.coordinate.latitude ?? 0, lon: locationManager.location?.coordinate.longitude ?? 0, radius: Int(radius)) { done in
            DispatchQueue.main.async {
                self.MapView.reloadInputViews()
            }
        } air: { air in
            air.forEach { n in
                let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(n.latitude ?? 0.0, n.longitude ?? 0.0)
                let location1 : CLLocation = CLLocation(latitude: n.latitude ?? 0.0, longitude: n.longitude ?? 0.0)
                CLGeocoder().reverseGeocodeLocation(location1) { (placemarks, error) in
                    if error != nil {
                        print(error!)
                    } else {
                        DispatchQueue.main.async {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = location
                            self.MapView.addAnnotation(annotation)
                            self.MapView.reloadInputViews()
                        }
                    }
                }
            }
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation : CLLocation = locations[0]
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        let latdelta : CLLocationDegrees = 1.0
        let longdelta : CLLocationDegrees = 1.0
        
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latdelta, longitudeDelta: longdelta)
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud, longitud)
        
        let region : MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        self.MapView.setRegion(region, animated: false)
    }
}
