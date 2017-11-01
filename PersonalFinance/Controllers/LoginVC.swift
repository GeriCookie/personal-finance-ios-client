//
//  LoginVC.swift
//  PersonalFinance
//
//  Created by Cookie on 15.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    var userService: UserService?
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        userService = UserService()
        userService?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func onLoginClicked(_ sender: RoundedButton) {
        guard let username = usernameField.text, usernameField.text != "" else {
            return
        }
        guard let password = passwordField.text, passwordField.text != "" else {
            return
        }
        
        userService?.loginUser(with: username, password: password)
    }
    
    func setupView() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
}

extension LoginVC: UserServiceDelegate {
    func didRegisterSuccess() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
