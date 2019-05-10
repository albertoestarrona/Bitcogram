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

class ProfileUserScreen : UIViewController, FusumaDelegate, NVActivityIndicatorViewable, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var currentUser = PFUser.current()
    public var userFromSearch = false
    var fusuma = FusumaViewController()
    var avatarImageView = UIImageView()
    var labelFollowersCount = UILabel()
    var labelFollowingCount = UILabel()
    var labelPostsCount = UILabel()
    var pictures = [PFObject]()
    var picturesCollectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
        self.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getUserData()
        getUserPictures()
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
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (container.frame.size.width/3)-2, height: (container.frame.size.width/3)-2)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        picturesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        picturesCollectionView!.dataSource = self
        picturesCollectionView!.delegate = self
        picturesCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "pictureCell")
        picturesCollectionView!.backgroundColor = UIColor.clear
        container.addSubview(picturesCollectionView!)
        
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
        picturesCollectionView?.snp.remakeConstraints { (make) -> Void in
            make.left.equalTo(container.snp.left)
            make.right.equalTo(container.snp.right)
            make.centerX.equalToSuperview()
            make.top.equalTo(labelFollowingTitle.safeAreaLayoutGuide.snp.bottom).offset(40)
            make.bottom.equalTo(container.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // Reload CurrentUser
    func getUserData()  {
        do {
            self.startAnimating()
            if !userFromSearch {
                try PFUser.current()?.fetch()
                currentUser = PFUser.current()
            }
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
    
    func getUserPictures()  {
        let query = PFQuery(className:"Post")
        let userId = currentUser?.objectId
        query.whereKey("owner", equalTo: userId!)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            self.stopAnimating()
            if let error = error {
                print(error.localizedDescription)
            } else if let objects = objects {
                self.pictures = objects
                self.picturesCollectionView?.reloadData()
            }
        }
    }
    
    // Profile picture capture
    @objc func profileImageClicked() {
        self.present(fusuma, animated: true, completion: nil)
    }
    
    //MARK: FusumaDelegate
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
    
    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = PostDetailScreen()
        detailViewController.navigationItem.title = ""
        detailViewController.post = pictures[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath as IndexPath)
        myCell.backgroundColor = UIColor.blue
        
        let image = UIImageView(frame: CGRect(x:0, y:0, width: myCell.frame.size.width, height: myCell.frame.size.width))
        image.contentMode =  UIView.ContentMode.scaleAspectFit
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.image = UIImage(named: "camera-icon")
        image.backgroundColor = .clear
        myCell.addSubview(image)
        
        let userImageFile = pictures[indexPath.row]["image"] as! PFFileObject
        userImageFile.getDataInBackground (block: { (data, error) -> Void in
            if error == nil {
                if let imageData = data {
                    image.image = UIImage(data:imageData)
                }
            }
        })
        
        return myCell
    }
}
