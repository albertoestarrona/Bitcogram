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
import Parse

class SignupUserScreen : UIViewController, KeyboardDismissable, UITextFieldDelegate, NVActivityIndicatorViewable {
    var activity: NVActivityIndicatorView?
    var keyboardDismissAction: SelectorWrapper?
    var inputUsername = UITextField()
    var inputEmail = UITextField()
    var inputPassword = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
        keyboardDismissAction = setupKeyboardDismissRecognizer()
    }
    
    func createUI(in container: UIView) {
        container.backgroundColor = .white
        activity = ActivityIndicator.build(in: container)
        
        let labelTitle = UILabel()
        labelTitle.textColor = .gray
        labelTitle.textAlignment = .center
        labelTitle.adjustsFontSizeToFitWidth = true
        labelTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        labelTitle.text = "Create your account in Bitcogram"
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
        
        inputEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        inputEmail.borderStyle = UITextField.BorderStyle.none
        inputEmail.backgroundColor = nil
        inputEmail.textColor = UIColor.black
        inputEmail.keyboardType = UIKeyboardType.emailAddress
        inputEmail.autocapitalizationType = UITextAutocapitalizationType.none
        inputEmail.autocorrectionType = UITextAutocorrectionType.no
        inputEmail.background = UIImage(named: "line")
        inputEmail.delegate = self
        container.addSubview(inputEmail)
        
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
        
        let buttonSignup = UIButton()
        buttonSignup.setTitleColor(UIColor.blue, for: .normal)
        buttonSignup.setTitleColor(UIColor.lightGray, for: .highlighted)
        buttonSignup.backgroundColor = UIColor.clear
        buttonSignup.setTitle("Submit", for: .normal)
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
        inputEmail.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.left.equalTo(container).offset(30)
            make.right.equalTo(container).offset(-30)
            make.bottom.equalTo(inputUsername.safeAreaLayoutGuide.snp.bottom).offset(50)
        }
        inputPassword.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.left.equalTo(container).offset(30)
            make.right.equalTo(container).offset(-30)
            make.bottom.equalTo(inputEmail.safeAreaLayoutGuide.snp.bottom).offset(50)
        }
        buttonSignup.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(inputPassword.safeAreaLayoutGuide.snp.bottom).offset(60)
        }
    }
    
    @objc func signupFlow(sender:UIButton!) {
        do {
            let user = PFUser()
            user.username = try inputUsername.validatedText(validationType: ValidatorType.username)
            user.email = try inputEmail.validatedText(validationType: ValidatorType.email)
            user.password = try inputPassword.validatedText(validationType: ValidatorType.password)
            self.startAnimating()
            
            user.signUpInBackground { (success, error) in
                self.stopAnimating()
                if success{
                    self.view.window!.rootViewController = selectViewController()
                }else{
                    if let description = error?.localizedDescription{
                        presentError(controller: self, title: "Error", error: description)
                    }
                }
            }
        } catch(let error) {
            self.stopAnimating()
            presentError(controller: self, title: "Error", error: (error as! ValidationError).message)
        }
    }
}
