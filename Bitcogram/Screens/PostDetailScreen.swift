//
//  PostDetailScreen.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/10/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Parse

class PostDetailScreen : UIViewController {
    public var post : PFObject?
    
    var ownerAvatar = UIImageView()
    var ownerName = UILabel()
    var postImage = UIImageView()
    var ownerNameText = UILabel()
    var postText = UILabel()
    var postDate = UILabel()
    var likeButton = UIButton()
    var postLikes = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
        setData()
    }
    
    func createUI(in container: UIView) {
        container.backgroundColor = .white
        
        ownerAvatar = PostsUI.addOwnerAvatar(in: container)
        ownerName = PostsUI.addOwnerName(in: container)
        postImage = PostsUI.addPostImage(in: container)
        ownerNameText = PostsUI.addOwnerNameText(in: container)
        postText = PostsUI.addPostText(in: container)
        likeButton = PostsUI.addLikeButton(in: container)
        postLikes = PostsUI.addLikeText(in: container)
        postDate = PostsUI.addDateText(in: container)
    }
    
    func setData() {
        let liked: NSArray? = PFUser.current()?["liked"] as? NSArray
        let postId = post?.objectId
        let userImageFile = post?["image"] as! PFFileObject
        userImageFile.getDataInBackground (block: { (data, error) -> Void in
            if error == nil {
                if let imageData = data {
                    self.postImage.image = UIImage(data:imageData)
                    self.postText.text = self.post?["caption"] as? String
                    self.ownerName.text = self.post?["ownerName"] as? String
                    self.ownerNameText.text = self.post?["ownerName"] as? String
                    let likes = self.post?["likes"] as? NSNumber
                    self.postLikes.text = likes!.stringValue + " likes"
                    let date = self.post?.createdAt
                    self.postDate.text = date?.timeAgo(numericDates: true)
                    if (liked?.contains(postId))! {
                        self.likeButton.setBackgroundImage(UIImage(named: "like-pushed"), for: .normal)
                        self.likeButton.isEnabled = false
                    }
                }
            }
        })
    }
}
