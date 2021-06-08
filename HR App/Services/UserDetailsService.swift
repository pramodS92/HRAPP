//
//
// UserDetailsService.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/17/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire


class UserDetailsService {
    static let shared = UserDetailsService()
    private init() {}
}

enum UserDetailsServiceRouter {
    
    case getUserDetails
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getUserDetails:
            return NetworkConstants.path.getDefaultUserDetails
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUserDetails:
            return HTTPMethod.get
        }
    }
    
    var url: String {
        return "http://" + baseURL + path
    }
    
    var acceptType: Bool {
        switch self {
        case .getUserDetails:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .getUserDetails:
            return true
        }
    }
    
    var accessToken: String {
        let token:String = UserDefaults.standard.string(forKey: UserDefaultConstants.KeyConstants.AccessTokenKey) ?? " "
        return "Bearer " + token
    }
    
    func asurlRequest() -> RequestInfo {
    
        let requestHeaders = RequestHeader(accessToken: accessToken)
        let requestInfo = RequestInfo(method: httpMethod,
                                                 params: nil,
                                                 headers: requestHeaders.headers,
                                                 url: url)
        switch self {
        case .getUserDetails:
            return requestInfo
        }
    }
    
}


extension UserDetailsService {
    
    func getUserDetails(completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = UserDetailsServiceRouter.getUserDetails.asurlRequest()
        
        NetworkClient.shared.requestData(requestInfo: requestInfo, isSecure: false) { (response) in
            switch response {
            case .Success(let response, let statusCode):
                completion(response, nil, statusCode)
            case .Invalid(let response, let statusCode):
                completion(response, nil, statusCode)
            case .Failure(let error, let statusCode):
                completion(nil, error, statusCode)
            }
        }
    }
}




