//
//  Utils.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/7/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import Parse

func saveInstallationObject(){
    if let installation = PFInstallation.current(){
        installation.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                print("Successfully connected to Back4App")
            } else {
                if let myError = error{
                    print(myError.localizedDescription)
                }else{
                    print("Uknown error")
                }
            }
        }
    }
}

func selectViewController() -> UIViewController {
    let currentUser = PFUser.current()
    var nextViewController : UIViewController
    
    if currentUser != nil {
        nextViewController = FeedUserScreen()
    } else {
        let navigation = UINavigationController()
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigation.navigationBar.shadowImage = UIImage()
        navigation.navigationBar.backgroundColor = .clear
        navigation.navigationBar.isTranslucent = true
        navigation.navigationBar.tintColor = .lightGray
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        navigation.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
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
