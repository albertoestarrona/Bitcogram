//
//  Utils.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/7/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import Parse

func selectViewController() -> UIViewController {
    let currentUser = PFUser.current()
    var nextViewController : UIViewController
    
    if currentUser != nil {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor.init(red: 243/255, green: 243/255, blue: 244/255, alpha: 1)
        tabBarController.tabBar.unselectedItemTintColor = UIColor.lightGray
        tabBarController.tabBar.tintColor = UIColor.init(red: 248/255, green: 159/255, blue: 61/255, alpha: 1)
        
        let navigationFeed = NavigationBitcogram()
        let feedViewController = FeedUserScreen()
        feedViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "tab-history"), selectedImage: nil)
        navigationFeed.viewControllers = [feedViewController]
        
        let navigationCamera = NavigationBitcogram()
        let cameraViewController = CameraPostScreen()
        cameraViewController.tabBarItem = UITabBarItem(title: "Camera", image: UIImage(named: "tab-camera"), selectedImage: nil)
        navigationCamera.viewControllers = [cameraViewController]
        
        let navigationProfile = NavigationBitcogram()
        let profileViewController = ProfileUserScreen()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tab-profile"), selectedImage: nil)
        navigationProfile.viewControllers = [profileViewController]
        
        let tabBarList = [navigationFeed, navigationCamera, navigationProfile]
        tabBarController.viewControllers = tabBarList
        nextViewController = tabBarController
    } else {
        let navigation = NavigationBitcogram()
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigation.navigationBar.shadowImage = UIImage()
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationBar.isTranslucent = true
        let loginViewController = LoginUserScreen()
        loginViewController.navigationItem.title = "Login"
        navigation.viewControllers = [loginViewController]
        nextViewController = navigation
    }
    
    return nextViewController
}

func presentError(controller: UIViewController, title: String, error: String) {
    let alertCtrl = UIAlertController(title: title, message: error, preferredStyle: .alert)
    alertCtrl.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
    controller.present(alertCtrl, animated: true)
}

func presentAlert(controller: UIViewController, title: String, message: String) {
    let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertCtrl.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    controller.present(alertCtrl, animated: true)
}
