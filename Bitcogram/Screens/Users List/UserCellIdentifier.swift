//
//  UserCellIdentifier.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/10/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import Parse

class UserCellIdentifier: UITableViewCell {
    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.buildUI(in: contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func buildUI(in container: UIView) {
        container.addSubview(userName)
        container.backgroundColor = .clear
        userName.snp.makeConstraints { make -> Void in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalTo(container).offset(32)
        }
    }
    
    public func customize(with user: PFUser) {
        self.userName.text = user.username
    }
}
