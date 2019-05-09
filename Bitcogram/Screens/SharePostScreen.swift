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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: #selector(postPicture))
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
}
