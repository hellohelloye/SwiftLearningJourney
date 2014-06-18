//
//  WTTDetailViewController.swift
//  WhereToTalk
//
//  Created by Yukui ye on 6/9/14.
//  Copyright (c) 2014 M.Shanken. All rights reserved.
//

import Foundation
import UIKit

class WTTDetailViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet  var convoTableView: UITableView
    @IBOutlet  var msgBtn: UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.view.backgroundColor = UIColor(red: 118/255, green: 238/255, blue: 198/255, alpha: 1.0)

        self.msgBtn.backgroundColor = UIColor.blueColor()
       // self.navigationController.navigationBar .addSubview(self.msgBtn)
        self.convoTableView.backgroundColor = UIColor(red: 118/255, green: 238/255, blue: 198/255, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func writeMsg(sender: AnyObject) {
    
    }
    
    func tableView(convoTableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1;
        }
        else {
            return 10
        }
    }
    
    func numberOfSectionsInTableView(convoTableView: UITableView!) -> Int {
        return 2
    }
    
    func tableView(convoTableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if indexPath.section == 0 {
            return 140;
        }
        else {
            return 44;
        }
    }
    
    func tableView(convoTableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        if indexPath.section == 0 {
             let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"convoTopicCell")
            
            cell.backgroundColor = UIColor .clearColor()
            cell.text = "What's the meaning of life ? "
            cell.textColor = UIColor .whiteColor()
            cell.backgroundColor = UIColor(red: 118/255, green: 238/255, blue: 198/255, alpha: 1.0)
            return cell
        }
        else {
            
            let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Subtitle, reuseIdentifier:"convoMsgCell")
                
            cell.text = "hiii  * #\(indexPath.row)"
            cell.detailTextLabel.text = "blablabla : #\(indexPath.row)"
            cell.backgroundColor = UIColor(red: 118/255, green: 238/255, blue: 198/255, alpha: 1.0)
            cell.textColor = UIColor .whiteColor()
            cell.detailTextLabel.textColor = UIColor .whiteColor()
            
            return cell
        }
        
    }
    
    func tableView(convoTableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if indexPath.section == 0 {
            
        }
        else {
            let cell:UITableViewCell = self.convoTableView .cellForRowAtIndexPath(indexPath)
           // self.performSegueWithIdentifier("showDetail", sender: cell)
        }
    }

    
}