//
//  ViewController+Notification.swift
//  PersonalFinance
//
//  Created by Cookie on 15.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(withMessage message: String) {
        let alert = UIAlertController(title: "Oppps. Something happend", message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.show(alert, sender: self)
        }
    }
    
    func showSuccess(with message: String) {
        let alert = UIAlertController(title: "Yuhuuuu", message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.show(alert, sender: self)
        }
    }
}
