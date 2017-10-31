//
//  ViewController+Notification.swift
//  PersonalFinance
//
//  Created by Cookie on 15.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit
import Toaster

extension UIViewController {
    func showError(withMessage message: String) {
        Toast(text: message)
            .show()
//        let alert = UIAlertController(title: "Oppps. Something happend", message: message, preferredStyle: .alert)
//        DispatchQueue.main.async {
//            self.show(alert, sender: self)
//        }
    }

    func showSuccess(with message: String) {
        Toast(text: message)
            .show()
    }
}
