//
//  AppDelegate.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/6/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "IMn0HGPqjoeUy5rA87qicocIUrWKwffNfBgwb7GL"
            $0.clientKey = "cgJqpig5ljbw4HpERXSImwaxDSi0i4z8Msjm1Ywh"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        saveInstallationObject()
        
        let window = UIWindow()
        self.window = window
        window.makeKeyAndVisible()
        window.rootViewController = selectViewController()
        
        return true
    }
        
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

