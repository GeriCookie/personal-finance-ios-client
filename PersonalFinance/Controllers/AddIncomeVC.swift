//
//  AddIncomeVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class AddIncomeVC: UIViewController {

    var category: Category?
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryColor: UILabel!
    @IBOutlet weak var amountField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onAddClicked(_ sender: UIButton) {
        //Check if amount is double
        guard let amount = amountField.text, amountField.text != "" else {
            return
        }
        
        
    }
    @IBAction func datePickerAction(_ sender: Any) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var strDate = dateFormatter.string(from: datePicker.date)
        print(strDate)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "choose category") {
            let modal = segue.destination
            guard let categoryVC = modal as? CategoryVC else {
                return
            }
            
            categoryVC.delegate = self
        }
    }
}

extension AddIncomeVC: CategoryVCDelegate {
    func didSelectCategory(_ category: Category) {
        categoryName.text = category.name
        categoryColor.text = category.color
        self.category = category
    }
}
