//
//  ViewController.swift
//  PersonalFinance
//
//  Created by Cookie on 4.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    var userService: UserService?
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        userService = UserService()
        userService?.delegate = self
    }

    @IBAction func onRegisterClick(_ sender: Any) {
        guard let username = usernameField.text, usernameField.text != "" else {
            return
        }
        guard let email = emailField.text, emailField.text != "" else {
            return
        }
        guard let password = passwordField.text, passwordField.text != "" else {
            return
        }
        
        userService?.registerUser(with: username, email: email, password: password)
    }
    
    func setupView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    

}

extension RegisterVC : UserServiceDelegate {
    func didRegisterSuccess() {
        print("FINALLLYY!!!!!!")
    }
    

}

