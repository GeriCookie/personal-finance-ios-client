//
//  AddCategoryVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class AddCategoryVC: UIViewController {

    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameField: UITextField!
    var color: UIColor = .white
    
    var categoryService: CategoryService?
    
    @IBOutlet weak var categoryButton: RoundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryService = CategoryService()
        categoryService?.delegate = self
        self.title = "Add Category"
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
        let colorString = UIColor.stringFromUIColor(color: color)
        
        categoryService?.addCategory(with: name, color: colorString)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = "chooseColor"
        if segue.identifier == identifier {
            if let nextVC = segue.destination as? ChooseColorVC {
                nextVC.delegate = self
            }
        }
    }
}

extension AddCategoryVC : CategoryServiceDelegate {
    func didPostCategoriesSuccess() {
        let msg = "Category added"
        showSuccess(with: msg)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension AddCategoryVC: ChooseColorVCDelegate {
    func didChooseColor(color: UIColor) {
        self.color = color
        self.colorView.backgroundColor = color
        self.categoryButton.setTitle("Change Color", for: .normal)
    }
}

