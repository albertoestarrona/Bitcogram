//
//  UIViewController+Extentions.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/7/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import Foundation
import UIKit

class SelectorWrapper: NSObject {
    
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    @objc func doAction() {
        action()
    }
}

extension KeyboardDismissable where Self: UIViewController {
    
    func setupKeyboardDismissRecognizer() -> SelectorWrapper {
        let wrapper = SelectorWrapper(action: { [weak self] in
            self?.view.endEditing(true)
        })
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: wrapper,
            action: #selector(wrapper.doAction)
        )
        self.view.addGestureRecognizer(tapRecognizer)
        
        return wrapper
    }
    
}
