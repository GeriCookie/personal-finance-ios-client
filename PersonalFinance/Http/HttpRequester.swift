//
//  HttpRequester.swift
//  PersonalFinance
//
//  Created by Cookie on 14.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

class HttpRequester {
    var delegate : HttpRequesterDelegate?
    let cacheService = CacheService()
    
    func get(from url: String) {
        makeRequest(to: url, with: .get, andBody: nil)
    }
    func post(to url: String, with body: Data) {
        makeRequest(to: url, with: .post, andBody: body)
    }
    
    func makeRequest(to urlString: String, with httpMethod: HttpMethod, andBody body: Data? ) {
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            handleError(forHttpMethod: httpMethod, with: error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if cacheService.authToken != "" {
            print(cacheService.authToken)
            request.addValue("Token \(cacheService.authToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                if let errMsg = error?.localizedDescription {
                    self.handleError(forHttpMethod: httpMethod, with: BackendError.generalError(reason: errMsg))
                }
                
                return
            }
            
            guard let httpResponse = response as! HTTPURLResponse? else {
                let err = BackendError.generalError(reason: "Invalid response")
                self.handleError(forHttpMethod: httpMethod, with: err)
                return
            }
            
            switch(httpResponse.statusCode) {
            case 200...399:
                guard let responseData = data else {
                    let error = BackendError.objectSerialization(reason: "No data in response")
                    self.handleError(forHttpMethod: httpMethod, with: error)
                    return
                }
                self.handleSuccess(forHttpMethod: httpMethod, with: responseData)
            default:
                guard let responseError = data else {
                    let error = BackendError.objectSerialization(reason: "Error cannot be parsed")
                    self.handleError(forHttpMethod: httpMethod, with: error)
                    return
                }
                print("Response error: \(responseError)")
                self.handleError(forHttpMethod: httpMethod, with: BackendError.generalError(reason: (error?.localizedDescription)!))
            }
        }
        
        dataTask.resume()
    }
    
    func handleError(forHttpMethod httpMethod: HttpMethod, with error: BackendError) {
        switch httpMethod {
        case .get:
            delegate?.didGetFailed(with: error)
        case .post:
            delegate?.didPostFailed(with: error)
        }
    }
    
    func handleSuccess(forHttpMethod httpMethod: HttpMethod, with data: Data) {
        switch httpMethod {
        case .get:
            delegate?.didGetSuccess(with: data)
        case .post:
            delegate?.didPostSuccess(with: data)
        }
    }
}

protocol HttpRequesterDelegate {
    func didGetSuccess(with data: Data)
    func didGetFailed(with error: BackendError)
    
    func didPostSuccess(with data: Data)
    func didPostFailed(with error: BackendError)
    func didPostFailed(with error: Data)
}
