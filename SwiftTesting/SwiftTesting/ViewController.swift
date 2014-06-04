//
//  ViewController.swift
//  SwiftTesting
//
//  Created by Yukui ye on 6/4/14.
//  Copyright (c) 2014 M.Shanken. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate{
                            
    @IBOutlet var tableView : UITableView
    var data:NSMutableData = NSMutableData()
    var tableData:NSArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchItunesFor("wine spectator")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchItunesFor(searchTerm: String) {
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        var escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
        var url:NSURL = NSURL(string: urlPath)
        
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        println("Search iTunes API at URL \(url)")
        
        connection.start()
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Recieved a new request, clear out the data object
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append the recieved chunk of data to our data object
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // Request complete, self.data should now hold the resulting info
        // Convert the retrieved data in to an object through JSON deserialization
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options:    NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        if jsonResult.count>0 && jsonResult["results"].count>0 {
            var results: NSArray = jsonResult["results"] as NSArray
            self.tableData = results
            self.tableView.reloadData()
            
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"myTestSwiftCell")
        var rowData:NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.text = rowData["trackName"] as String
        
        var urlString:NSString = rowData["artworkUrl60"] as NSString
        var imgURL:NSURL = NSURL(string:urlString)
        
        var imgData:NSData = NSData(contentsOfURL: imgURL)
        cell.image = UIImage(data:imgData)
        
        var formattedPrice: NSString = rowData["formattedPrice"] as NSString
        cell.detailTextLabel.text = formattedPrice;

        cell.backgroundColor = UIColor .blueColor()
        cell.textColor = UIColor .whiteColor()
        cell.detailTextLabel.textColor = UIColor .whiteColor()
        return cell
    }
    
}

