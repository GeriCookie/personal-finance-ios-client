//
//  HttpRequester.swift
//  PersonalFinance
//
//  Created by Cookie on 14.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class HttpRequester {
    var delegate : HttpRequesterDelegate?
    let cacheService = CacheService()
    
    func get(from url: String) {
        
    }
    
    func post(to urlString: String, with body: Data) {
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            delegate?.didPostFailed(with: error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if cacheService.authToken != "" {
            print(cacheService.authToken)
            request.addValue("Token \(cacheService.authToken)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = body
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                if let errMsg = error?.localizedDescription {
                    self.delegate?.didPostFailed(with: BackendError.generalError(reason: errMsg))
                }
                
                return
            }
            
            guard let httpResponse = response as! HTTPURLResponse? else {
                let err = BackendError.generalError(reason: "Invalid response")
                self.delegate?.didPostFailed(with: err)
                return
            }
            
            switch(httpResponse.statusCode) {
            case 200...399:
                guard let responseData = data else {
                    let error = BackendError.objectSerialization(reason: "No data in response")
                    self.delegate?.didGetFailed(with: error)
                    return
                }
                self.delegate?.didPostSuccess(with: responseData)
            default:
                guard let responseError = data else {
                    let error = BackendError.objectSerialization(reason: "Error cannot be parsed")
                    self.delegate?.didPostFailed(with: error)
                    return
                }
                print(responseError)
                self.delegate?.didPostFailed(with: responseError)
            }
        }
        
        dataTask.resume()
    }
}

protocol HttpRequesterDelegate {
    func didGetSuccess(with data: Data)
    func didGetFailed(with error: BackendError)
    
    func didPostSuccess(with data: Data)
    func didPostFailed(with error: BackendError)
    func didPostFailed(with error: Data)
}
