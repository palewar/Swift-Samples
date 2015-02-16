//
//  SplitViewSupport.swift
//  MasterDetailDemo
//
//  Created by Ivo Vacek on 28/01/15.
//  Copyright (c) 2015 Ivo Vacek. All rights reserved.
//

import UIKit

// MARK: - iPad ios7support

extension UISplitViewController: UISplitViewControllerDelegate {
    
    struct ios7Support {
        static var modeButtonItem: UIBarButtonItem?
    }
    
    var backBarButtonItem: UIBarButtonItem? {
        get {
            if respondsToSelector(Selector("displayModeButtonItem")) == true {
                let button: UIBarButtonItem = displayModeButtonItem()
                return button
            } else {
                return ios7Support.modeButtonItem
            }
        }
        set {
            ios7Support.modeButtonItem = newValue
        }
    }
    
    func displayModeButtonItem(_: Bool = true)->UIBarButtonItem? {
        return backBarButtonItem
    }
    
    public func splitViewController(svc: UISplitViewController, willHideViewController aViewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController pc: UIPopoverController) {
        if (!svc.respondsToSelector(Selector("displayModeButtonItem"))) {
            if let detailView = svc.viewControllers[svc.viewControllers.count-1] as? UINavigationController {
                //Static.backButton = barButtonItem
                svc.backBarButtonItem = barButtonItem
                detailView.topViewController.navigationItem.leftBarButtonItem = barButtonItem
            }
        }
    }
    
    
    public func splitViewController(svc: UISplitViewController!, willShowViewController aViewController: UIViewController!, invalidatingBarButtonItem barButtonItem: UIBarButtonItem!) {
        if (!svc.respondsToSelector(Selector("displayModeButtonItem"))) {
            if let detailView = svc.viewControllers[svc.viewControllers.count-1] as? UINavigationController {
                //Static.backButton = nil
                svc.backBarButtonItem = nil
                detailView.topViewController.navigationItem.leftBarButtonItem = nil
            }
        }
    }
    
    public func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController {
                if topAsDetailController.detailItem == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }
    
    // Correctly Handle Portrait to Landscape transition for iPhone 6+ when TableView2 is open in Portrait. Comment and see for yourself, what happens when you don't write this.
    public func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController? {
        if let primaryAsNavController = primaryViewController as? UINavigationController {
            if let topAsTableViewController = primaryAsNavController.topViewController as? TableViewController2 {
                //Return Navigation controller containing DetailView1 to be used as secondary view for Split View
                return (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detail1Nav") as UIViewController)
            }
        }
        return nil
    }
}
