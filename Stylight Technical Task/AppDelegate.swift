//
//  AppDelegate.swift
//  Stylight Technical Task
//
//  Created by Ahmad Atef on 7/17/17.
//  Copyright © 2017 Ahmad Atef. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        monitorInternetConnectivity()
        return true
    }
    
    func monitorInternetConnectivity() {
        InternetChecker.shared.checkForInternet { (result) in
            if result != .REACHABLEVIAWIFI{
                UIDecorator.shared.showMessage(title: "Warning",body: result.rawValue,alertType: .warning)
            }
        }
    }

}

