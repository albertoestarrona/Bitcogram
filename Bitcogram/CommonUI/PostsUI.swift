//
//  PostsUI.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/9/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import Foundation
import UIKit

struct PostsUI {
    
    static func addOwnerAvatar(in container: UIView) -> UIImageView {
        let avatar = UIImageView(frame: CGRect(x:20, y:10, width: 50, height: 50))
        avatar.contentMode =  UIView.ContentMode.scaleAspectFit
        avatar.layer.borderWidth = 1
        avatar.layer.masksToBounds = false
        avatar.layer.borderColor = UIColor.gray.cgColor
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.clipsToBounds = true
        avatar.image = UIImage(named: "camera-icon")
        container.addSubview(avatar)
        
        return avatar
    }
    
    static func addOwnerName(in container: UIView) -> UILabel {
        let name = UILabel(frame: CGRect(x:80, y:20, width: container.frame.size.width - 95, height: 30))
        name.textColor = .black
        name.textAlignment = .left
        name.adjustsFontSizeToFitWidth = true
        name.font = UIFont.boldSystemFont(ofSize: 15.0)
        container.addSubview(name)
        
        return name
    }
    
    static func addPostImage(in container: UIView) -> UIImageView {
        let image = UIImageView(frame: CGRect(x:0, y:70, width: container.frame.size.width, height: container.frame.size.width))
        image.contentMode =  UIView.ContentMode.scaleAspectFit
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.image = UIImage(named: "camera-icon")
        image.backgroundColor = .clear
        container.addSubview(image)
        
        return image
    }
    
    static func addOwnerNameText(in container: UIView) -> UILabel {
        let name = UILabel(frame: CGRect(x:20, y: container.frame.size.width + 105, width: container.frame.size.width - 20, height: 30))
        name.textColor = .black
        name.textAlignment = .left
        name.adjustsFontSizeToFitWidth = true
        name.font = UIFont.boldSystemFont(ofSize: 15.0)
        container.addSubview(name)
        
        return name
    }
    
    static func addPostText(in container: UIView) -> UILabel {
        let text = UILabel(frame: CGRect(x:20, y: container.frame.size.width + 115, width: container.frame.size.width - 40, height: 60))
        text.textColor = .black
        text.textAlignment = .left
        text.adjustsFontSizeToFitWidth = true
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 14.0)
        container.addSubview(text)
        
        return text
    }
    
    static func addLikeButton(in container: UIView) -> UIButton {
        let buttonLike   = UIButton(type: .custom)
        buttonLike.frame = CGRect(x:20, y: container.frame.size.width + 75, width: 30, height: 30)
        buttonLike.setBackgroundImage(UIImage(named: "like-normal"), for: .normal)
        buttonLike.setBackgroundImage(UIImage(named: "like-pushed"), for: .highlighted)
        container.addSubview(buttonLike)
        
        return buttonLike
    }
    
    static func addLikeText(in container: UIView) -> UILabel {
        let likes = UILabel(frame: CGRect(x:55, y: container.frame.size.width + 75, width: container.frame.size.width - 70, height: 30))
        likes.textColor = .black
        likes.textAlignment = .left
        likes.adjustsFontSizeToFitWidth = true
        likes.font = UIFont.boldSystemFont(ofSize: 15.0)
        container.addSubview(likes)
        
        return likes
    }
    
    static func addDateText(in container: UIView) -> UILabel {
        let date = UILabel(frame: CGRect(x:20, y: container.frame.size.width + 160, width: container.frame.size.width - 70, height: 30))
        date.textColor = .gray
        date.textAlignment = .left
        date.adjustsFontSizeToFitWidth = true
        date.font = UIFont.systemFont(ofSize: 12.0)
        container.addSubview(date)
        
        return date
    }
}

