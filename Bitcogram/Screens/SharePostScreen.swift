//
//  SharePostScreen.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/8/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Parse

class SharePostScreen : UIViewController, NVActivityIndicatorViewable, KeyboardDismissable, UITextViewDelegate {
    
    public var imageSelected : UIImage?
    var imageContainer = UIImageView()
    let inputImageText = UITextView()
    var keyboardDismissAction: SelectorWrapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
        keyboardDismissAction = setupKeyboardDismissRecognizer()
    }
    
    func createUI(in container: UIView) {
        navigationItem.title = "Post your picture"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(postPicture))
        container.backgroundColor = .white
     
        imageContainer = UIImageView(frame: CGRect(x:0, y:0, width: 90, height: 90))
        imageContainer.contentMode =  UIView.ContentMode.scaleAspectFit
        imageContainer.layer.masksToBounds = false
        imageContainer.clipsToBounds = true
        imageContainer.image = imageSelected
        container.addSubview(imageContainer)
        
        let labelCaption = UILabel()
        labelCaption.textColor = .gray
        labelCaption.textAlignment = .left
        labelCaption.adjustsFontSizeToFitWidth = true
        labelCaption.font = UIFont.systemFont(ofSize: 11.0)
        labelCaption.text = "Write a caption"
        container.addSubview(labelCaption)
        
        inputImageText.textAlignment = NSTextAlignment.left
        inputImageText.backgroundColor = UIColor.clear
        inputImageText.textColor = UIColor.black
        inputImageText.font = UIFont.systemFont(ofSize: 16)
        inputImageText.keyboardType = UIKeyboardType.default
        inputImageText.delegate = self
        container.addSubview(inputImageText)
        
        let lineImageView = UIImageView()
        lineImageView.contentMode =  UIView.ContentMode.scaleToFill
        lineImageView.clipsToBounds = true
        lineImageView.image = UIImage(named: "line")
        container.addSubview(lineImageView)
        
        let labelFacebook = UILabel()
        labelFacebook.textColor = .black
        labelFacebook.textAlignment = .left
        labelFacebook.adjustsFontSizeToFitWidth = true
        labelFacebook.font = UIFont.systemFont(ofSize: 16.0)
        labelFacebook.text = "Facebook"
        container.addSubview(labelFacebook)
        
        let labelTwitter = UILabel()
        labelTwitter.textColor = .black
        labelTwitter.textAlignment = .left
        labelTwitter.adjustsFontSizeToFitWidth = true
        labelTwitter.font = UIFont.systemFont(ofSize: 16.0)
        labelTwitter.text = "Twitter"
        container.addSubview(labelTwitter)
        
        let switchFacebook = UISwitch()
        switchFacebook.isOn = false
        switchFacebook.addTarget(self, action: #selector(shareSwitch), for: .valueChanged)
        container.addSubview(switchFacebook)
        
        let switchTwitter = UISwitch()
        switchTwitter.isOn = false
        switchTwitter.addTarget(self, action: #selector(shareSwitch), for: .valueChanged)
        container.addSubview(switchTwitter)
        
        imageContainer.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(90)
            make.width.equalTo(90)
            make.left.equalTo(container).offset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        labelCaption.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(imageContainer.snp.right).offset(8)
            make.right.equalTo(container).offset(-20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(26)
        }
        inputImageText.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
            make.left.equalTo(imageContainer.snp.right).offset(8)
            make.right.equalTo(container).offset(-20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(36)
        }
        lineImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(20)
            make.left.equalTo(container)
            make.right.equalTo(container)
            make.top.equalTo(inputImageText.snp.top).offset(120)
        }
        labelFacebook.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(container).offset(30)
            make.right.equalTo(container).offset(-30)
            make.top.equalTo(lineImageView.snp.bottom).offset(30)
        }
        switchFacebook.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(container).offset(-30)
            make.top.equalTo(lineImageView.snp.bottom).offset(19)
        }
        labelTwitter.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(container).offset(30)
            make.right.equalTo(container).offset(-30)
            make.top.equalTo(labelFacebook.snp.top).offset(55)
        }
        switchTwitter.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(container).offset(-30)
            make.top.equalTo(labelTwitter.snp.top).offset(-5)
        }
    }
    
    @objc func postPicture(sender:UIButton!) {
        // Create Post Object and save it to backend
        let finalPost = PFObject(className:"Post")
        finalPost["owner"] = PFUser.current()?.objectId
        finalPost["caption"] = inputImageText.text
        finalPost["likes"] = 0
        let imageFinal : UIImage? = imageSelected!.resized(toWidth: 1024)
        saveImageToParse(object: finalPost, image: imageFinal!, key: "image", viewController: self)
        
        // Update Posts count for the user
        PFUser.current()?.incrementKey("posts")
        PFUser.current()?.saveInBackground()
        
        // Reset Navigation
        self.tabBarController?.selectedIndex = 0
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func shareSwitch(sender:UISwitch!) {
        sender.setOn(false, animated: true)
        presentAlert(controller: self, title: "No way!", message: "Why in the world would you want to publish this image over regular social networks? \nWe DO CARE about your privacy, so we won't let you do this. We encourage the use of safer social networks (like Bitcogram) but in case you still want to do it, we storage a copy of this image in your library.")
    }
}
