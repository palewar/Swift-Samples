//
//  MasterViewController.swift
//  MultipleDetailViews
//
//  Code provided As Is, Do whatever you want with it, but do it at your own risk
//  www.SwiftWala.com
//

import UIKit

class MasterViewController: UITableViewController {


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail1" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                var controller: DetailViewController!
                if let navController = segue.destinationViewController as? UINavigationController {
                    
                    // this code will run on all devices, where splitview is implemented
                    // ios8 iPhone, iPad
                    // ios7 iPad
                    controller = navController.topViewController as DetailViewController
                    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    controller.navigationItem.leftItemsSupplementBackButton = true
                } else {
                    
                    // this code will run on all devices, where splitview is not implemented
                    // ios7 iPhone
                    controller = segue.destinationViewController as DetailViewController
                }
                // additional setup of detail view goes here
                
            }
        } else if segue.identifier == "showDetail2" {
            var controller: DetailViewController2!
            if let navController = segue.destinationViewController as? UINavigationController {
                controller = navController.topViewController as DetailViewController2
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            } else {
                controller = segue.destinationViewController as DetailViewController2
            }
            // additional setup of detail view goes here 
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // Set appropriate labels for the cells.
        if indexPath.row == 0 {
            cell.textLabel?.text = "Second Table View Controller"
            cell.accessoryType = .DisclosureIndicator
        }
        else if indexPath.row == 1 {
            cell.textLabel?.text = "Detail View Controller One"
        }
        else {
            cell.textLabel?.text = "Detail View Controller Two"
            
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            self.performSegueWithIdentifier("showTableView2", sender: self)
        } else if indexPath.row == 1 {
            self.performSegueWithIdentifier("showDetail1", sender: self)
        } else {
            self.performSegueWithIdentifier("showDetail2", sender: self)
        }
    }
  
}

