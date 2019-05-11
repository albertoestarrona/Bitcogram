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
        
        let isotype = UIImage(named: "isotype")
        let isoImageView = UIImageView()
        isoImageView.contentMode =  UIView.ContentMode.scaleAspectFit
        isoImageView.clipsToBounds = true
        isoImageView.image = isotype
        container.addSubview(isoImageView)
        
        logoImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(height)
            make.left.equalTo(container)
            make.right.equalTo(container)
            make.bottom.equalTo(container.safeAreaLayoutGuide.snp.bottom).offset(-bottomOffset)
        }
        isoImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(height/4                                )
            make.left.equalTo(container)
            make.right.equalTo(container)
            make.bottom.equalTo(logoImageView.safeAreaLayoutGuide.snp.bottom).offset(30)
        }
        
        return logoImageView
    }
    
}
