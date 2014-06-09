//
//  ViewController.swift
//  WhereToTalk
//
//  Created by Yukui ye on 6/5/14.
//  Copyright (c) 2014 M.Shanken. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var mapView : MKMapView
    @IBOutlet var tableView : UITableView
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.backgroundColor = UIColor .clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // #pragma mark - UITableViewDataSource
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1;
        }
        else {
            return 10
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if indexPath.section == 0 {
            return 250;
        }
        else {
            return 44;
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"myTestSwiftCell")
        
        if indexPath.section == 0 {
            cell.backgroundColor = UIColor .clearColor()
        }
        else {
            cell.text = "location *  Time * #\(indexPath.row)"
            cell.detailTextLabel.text = "conversation Topic : #\(indexPath.row)"
            //118;238;198
            cell.backgroundColor = UIColor(red: 118/255, green: 238/255, blue: 198/255, alpha: 1.0)
            cell.textColor = UIColor .whiteColor()
            cell.detailTextLabel.textColor = UIColor .whiteColor()
        }
        
        return cell
    }
    

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if indexPath.section == 0 {
            
        }
        else {
            let cell:UITableViewCell = self.tableView .cellForRowAtIndexPath(indexPath)
            self.performSegueWithIdentifier("showDetail", sender: cell)
            }
    }

     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject) {
       if segue.identifier == "showDetail" {
        let itemviewcontroller:WTTDetailViewController = segue.destinationViewController as WTTDetailViewController
       }
     }
  //  #pragma mark - MKMapkitDelegate
//    func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
//        return YES
//    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        var location:CLLocation = CLLocation(latitude: 40.7429493, longitude: -73.98465170000001)
        var viewRegion:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 5.5*2000.344, 5.5*2000.344);
        self.mapView .setRegion(viewRegion, animated: true)
    }
    
//    func mapView(mapView: MKMapView!,
//        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//            
//    }
//    
//    func mapView(mapView: MKMapView!,
//        didDeselectAnnotationView view: MKAnnotationView!) {
//            
//    }
}

