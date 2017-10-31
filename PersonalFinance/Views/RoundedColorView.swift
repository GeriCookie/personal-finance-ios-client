//
//  RoundedColorViewController.swift
//  PersonalFinance
//
//  Created by Cookie on 1.11.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class RoundedColorView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
}
