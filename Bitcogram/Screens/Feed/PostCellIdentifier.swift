//
//  PostCellIdentifier.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/9/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import Parse

class PostCellIdentifier: UITableViewCell {
    var ownerAvatar = UIImageView()
    var ownerName = UILabel()
    var postImage = UIImageView()
    var ownerNameText = UILabel()
    var postText = UILabel()
    var postDate = UILabel()
    var likeButton = UIButton()
    var postLikes = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.accessoryType = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews ()
    {
        super.layoutSubviews()
        self.buildUI(in: contentView)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        ownerAvatar.image = nil
        ownerName.text = ""
        postImage.image = nil
        ownerNameText.text = ""
        postText.text = ""
        postDate.text = ""
    }
    
    private func buildUI(in container: UIView) {
        ownerAvatar = PostsUI.addOwnerAvatar(in: container)
        ownerName = PostsUI.addOwnerName(in: container)
        postImage = PostsUI.addPostImage(in: container)
        ownerNameText = PostsUI.addOwnerNameText(in: container)
        postText = PostsUI.addPostText(in: container)
        likeButton = PostsUI.addLikeButton(in: container)
        postLikes = PostsUI.addLikeText(in: container)
        postDate = PostsUI.addDateText(in: container)
        
    }
    
    public func customize(with post: PFObject) {

        let userImageFile = post["image"] as! PFFileObject
        userImageFile.getDataInBackground (block: { (data, error) -> Void in
            if error == nil {
                if let imageData = data {
                    self.postImage.image = UIImage(data:imageData)
                    self.postText.text = post["caption"] as? String
                    self.ownerName.text = post["ownerName"] as? String
                    self.ownerNameText.text = post["ownerName"] as? String
                    let likes = post["likes"] as? NSNumber
                    self.postLikes.text = likes!.stringValue + " likes"
                    let date = post.createdAt
                    self.postDate.text = date?.timeAgo(numericDates: true)
                }
            }
        })
        let ownerAvatarFile = post["ownerAvatar"] as! PFFileObject
        ownerAvatarFile.getDataInBackground (block: { (data, error) -> Void in
            if error == nil {
                if let imageData = data {
                    self.ownerAvatar.image = UIImage(data:imageData)
                }
            }
        })
        
        likeButton.addTarget(self, action: #selector(likePost), for:.touchUpInside)
    }
    
    @objc func likePost(sender:UIButton!) {
        
    }
}
