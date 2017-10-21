//
//  IncomeCell.swift
//  PersonalFinance
//
//  Created by Cookie on 21.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class IncomeCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
