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
func saveImageToParse(image: UIImage, key: String, viewController: UIViewController) {
    let avatar = PFFileObject(name: PFUser.current()!.username, data: image.pngData()!)
    PFUser.current()!.setObject(avatar!, forKey: key)
    PFUser.current()!.saveInBackground { (success, error) in
        if success{
            print("Yahooooo!")
        }else{
            if let description = error?.localizedDescription{
                presentError(controller: viewController, title: "Error", error: description)
            }
        }
    }
}
