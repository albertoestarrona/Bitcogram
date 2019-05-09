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
import YPImagePicker

class CameraPostScreen : UIViewController, NVActivityIndicatorViewable {

    var picker = YPImagePicker()
    var config = YPImagePickerConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                self.tabBarController?.selectedIndex = 0
                print("Picker was canceled")
            }
            if let photo = items.singlePhoto {
                let nextViewController = SharePostScreen()
                nextViewController.imageSelected = photo.image
                self.navigationController?.pushViewController(nextViewController, animated: true)
                print("Picker have picture")
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    
    func createUI(in container: UIView) {
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = false
        config.showsFilters = true
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "Bitcogram"
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library, .photo]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.cappedTo(size: 1024)
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        config.colors.navigationBarActivityIndicatorColor = UIColor.gray
        config.colors.tintColor = UIColor.gray
        
        navigationItem.title = "Share an image"
        container.backgroundColor = .white
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        container.addSubview(activityIndicator)
        
        let labelLoading = UILabel()
        labelLoading.textColor = .gray
        labelLoading.textAlignment = .center
        labelLoading.adjustsFontSizeToFitWidth = true
        labelLoading.font = UIFont.systemFont(ofSize: 15.0)
        labelLoading.text = "Loading camera and filters..."
        container.addSubview(labelLoading)
        
        activityIndicator.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
        labelLoading.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(activityIndicator.snp.centerX)
            make.left.equalTo(container).offset(30)
            make.right.equalTo(container).offset(-30)
            make.bottom.equalTo(activityIndicator.safeAreaLayoutGuide.snp.top).offset(-20)
        }
    }
}
