//
//
// AccessTokenServiceManager.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/30/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire

protocol OnSuccessAccessToken {
    func OnSuccessAccessToken()
    func OnFailierAccessToken()
}

class AccessTokenServiceManager {
    
    let uiUtils = UiUtils()
    
    var delegate: OnSuccessAccessToken?
    
    public func getAccessToken(userName: String,password: String, _ callback: OnSuccessAccessToken) {
        self.delegate = callback
        
        AccessTokenService.shared.getAccessToken(username: userName, password: password) {
            (response, error, statusCode) in
            if error != nil {
            } else {
                if let responseData: Data = response as? Data {
                    if let response = try? JSONDecoder().decode(AccessTokenResponseModel.self, from: response! as! Data){
                        
                        UserDefaults.standard.set(response.accessToken, forKey: UserDefaultConstants.KeyConstants.AccessTokenKey)
                        UserDefaults.standard.set(response.refreshToken, forKey: UserDefaultConstants.KeyConstants.RefreshTokenKey)
                        
                        UserDefaults.standard.set(true, forKey: UserDefaultConstants.KeyConstants.InitialLogin)
                        UserDefaults.standard.synchronize()
                        self.delegate?.OnSuccessAccessToken()
                    }
                }else{
                    self.delegate?.OnFailierAccessToken()
                }
            }
        }
        
    }
    
}
