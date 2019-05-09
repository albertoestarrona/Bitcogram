//
//  ProfileUserScreen.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/7/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Parse
import Fusuma

class ProfileUserScreen : UIViewController, FusumaDelegate, NVActivityIndicatorViewable {
    
    var currentUser = PFUser.current()
    var fusuma = FusumaViewController()
    var avatarImageView = UIImageView()
    var labelFollowersCount = UILabel()
    var labelFollowingCount = UILabel()
    var labelPostsCount = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
        self.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getUserData()
    }
    
    func createUI(in container: UIView) {
        fusuma = FusumaConfig.initFusuma(in: self, fusuma: fusuma)
        
        navigationItem.title = currentUser?.username
        container.backgroundColor = .white
        
        let camera_img = UIImage(named: "camera-icon")
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(profileImageClicked))
        avatarImageView = UIImageView(frame: CGRect(x:0, y:0, width: 170, height: 170))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(singleTap)
        avatarImageView.contentMode =  UIView.ContentMode.scaleAspectFit
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.clipsToBounds = true
        avatarImageView.image = camera_img
        container.addSubview(avatarImageView)
        
        labelFollowersCount.textColor = .black
        labelFollowersCount.textAlignment = .center
        labelFollowersCount.adjustsFontSizeToFitWidth = true
        labelFollowersCount.font = UIFont.boldSystemFont(ofSize: 18.0)
        container.addSubview(labelFollowersCount)
        
        let labelFollowersTitle = UILabel()
        labelFollowersTitle.textColor = .gray
        labelFollowersTitle.textAlignment = .center
        labelFollowersTitle.adjustsFontSizeToFitWidth = true
        labelFollowersTitle.font = UIFont.systemFont(ofSize: 12.0)
        labelFollowersTitle.text = "Followers"
        container.addSubview(labelFollowersTitle)
        
        labelFollowingCount.textColor = .black
        labelFollowingCount.textAlignment = .center
        labelFollowingCount.adjustsFontSizeToFitWidth = true
        labelFollowingCount.font = UIFont.boldSystemFont(ofSize: 18.0)
        container.addSubview(labelFollowingCount)
        
        let labelFollowingTitle = UILabel()
        labelFollowingTitle.textColor = .gray
        labelFollowingTitle.textAlignment = .center
        labelFollowingTitle.adjustsFontSizeToFitWidth = true
        labelFollowingTitle.font = UIFont.systemFont(ofSize: 12.0)
        labelFollowingTitle.text = "Following"
        container.addSubview(labelFollowingTitle)
        
        labelPostsCount.textColor = .black
        labelPostsCount.textAlignment = .center
        labelPostsCount.adjustsFontSizeToFitWidth = true
        labelPostsCount.font = UIFont.boldSystemFont(ofSize: 18.0)
        container.addSubview(labelPostsCount)
        
        let labelPostsTitle = UILabel()
        labelPostsTitle.textColor = .gray
        labelPostsTitle.textAlignment = .center
        labelPostsTitle.adjustsFontSizeToFitWidth = true
        labelPostsTitle.font = UIFont.systemFont(ofSize: 12.0)
        labelPostsTitle.text = "Posts"
        container.addSubview(labelPostsTitle)
        
        avatarImageView.snp.remakeConstraints { (make) -> Void in
            make.height.equalTo(170)
            make.width.equalTo(170)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(190)
        }
        labelFollowersCount.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarImageView.safeAreaLayoutGuide.snp.bottom).offset(20)
        }
        labelFollowersTitle.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.centerX.equalTo(labelFollowersCount.snp.centerX)
            make.top.equalTo(labelFollowersCount.safeAreaLayoutGuide.snp.bottom).offset(8)
        }
        labelPostsCount.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.right.equalTo(labelFollowersCount.snp.left).offset(-50)
            make.top.equalTo(avatarImageView.safeAreaLayoutGuide.snp.bottom).offset(20)
        }
        labelPostsTitle.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.centerX.equalTo(labelPostsCount.snp.centerX)
            make.top.equalTo(labelPostsCount.safeAreaLayoutGuide.snp.bottom).offset(8)
        }
        labelFollowingCount.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.left.equalTo(labelFollowersCount.snp.right).offset(50)
            make.top.equalTo(avatarImageView.safeAreaLayoutGuide.snp.bottom).offset(20)
        }
        labelFollowingTitle.snp.remakeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.centerX.equalTo(labelFollowingCount.snp.centerX)
            make.top.equalTo(labelFollowingCount.safeAreaLayoutGuide.snp.bottom).offset(8)
        }
    }
    
    // Reload CurrentUser
    func getUserData()  {
        do {
            self.startAnimating()
            try PFUser.current()?.fetch()
            currentUser = PFUser.current()
            let followers = currentUser?.object(forKey: "followers") as! NSNumber
            labelFollowersCount.text = followers.stringValue
            let following = currentUser?.object(forKey: "following") as! NSNumber
            labelFollowingCount.text = following.stringValue
            let posts = currentUser?.object(forKey: "posts") as! NSNumber
            labelPostsCount.text = posts.stringValue
            let userImageFile = currentUser?["avatar"] as! PFFileObject
            userImageFile.getDataInBackground (block: { (data, error) -> Void in
                if error == nil {
                    if let imageData = data {
                        self.avatarImageView.image = UIImage(data:imageData)
                    }
                }
            })
            self.stopAnimating()
        } catch(let error) {
            self.stopAnimating()
            presentError(controller: self, title: "Error", error: error.localizedDescription)
        }
    }
    
    // Profile picture capture
    @objc func profileImageClicked() {
        self.present(fusuma, animated: true, completion: nil)
    }
    
    // MARK: FusumaDelegate
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        avatarImageView.image = image
        
        let avatar = image.resized(toWidth: 512)
        saveImageToParse(object: currentUser!, image: avatar!, key: "avatar", viewController: self)
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
    }
    
    func fusumaCameraRollUnauthorized() {
    }
    
}
