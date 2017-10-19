//
//  CategoryService.swift
//  PersonalFinance
//
//  Created by Cookie on 18.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class CategoryService {
    var delegate: CategoryServiceDelegate?
    var httpRequester: HttpRequester?
    var cacheService: CacheService?
    
    init() {
        httpRequester = HttpRequester()
        httpRequester?.delegate = self
        
        cacheService = CacheService()
    }
    
    func addCategory(with name: String, color: String) {
        let category = Category(with: name, and: color)
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(category)
        } catch {
            print(error)
        }
        
        httpRequester?.post(to: CATEGORY_URL, with: body)
    }
    
    func loadCategories() {
        httpRequester?.get(from: CATEGORY_URL)
    }
}

protocol CategoryServiceDelegate {
    func didGetCategoriesSuccess(with categories: [Category])
    func didPostCategoriesSuccess()
}

extension CategoryServiceDelegate {
    func didGetCategoriesSuccess(with categories: [Category]){}
    func didPostCategoriesSuccess(){}
    
}

extension CategoryService: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let categories = try decoder.decode([Category].self, from: data)
            delegate?.didGetCategoriesSuccess(with: categories)
        } catch {
            print("error trying to convert data to JSON")
            print(error)
            // Handle error
        }
    }
    
    func didGetFailed(with error: BackendError) {
    }
    
    func didPostSuccess(with data: Data) {
        print("Category posted")
        delegate?.didPostCategoriesSuccess()
    }
    
    func didPostFailed(with error: BackendError) {
        print(error.localizedDescription)
    }
    
    func didPostFailed(with error: Data) {
    }
    
    
}
