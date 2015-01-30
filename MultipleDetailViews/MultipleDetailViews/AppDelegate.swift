//
//  AppDelegate.swift
//  MultipleDetailViews
//
//  Code provided As Is, Do whatever you want with it, but do it at your own risk
//  www.SwiftWala.com
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        if let splitViewController = self.window!.rootViewController as? UISplitViewController {
            let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as UINavigationController
            navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
            //
            // splitViewController.delegate = self
            splitViewController.delegate = splitViewController
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    /*
    // this code is still required and is moved to SplitVieSupport, which is set as UISplitViewControllerDelegate

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
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
    func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController!) -> UIViewController? {
        if let primaryAsNavController = primaryViewController as? UINavigationController {
            if let topAsTableViewController = primaryAsNavController.topViewController as? TableViewController2 {
                //Return Navigation controller containing DetailView1 to be used as secondary view for Split View
                return (UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("detail1Nav") as UIViewController)
            }
        }
    return nil
    }

    */
}

