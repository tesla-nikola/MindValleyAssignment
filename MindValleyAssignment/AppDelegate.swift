//
//  AppDelegate.swift
//  MindValleyAssignment
//
//  Created by Soham Ray on 08/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        application.isNetworkActivityIndicatorVisible = true
        return true
    }
}

