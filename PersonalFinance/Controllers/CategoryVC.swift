//
//  CategoryVC.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    let REUSE_CELL_IDENTIFIER = "category-cell"

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: CategoryVCDelegate?
    
    var service: CategoryService?
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoryCell.self, forCellReuseIdentifier: REUSE_CELL_IDENTIFIER)
        
        service = CategoryService()
        service?.delegate = self
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_CELL_IDENTIFIER)
        cell?.textLabel?.text = categories[indexPath.row].name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        delegate?.didSelectCategory(category)
        self.dismiss(animated: true, completion: nil)
    }
}


extension CategoryVC: CategoryServiceDelegate {
    func didGetCategoriesSuccess(with categories: [Category]) {
        self.categories = categories
        updateUI()
    }
}
