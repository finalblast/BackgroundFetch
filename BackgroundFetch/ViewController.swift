//
//  ViewController.swift
//  BackgroundFetch
//
//  Created by Nam (Nick) N. HUYNH on 3/23/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var mustReloadView = false
    var newsItems: [NewsItem] {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.newsItems
        
    }
    
    struct TableViewValue {
    
        static let identifier = "Cell"
        
    }
    
    func handleNewsItemsChanged(notification: NSNotification) {
        
        if self.isBeingPresented() {
            
            tableView.reloadData()
            
        } else {
            
            mustReloadView = true
            
        }
        
    }
    
    func handleAppIsBroughtToForeGround(notification: NSNotification) {
        
        if self.mustReloadView {
            
            tableView.reloadData()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNewsItemsChanged:", name: AppDelegate.newsItemsChangedNotification(), object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleAppIsBroughtToForeGround:", name: UIApplicationWillEnterForegroundNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsItems.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewValue.identifier, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel.text = newsItems[indexPath.row].text
        return cell
        
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }

}

