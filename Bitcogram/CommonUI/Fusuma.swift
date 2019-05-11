//
//  Fusuma.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/8/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import Foundation
import Fusuma

struct FusumaConfig {
    static func initFusuma(in controller:UIViewController, fusuma:FusumaViewController) -> FusumaViewController {
        
        fusuma.delegate = controller as? FusumaDelegate
        fusuma.availableModes = [FusumaMode.library, FusumaMode.camera]
        fusumaCameraTitle = "Camera"
        fusuma.allowMultipleSelection = false
        
        return fusuma
    }
}
