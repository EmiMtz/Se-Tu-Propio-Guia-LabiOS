//
//  MapaKitViewController.swift
//  Sé tu propio guía
//
//  Created by Tania Rossainz on 7/30/19.
//  Copyright © 2019 Emiliano Martínez. All rights reserved.
//

import UIKit

import MapKit

class MapaKitViewController: UIViewController, UISearchBarDelegate {
    
    let locationManager = CLLocationManager ()
    @IBOutlet weak var mapita: MKMapView!
    
    @IBOutlet weak var selector: UISegmentedControl!

    var searchBarController : UISearchController!
    
    var resultSearchController: UISearchController? = nil
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    let geocoder = CLGeocoder()
    var adress = ""
    
    var place = Place()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCurrentLocation()
        self.showPinMap()

        //Configure the mapView = mapita
        mapita.delegate = self
        mapita.showsTraffic = true
        mapita.showsScale = true
        mapita.showsCompass = true
        mapita.showsPointsOfInterest = true
        
        mapita.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.action(gestureRecognizer:)))
        mapita.addGestureRecognizer(tapGesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 3
        mapita.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) { }
    
    func showPinMap(){
        geocoder.geocodeAddressString(place.location) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.place.name
                annotation.subtitle = self.place.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // Display the annotation
                    self.mapita.showAnnotations([annotation], animated: true)
                    self.mapita.selectAnnotation(annotation, animated: true)
                    
                    
                    guard let sourceCoordinates = self.locationManager.location?.coordinate else { return self.alertLocation(tit: "Error de localización", men: "Actualmente tiene denegada la localización del dispositivo, activalos desde los ajustes de la aplicación") }
                    let destCoordinates = CLLocationCoordinate2DMake(annotation.coordinate.latitude, annotation.coordinate.longitude)
                    
                    let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates)
                    let destPlacemark = MKPlacemark(coordinate: destCoordinates)
                    
                    let sourceItem = MKMapItem(placemark: sourcePlacemark)
                    let destItem = MKMapItem(placemark: destPlacemark)
                    
                    let directionRequest = MKDirections.Request()
                    directionRequest.source = sourceItem
                    directionRequest.destination = destItem
                    directionRequest.transportType = .transit
                    directionRequest.transportType = .any
                    
                    
                    let directions = MKDirections(request: directionRequest)
                    directions.calculate(completionHandler: {
                        
                        response, error in
                        
                        guard let response = response else {
                            if error != nil {
                                let alert = UIAlertController(title: nil, message: "Directions not available.", preferredStyle: .alert)
                                let okButton = UIAlertAction(title: "OK", style: .cancel) { (alert) -> Void in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alert.addAction(okButton)
                                self.present(alert, animated: true,completion: nil)
                            }
                            return
                        }
                        
                        
                        if self.mapita.overlays.count > 1 {
                            self.mapita.removeOverlays(self.mapita.overlays)
                        }
                        
                        let route = response.routes[0]
                        self.mapita.addOverlay(route.polyline, level: .aboveRoads)
                        
                        let rekt = route.polyline.boundingMapRect
                        self.mapita.setRegion(MKCoordinateRegion(rekt), animated: true)
                    })
                }
            }
        }

    }
    
    ///Para pedir permisos de ubicación del usuario en caso de que no se hayan dado los permisos al momento de instalar la aplicación.
    func configCurrentLocation(){
        let locationManager = CLLocationManager()
        if #available(iOS 13.0, *) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    @IBAction func cambiarVistaMapa(_ sender: Any) {
        
        //ESTRUCTURA DE CASOS
        switch selector.selectedSegmentIndex {
        case 0:
            
            mapita.mapType = .standard
            
        case 1:
            
            mapita.mapType = .satellite
            
        case 2:
            
            mapita.mapType = .hybrid
            
        default:
            break
        }
    }
    
    @IBAction func localizame() {
        initLocation()
    }
    
    func initLocation() {
        let permiso = CLLocationManager.authorizationStatus()
        
        if permiso == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        } else if permiso == .denied {
            alertLocation(tit: "Error de localización", men: "Actualmente tiene denegada la localización del dispositivo")
        } else if permiso == .restricted{
             alertLocation(tit: "Error de localización", men: "Actualmente tiene restringida la localización del dispositivo")
        } else {
            guard let currentCoordinate = locationManager.location?.coordinate else { return }
            
            let region = MKCoordinateRegion(center: currentCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapita.setRegion(region, animated: true)
        }
    }
    
    func alertLocation(tit: String, men: String)  {
        let alerta = UIAlertController(title: tit, message: men,preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(action)
        self.present(alerta, animated: true, completion: nil)
    }
    
    @objc func action(gestureRecognizer: UIGestureRecognizer) {
        
        self.mapita.removeAnnotations(mapita.annotations)
        
        let touchPoint = gestureRecognizer.location(in: mapita)
        let newCoords = mapita.convert(touchPoint, toCoordinateFrom: mapita)
        
        geocoderLocation(newLocation: CLLocation(latitude: newCoords.latitude, longitude: newCoords.longitude))
        
        let latitud = String(format: "%.6f", newCoords.latitude)
        let longitud = String(format: "%.6f", newCoords.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoords
        annotation.title = adress
        annotation.subtitle = "Latitud: \(latitud), Longitud \(longitud)"
        mapita.addAnnotation(annotation)
        
        let sourceCoordinates = locationManager.location?.coordinate
        let destCoordinates = CLLocationCoordinate2DMake(newCoords.latitude, newCoords.longitude)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .transit
        directionRequest.transportType = .any
        
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            
            response, error in
            
            guard let response = response else {
                if error != nil {
                    let alert = UIAlertController(title: nil, message: "Directions not available.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel) { (alert) -> Void in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(okButton)
                    self.present(alert, animated: true,completion: nil)
                }
            return
            }
            
            
            if self.mapita.overlays.count > 1 {
                self.mapita.removeOverlays(self.mapita.overlays)
            }
            
            let route = response.routes[0]
            self.mapita.addOverlay(route.polyline, level: .aboveRoads)
            
            let rekt = route.polyline.boundingMapRect
            self.mapita.setRegion(MKCoordinateRegion(rekt), animated: true)
        })
        


        
    }
    
    @objc func doubleTapped() {
        self.mapita.removeAnnotations(mapita.annotations)
        self.mapita.removeOverlays(mapita.overlays)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange.withAlphaComponent(0.45)
        renderer.lineWidth = 5.0
        
        return renderer
    }
    
    func geocoderLocation(newLocation: CLLocation) {
        var dir = ""
        geocoder.reverseGeocodeLocation(newLocation) { (placemarks, error) in
            if error == nil {
                dir = "No se ha podido determinar la dirección"
            }
            if let placemark = placemarks?.last {
                dir = self.stringFromPlacemark(placemark: placemark)
            }
            self.adress = dir
        }
    }
    
    func stringFromPlacemark(placemark: CLPlacemark) -> String {
        var line = ""
        
        if let p = placemark.thoroughfare {
            line += p + ", "
        }
        if let p = placemark.subThoroughfare {
            line += p + " "
        }
        if let p = placemark.locality {
            line += " (" + p + ")"
        }
        return line
    }
}

