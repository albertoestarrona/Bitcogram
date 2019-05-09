//
//  ParseUtils.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/8/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import Foundation
import Parse

// Parse
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

func saveImageToParse(object: PFObject, image: UIImage, key: String, viewController: UIViewController) {
    let avatar = PFFileObject(name: PFUser.current()!.username, data: image.pngData()!)
    object.setObject(avatar!, forKey: key)
    object.saveInBackground { (success, error) in
        if success{
            print("Yahooooo!")
        }else{
            if let description = error?.localizedDescription{
                presentError(controller: viewController, title: "Error", error: description)
            }
        }
    }
}
