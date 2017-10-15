//
//  UserService.swift
//  PersonalFinance
//
//  Created by Cookie on 14.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation

class UserService {
    var delegate: UserServiceDelegate?
    var httpRequester: HttpRequester?
    var cacheService: CacheService?
    
    init() {
        httpRequester = HttpRequester()
        httpRequester?.delegate = self
        
        cacheService = CacheService()
    }
    
    func registerUser(with username: String, email: String, password: String) {
        let user = User(withUsername: username, email: email, andPassword: password)
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(user)
        } catch {
            print(error)
        }
        cacheService?.username = username
        
        httpRequester?.post(to: AUTH_URL, with: body)
    }
    
    func loginUser(with username: String, password: String) {
        cacheService?.username = username
    }
}

protocol UserServiceDelegate {
    func didRegisterSuccess()
}

extension UserService: HttpRequesterDelegate {
    func didGetSuccess(with data: Data) {
        print(data)
        let decoder = JSONDecoder()
        do {
            let authToken = try decoder.decode(AuthToken.self, from: data)
            guard let authTokenKey = authToken.key else {
                print("Error unwrapping auth token")
                return
            }
            cacheService?.authToken =  authTokenKey
            delegate?.didRegisterSuccess()
        } catch {
            print("Error trying to convert data to JSON")
            print(error)
        }
        
        
    }
    
    func didGetFailed(with error: BackendError) {
        
    }
}