extension MapaKitViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print(locations[0])
        
//        guard let newLocation = locations.last else { return }
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = newLocation.coordinate
//        mapita.addAnnotation(annotation)
    }
    
    @IBAction func showSearchBar(){
        searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.dimsBackgroundDuringPresentation = true
        
        self.searchBarController.searchBar.delegate = self
        present(searchBarController, animated: true, completion: nil)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.sizeToFit()
        
        
        dismiss(animated: true, completion: nil)
        
        
        
        if mapita.annotations.count > 1 {
            self.mapita.removeAnnotations(mapita.annotations)
        }
        
        geocoder.geocodeAddressString(searchBar.text!){ (placemarks:[CLPlacemark]?, error:Error?) in
            
            if error == nil {
                let placemark = placemarks?.first
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark?.location?.coordinate)!
                annotation.title = searchBar.text!
                
                let spam = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: spam)
                
                self.mapita.setRegion(region, animated: true)
                self.mapita.addAnnotation(annotation)
                self.mapita.selectAnnotation(annotation, animated: true)
                
                let sourceCoordinates = self.locationManager.location?.coordinate
                let destCoordinates = CLLocationCoordinate2DMake(annotation.coordinate.latitude, annotation.coordinate.longitude)
                
                let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
                let destPlacemark = MKPlacemark(coordinate: destCoordinates)
                
                let sourceItem = MKMapItem(placemark: sourcePlacemark)
                let destItem = MKMapItem(placemark: destPlacemark)
                
                let directionRequest = MKDirections.Request()
                directionRequest.source = sourceItem
                directionRequest.destination = destItem
                directionRequest.transportType = .transit
                directionRequest.transportType = .any
                
                
                let directions = MKDirections(request: directionRequest)
                directions.calculate(completionHandler: {
                    
                    response, error in
                    
                    guard let response = response else {
                        if error != nil {
                            let alert = UIAlertController(title: nil, message: "Directions not available.", preferredStyle: .alert)
                            let okButton = UIAlertAction(title: "OK", style: .cancel) { (alert) -> Void in
                                self.navigationController?.popViewController(animated: true)
                            }
                            alert.addAction(okButton)
                            self.present(alert, animated: true,completion: nil)
                        }
                        return
                    }
                    
                    
                    if self.mapita.overlays.count > 1 {
                        self.mapita.removeOverlays(self.mapita.overlays)
                    }
                    
                    let route = response.routes[0]
                    self.mapita.addOverlay(route.polyline, level: .aboveRoads)
                    
                    let rekt = route.polyline.boundingMapRect
                    self.mapita.setRegion(MKCoordinateRegion(rekt), animated: true)
                })
                
            } else {
                print("Error")
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchCompleter.queryFragment = searchText
    }

}

extension MapaKitViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        //searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension MapaKitViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let annotationID = "AnnotationID"
        
        var annotationView : MKAnnotationView?
        
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationID){
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationID)
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "img_pin")
        }
        return annotationView
        }
//
//        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
//        pin.pinTintColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
//
//        return pin
}

