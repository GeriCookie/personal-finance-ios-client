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
    
    func get(from url: String) {
        
    }
    
    func post(to urlString: String, with body: Data) {
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            print(error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil  else {
                //Handle error better
                print(error as Any)
                return
            }
            
            guard let httpResponse = response as! HTTPURLResponse? else {
                print("Error in parsing response")
                return
            }
            
            switch(httpResponse.statusCode){
            case 200...299:
                print("OK!")
            default:
                print("ERROR")
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                var error = BackendError.objectSerialization(reason: "No data in response")
                return
            }
            self.delegate?.didGetSuccess(with: responseData)
        }
        
        dataTask.resume()
    }
}

protocol HttpRequesterDelegate {
    func didGetSuccess(with data: Data)
    func didGetFailed(with error: BackendError)
}
