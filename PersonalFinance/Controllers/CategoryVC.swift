//
//  CategoryVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: CategoryVCDelegate?
    
    var service: CategoryService?
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        service = CategoryService()
        service?.delegate = self
        
        service?.loadCategories()
        self.title = "Categories"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddCategory))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func goToAddCategory() {
        performSegue(withIdentifier: "add category", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        service?.loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

protocol CategoryVCDelegate {
    func didSelectCategory(_ category: Category)
}

extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell {
            cell.categoryName.text = categories[indexPath.row].name
            cell.categoryColor.backgroundColor = UIColor.returnUIColor(components: categories[indexPath.row].color)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        delegate?.didSelectCategory(category)
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}


extension CategoryVC: CategoryServiceDelegate {
    func didGetCategoriesSuccess(with categories: [Category]) {
        self.categories = categories
        updateUI()
    }
}
