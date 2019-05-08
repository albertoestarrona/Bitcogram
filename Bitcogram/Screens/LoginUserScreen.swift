//
//  LoginUserScreen.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/7/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Parse

class LoginUserScreen : UIViewController, KeyboardDismissable, UITextFieldDelegate, NVActivityIndicatorViewable {
    var keyboardDismissAction: SelectorWrapper?
    var inputUsername = UITextField()
    var inputPassword = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
        keyboardDismissAction = setupKeyboardDismissRecognizer()
    }
    
    func createUI(in container: UIView) {
        container.backgroundColor = .white
        
        let labelTitle = UILabel()
        labelTitle.textColor = .gray
        labelTitle.textAlignment = .center
        labelTitle.adjustsFontSizeToFitWidth = true
        labelTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        labelTitle.text = "Enter to your account"
        container.addSubview(labelTitle)
        
        inputUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        inputUsername.borderStyle = UITextField.BorderStyle.none
        inputUsername.backgroundColor = nil
        inputUsername.textColor = UIColor.black
        inputUsername.keyboardType = UIKeyboardType.default
        inputUsername.autocapitalizationType = UITextAutocapitalizationType.none
        inputUsername.autocorrectionType = UITextAutocorrectionType.no
        inputUsername.background = UIImage(named: "line")
        inputUsername.delegate = self
        container.addSubview(inputUsername)
        
        inputPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        inputPassword.borderStyle = UITextField.BorderStyle.none
        inputPassword.backgroundColor = nil
        inputPassword.textColor = UIColor.black
        inputPassword.keyboardType = UIKeyboardType.default
        inputPassword.isSecureTextEntry = true
        inputPassword.autocapitalizationType = UITextAutocapitalizationType.none
        inputPassword.autocorrectionType = UITextAutocorrectionType.no
        inputPassword.background = UIImage(named: "line")
        inputPassword.delegate = self
        container.addSubview(inputPassword)
        
        let buttonLogin = UIButton()
        buttonLogin.setTitleColor(UIColor.blue, for: .normal)
        buttonLogin.setTitleColor(UIColor.lightGray, for: .highlighted)
        buttonLogin.backgroundColor = UIColor.clear
        buttonLogin.setTitle("Submit", for: .normal)
        buttonLogin.addTarget(self, action: #selector(loginFlow), for: .touchUpInside)
        container.addSubview(buttonLogin)
        
        let labelSignup = UILabel()
        labelSignup.textColor = .gray
        labelSignup.textAlignment = .center
        labelSignup.adjustsFontSizeToFitWidth = true
        labelSignup.font = UIFont.systemFont(ofSize: 15.0)
        labelSignup.text = "If you don't have an account go to"
        container.addSubview(labelSignup)
        
        let buttonSignup = UIButton()
        buttonSignup.setTitleColor(UIColor.black, for: .normal)
        buttonSignup.setTitleColor(UIColor.lightGray, for: .highlighted)
        buttonSignup.backgroundColor = UIColor.clear
        buttonSignup.titleLabel?.font = .systemFont(ofSize: 15)
        buttonSignup.setTitle("Sign Up", for: .normal)
        buttonSignup.addTarget(self, action: #selector(signupFlow), for: .touchUpInside)
        container.addSubview(buttonSignup)
        
        labelTitle.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.left.equalTo(container).offset(30)
            make.right.equalTo(container).offset(-30)
            make.bottom.equalTo(container.safeAreaLayoutGuide.snp.top).offset(50)
        }
        inputUsername.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.left.equalTo(container).offset(30)
            make.right.equalTo(container).offset(-30)
            make.bottom.equalTo(labelTitle.safeAreaLayoutGuide.snp.bottom).offset(50)
        }
        inputPassword.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.left.equalTo(container).offset(30)
            make.right.equalTo(container).offset(-30)
            make.bottom.equalTo(inputUsername.safeAreaLayoutGuide.snp.bottom).offset(50)
        }
        buttonLogin.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(inputPassword.safeAreaLayoutGuide.snp.bottom).offset(60)
        }
        labelSignup.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.left.equalTo(container).offset(30)
            make.right.equalTo(container).offset(-30)
            make.bottom.equalTo(buttonLogin.safeAreaLayoutGuide.snp.bottom).offset(60)
        }
        buttonSignup.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(labelSignup.safeAreaLayoutGuide.snp.bottom).offset(30)
        }
    }
    
    @objc func loginFlow(sender:UIButton!) {
        self.startAnimating()
        PFUser.logInWithUsername(inBackground: inputUsername.text!, password: inputPassword.text!) { (user, error) in
            self.stopAnimating()
            if user != nil {
                // TODO Go to FEED
            } else {
                if let description = error?.localizedDescription {
                    presentError(controller: self, title: "Error", error: description)
                }
            }
        }
    }
    
    @objc func signupFlow(sender:UIButton!) {
        let sigupViewController = SignupUserScreen()
        sigupViewController.navigationItem.title = "Sign Up"
        self.navigationController?.pushViewController(sigupViewController, animated: true)
    }
}
