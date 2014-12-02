//
//  MapViewController.swift
//  PracticeSwift
//
//  Created by Yukui ye on 11/13/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapview:MKMapView!
    var toolBar:UIToolbar!
    
    convenience init(mapview: MKMapView, toolBar:UIToolbar) {
        self.init(nibName: nil, bundle: nil)
        self.mapview = mapview
        self.toolBar = toolBar
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.toolBar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))
        self.toolBar.barTintColor = UIColor(red:145/225, green:206/225, blue:250/225, alpha:0.4)
        self.toolBar.barStyle = UIBarStyle.BlackTranslucent
        
        let shadow:NSShadow = NSShadow.alloc()
        shadow.shadowColor = UIColor.orangeColor()
        shadow.shadowOffset = CGSizeMake(1, 0)
        
        var leftBarBtn: UIBarButtonItem = UIBarButtonItem.alloc()
        leftBarBtn.setTitleTextAttributes(NSDictionary(objectsAndKeys:UIColor.blueColor(), NSForegroundColorAttributeName, UIFont.fontNamesForFamilyName("Zapfino"), NSFontAttributeName, shadow, NSShadowAttributeName), forState: UIControlState.Normal)
        
        var rightBarBtn: UIBarButtonItem = UIBarButtonItem.alloc()
        rightBarBtn.setTitleTextAttributes(NSDictionary(objectsAndKeys:UIColor.blueColor(), NSForegroundColorAttributeName, UIFont.fontNamesForFamilyName("Zapfino"), NSFontAttributeName, shadow, NSShadowAttributeName), forState: UIControlState.Normal)
        
        leftBarBtn.title = "List"
        rightBarBtn.title = "Direction"
        var flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        let toolbarButtonItems = [
            leftBarBtn,
            flexibleSpace,
            rightBarBtn
        ]
//        self.toolBar.setItems(toolbarButtonItems, animated: true)
//        self.view.addSubview(self.toolBar)
        
      //  self.mapview = MKMapView(frame: CGRectMake(0, navigationController!.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height))
        self.mapview = MKMapView(frame: CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height))
        self.view.addSubview(self.mapview)
        self.mapview.delegate = self;
        
        self.mapview.mas_makeConstraints { make in
            make.top.equalTo()(self.view.mas_top).offset()(64)
            make.left.equalTo()(self.view.mas_left)
            make.bottom.equalTo()(self.view.mas_bottom)
            make.right.equalTo()(self.view.mas_right)
        }
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        var location:CLLocation = CLLocation(latitude: 40.782865, longitude: -73.965355)
        var viewRegion:MKCoordinateRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.782865, -73.965355), MKCoordinateSpanMake(9.0/69.0, 9.0/69.0))
        self.mapview.setRegion(viewRegion, animated: true)
    }
    
    
}
