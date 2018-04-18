//
//  ViewController.swift
//  MapApplication
//
//  Created by Rimil Dey on 18/04/18.
//  Copyright © 2018 Rimil Dey. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    
    /*convenience init() {
        
        self.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }*/
    
    override func loadView() {
        var json: [String : AnyObject] = [:]
        
        //loading json data
        let path = Bundle.main.path(forResource: "places", ofType: "json")
        
        // Load the contents of the file into an NSData object
        let jsonData = NSData(contentsOfFile: path!)
        
        do
        {
            // Serialize the jsonData object to make a Json object
            let jsonResult = try JSONSerialization.jsonObject(with: jsonData! as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                    
            json = (jsonResult as? [String : AnyObject])!
        }
        catch
        {
            print("Problem converting jsonResult to dictionary")
        }
        
        // Create a GMSCameraPosition that tells the map to display the
        // california map
        let camera = GMSCameraPosition.camera(withLatitude: 36.77, longitude: -119.41, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let routePath = GMSMutablePath()
        
        // Creates a markers for the cities
        for city in json["cities"] as! [AnyObject] {
            let lat = city["latitude"] as! Double
            let long = city["longitude"] as! Double
            let cityName = city["title"] as? String
            
            let marker = GMSMarker()
            
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.title = cityName
            marker.map = mapView
            
            routePath.addLatitude(lat, longitude: long)
        }
        
        let polyline = GMSPolyline(path: routePath)
        polyline.strokeColor = .green
        polyline.strokeWidth = 2.0
        polyline.map = mapView
        
        view = mapView
        
    }
}
