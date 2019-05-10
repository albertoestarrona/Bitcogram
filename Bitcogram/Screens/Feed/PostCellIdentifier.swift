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

    var subscribeButtonAction : (() -> ())?
    
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
        postLikes.text = ""
        likeButton.setBackgroundImage(UIImage(named: "like-normal"), for: .normal)
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
        
        self.likeButton.addTarget(self, action: #selector(subscribeButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func subscribeButtonTapped(_ sender: UIButton){
        subscribeButtonAction?()
    }
}
