//
//
// BranchDetailService.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/21/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire


class BranchInfoService {
    static let shared = BranchInfoService()
    private init() {}
}

enum BranchInfoServiceRouter {
    
    case getBranchNameList
    case getBranchDetailsByName
    case getBranchDetailsById
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getBranchNameList:
            return NetworkConstants.path.getBranchNameList
        case .getBranchDetailsByName:
            return NetworkConstants.path.getBranchDetailsByName
        case .getBranchDetailsById:
            return NetworkConstants.path.getBranchDetailsById
        }
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.get
    }
    
    var url: String {
        return "http://" + baseURL + path
    }
    
    var acceptType: Bool {
        switch self {
        case .getBranchNameList:
            return true
        case .getBranchDetailsByName:
            return true
        case .getBranchDetailsById:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .getBranchNameList:
            return true
        case .getBranchDetailsByName:
            return true
        case .getBranchDetailsById:
            return true
        }
    }
    
    var accessToken: String {
        let token:String = UserDefaults.standard.string(forKey: UserDefaultConstants.KeyConstants.AccessTokenKey) ?? " "
        return "Bearer " + token
    }
    
    func asurlRequest(searchBy: String) -> RequestInfo {
        let requestHeaders = RequestHeader(accessToken: accessToken)
        let requestInfo = RequestInfo(method: httpMethod,params: nil,headers: requestHeaders.headers,url: url + searchBy)
        return requestInfo
    }
}

extension BranchInfoService {
    
    func getBranchNameList(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = BranchInfoServiceRouter.getBranchNameList.asurlRequest(searchBy: searchBy)
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
    
    func getBranchDetailsByName(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = BranchInfoServiceRouter.getBranchDetailsByName.asurlRequest(searchBy: searchBy)
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
    
    func getBranchDetailsById(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = BranchInfoServiceRouter.getBranchDetailsById.asurlRequest(searchBy: searchBy)
        
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
