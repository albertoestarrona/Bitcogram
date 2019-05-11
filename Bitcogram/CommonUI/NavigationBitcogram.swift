//
//  NavigationBitcogram.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/8/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit

final class NavigationBitcogram: UINavigationController {
    
    convenience init() {
        self.init(rootViewController: UIViewController())
        self.navigationBar.tintColor = .lightGray
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
    }
}
