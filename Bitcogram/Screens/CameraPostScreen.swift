//
//  CameraPostScreen.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/8/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Fusuma

class CameraPostScreen : UIViewController, FusumaDelegate, NVActivityIndicatorViewable {

    var fusuma = FusumaViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.present(fusuma, animated: true, completion: nil)
    }
    
    func createUI(in container: UIView) {
        fusuma = FusumaConfig.initFusuma(in: self, fusuma: fusuma)
        
        navigationItem.title = "Share an image"
        container.backgroundColor = .white
    }
    
    // MARK: FusumaDelegate
    func fusumaWillClosed() {
        self.tabBarController?.selectedIndex = 0
        print("User cancelled")
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        let nextViewController = SharePostScreen()
        nextViewController.imageSelected = image
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        
    }
    
    func fusumaCameraRollUnauthorized() {
        
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        
    }
}
