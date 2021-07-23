//
//
// AccessTokenService.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/7/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire


class AccessTokenService {
    static let shared = AccessTokenService()
    private init() {}
}


enum AccessTokenServiceRouter {
    
    case getAccessToken
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getAccessToken:
            return NetworkConstants.path.getAccessToken
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAccessToken:
            return HTTPMethod.post
        }
    }
    
    var url: String {
        return "https://" + baseURL + path
    }
    
    var acceptType: Bool {
        switch self {
        case .getAccessToken:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .getAccessToken:
            return true
        }
    }
    
    
    func asurlRequest(userName: String, password: String) -> RequestInfo {
    
        let requestBody = AccessTokenRequestBody(userName: userName,password: password)
        let requestHeaders = AccessTokenRequestHeader()
        let requestInfo = RequestInfo(method: httpMethod,
                                      params: requestBody.payload,
                                                 headers: requestHeaders.headers,
                                                 url: url)
        
        switch self {
        case .getAccessToken:
            return requestInfo
        }
    }
}

extension AccessTokenService {
    
    func getAccessToken(username: String,password: String,completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = AccessTokenServiceRouter.getAccessToken.asurlRequest(userName: username, password: password)
        
        NetworkClient.shared.requestData(requestInfo: requestInfo, isSecure: true) { (response) in
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


struct AccessTokenRequestBody {
    var grantType = "password"
    var userName: String
    var password: String
    var scope = "openid profile"
    var clientId = "hr-mobile"
    var clientSecret = "e6147f16-7d9a-4a10-a9c6-ec223e2621a3"
    var payload:[String:Any] {
        get {
            return ["grant_type":grantType,
                    "username": userName,
                    "password": password,
                    "scope": scope,
                    "client_id": clientId,
                    "client_secret": clientSecret ] as [String : Any]
        }
    }
    
    init(userName: String,password: String) {
        self.userName = userName
        self.password = password
    }
}

struct AccessTokenRequestHeader {
    var contentType = "application/x-www-form-urlencoded"
    var acceptType = "*/*"
    var cacheControl = "no-cache"
    var acceptEncoding = "gzip, deflate, br"
    var connection = "keep-alive"
    var contentLength = "149"
    var headers: HTTPHeaders {
        get {
            return ["Content-Type": contentType,
                    "Accept": acceptType,
                    "Cache-Control": cacheControl,
                    "Accept-Encoding": acceptEncoding,
                    "Connection": connection,
                    "Content-Length": contentLength ] as HTTPHeaders
        }
    }
}
