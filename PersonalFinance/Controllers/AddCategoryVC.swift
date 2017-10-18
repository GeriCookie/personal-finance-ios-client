//
//  AddCategoryVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class AddCategoryVC: UIViewController {

    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    var categoryService: CategoryService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryService = CategoryService()
        categoryService?.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onAddCategoryClicked(_ sender: Any) {
        guard let name = nameField.text, nameField.text != "" else {
            return
        }
        guard let color = colorField.text, colorField.text != "" else {
            return
        }
        categoryService?.addCategory(with: name, color: color)
    }

}

extension AddCategoryVC : CategoryServiceDelegate {
    func didGetCategoriesSuccess(with: [Category]) {

    }
    
    func didPostCategoriesSuccess() {
        print("Category posted")
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

