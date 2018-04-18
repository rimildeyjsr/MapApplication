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
        
        //loading json data
        if let path = Bundle.main.path(forResource: "places", ofType: "json")
        {
            // Load the contents of the file into an NSData object
            if let jsonData = NSData(contentsOfFile: path)
            {
                
                do {
                    
                    // Serialize the jsonData object to make a Json object
                    let jsonResult = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    let json = jsonResult as? [String : AnyObject]

                } catch {
                    print("Problem converting jsonResult to dictionary")
                }
            }
        }
    
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.map = mapView
        
    }
        
   
}

