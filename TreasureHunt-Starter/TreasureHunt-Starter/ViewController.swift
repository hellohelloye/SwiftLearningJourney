//
//  ViewController.swift
//  TreasureHunt-Starter
//
//  Created by Yukui ye on 9/22/14.
//  Copyright (c) 2014 Yukui ye. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var mapView: MKMapView
    var treasures = Treasure[]()

    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        self.treasures = [
            HistoryTreasure(what:"Google's first office",
                year: 1999,
                latitude: 37.44451, longitude: -122.163369),
            HistoryTreasure(what: "Facebook's first office",
                year: 2005,
                latitude: 37.444268, longitude: -122.163271),
            FactTreasure(what: "Stanford University",
                fact: "Founded in 1885 by Leland Stanford.",
                latitude: 37.427474, longitude: -122.169719),
            FactTreasure(what: "Moscone West",
                fact: "Host to WWDC since 2003.",
                latitude: 37.783083, longitude: -122.404025),
            FactTreasure(what: "Computer History Museum",
                fact: "Home to a working Babbage Difference Engine.",
                latitude: 37.414371, longitude: -122.076817),
            HQTreasure(company: "Apple",
                latitude: 37.331741, longitude: -122.030333),
            HQTreasure(company: "Facebook",
                latitude: 37.485955, longitude: -122.148555),
            HQTreasure(company: "Google",
                latitude: 37.422, longitude: -122.084),
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        var location:CLLocation = CLLocation(latitude: 40.7429493, longitude: -73.98465170000001)
        var viewRegion:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 5.5*2000.344, 5.5*2000.344);
        self.mapView .setRegion(viewRegion, animated: true)
    }
    
}

