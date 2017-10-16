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
        let user = UserRegister(withUsername: username, email: email, andPassword: password)
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(user)
        } catch {
            print(error)
        }
        cacheService?.username = username
        
        httpRequester?.post(to: REGISTER_URL, with: body)
    }
    
    func loginUser(with username: String, password: String) {
        let user = UserLogin(withUsername: username, andPassword: password)
        var body = Data()
        let encoder = JSONEncoder()
        do {
            body = try encoder.encode(user)
        } catch {
            print(error)
        }
        cacheService?.username = username
        
        httpRequester?.post(to: LOGIN_URL, with: body)
    }
}

protocol UserServiceDelegate {
    func didRegisterSuccess()
    func didRegisterFailed(with error: String)
    func didRegisterFailed(with dict: [String: String])
}

extension UserServiceDelegate {
    func didRegisterSuccess() {}
    func didRegisterFailed(with error: String) {}
    func didRegisterFailed(with dict: [String: String]) {}
}

extension UserService: HttpRequesterDelegate {
    func didPostSuccess(with data: Data) {
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(dict)
        } catch {
            
        }
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
    
    func didPostFailed(with error: BackendError) {
        delegate?.didRegisterFailed(with: error.localizedDescription)
    }
    
    func didPostFailed(with error: Data) {
        let originalDict = try? JSONSerialization.jsonObject(with: error, options: .allowFragments)
        if let originalDict = originalDict as? Dictionary<String, Any> {
            var dict = [String: String]()
            for (key, val) in originalDict {
                dict[key] = val as? String
            }
            
            self.delegate?.didRegisterFailed(with: dict)
            return
        }
        
        delegate?.didRegisterFailed(with: "Unknown error")
    }
    
    func didGetSuccess(with data: Data) {
    }
    
    func didGetFailed(with error: BackendError) {
        
    }
}
