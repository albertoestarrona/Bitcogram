//
//  Logo.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/7/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import Foundation
import SnapKit

struct Logo {
    
    @discardableResult static func build(in container: UIView, height: Float, bottomOffset: Float) -> UIView {
        let logo = UIImage(named: "logo_white.jpg")
        let logoImageView = UIImageView()
        logoImageView.contentMode =  UIView.ContentMode.scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.image = logo
        container.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(height)
            make.left.equalTo(container)
            make.right.equalTo(container)
            make.bottom.equalTo(container.safeAreaLayoutGuide.snp.bottom).offset(-bottomOffset)
        }
        
        return logoImageView
    }
    
}
