//
//  SignupUserScreen.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/7/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class SignupUserScreen : UIViewController, KeyboardDismissable {
    var activity: NVActivityIndicatorView?
    var keyboardDismissAction: SelectorWrapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
        keyboardDismissAction = setupKeyboardDismissRecognizer()
    }
    
    func createUI(in container: UIView) {
        container.backgroundColor = .white
        activity = ActivityIndicator.build(in: container)
        
        let labelTitle = UILabel()
        labelTitle.textColor = .black
        labelTitle.textAlignment = .center
        labelTitle.sizeToFit()
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        labelTitle.text = "Sign Up"
        container.addSubview(labelTitle)
        
    }
}
