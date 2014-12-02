//
//  TableViewController.swift
//  PracticeSwift
//
//  Created by Yukui ye on 11/18/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    
    var array1:[String] = ["one","two","three","four"]
    
    convenience init(tableView : UITableView) {
        self.init(nibName: nil, bundle: nil)
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRectMake(self.view.bounds.origin.x + 40, self.view.bounds.origin.y + 120, self.view.frame.size.width - 80, self.view.frame.size.height - 260))
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorColor = UIColor(red: 135/225, green: 206/225, blue: 235/225, alpha: 0.8)
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10)
        self.tableView.clipsToBounds = true
        self.tableView.layer.cornerRadius = self.tableView.frame.size.width/2
        
        self.view.addSubview(self.tableView)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell))
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array1.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell), forIndexPath: indexPath) as UITableViewCell
        if indexPath.row%2 == 0 {
            cell.backgroundColor = UIColor(red:173/225, green:216/225, blue:230/225, alpha:0.8)
        } else {
            cell.backgroundColor = UIColor(red: 145/225, green:206/225, blue:250/225, alpha:0.4)
        }
        cell.textLabel?.text = array1[indexPath.row]
        cell.textLabel?.font = UIFont(name: "AppleColorEmoji", size: 16)
        cell.textLabel?.textColor = UIColor(red: 0.306, green:0.306, blue:0.275, alpha:1)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}