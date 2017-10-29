//
//  ColorCell.swift
//  PersonalFinance
//
//  Created by Cookie on 29.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureCell(index: Int) {
        colorView.backgroundColor = CATEGORY_COLORS[index]
    }
    
    func setupView() {
        self.colorView.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
