//
//
// DepartmentInfoService.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/24/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire

class DepartmentInfoService {
    static let shared = DepartmentInfoService()
    private init() {}
}

enum DepartmentInfoServiceRouter {
    
    case getDepartmentNameList
    case getDepartmentDetailsById
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getDepartmentNameList:
            return NetworkConstants.path.getDepartmentNameList
        case .getDepartmentDetailsById:
            return NetworkConstants.path.getDepartmentDetailsById
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
        case .getDepartmentNameList:
            return true
        case .getDepartmentDetailsById:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .getDepartmentNameList:
            return true
        case .getDepartmentDetailsById:
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

extension DepartmentInfoService {
    
    func getDepartmentNameList(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = DepartmentInfoServiceRouter.getDepartmentNameList.asurlRequest(searchBy: searchBy)
        
        NetworkClient.shared.requestData(requestInfo: requestInfo, isSecure: false) { (response) in
            switch response {
            case .Success(let response, let statusCode):
                completion(response, nil, statusCode)
            case .Invalid(let response, let statusCode):
                completion(nil, nil, statusCode)
            case .Failure(let error, let statusCode):
                completion(nil, error, statusCode)
            }
        }
    }
    
    func getDepartmentDetailsById(departmentId: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = DepartmentInfoServiceRouter.getDepartmentDetailsById.asurlRequest(searchBy: departmentId)
        
        NetworkClient.shared.requestData(requestInfo: requestInfo, isSecure: false) { (response) in
            switch response {
            case .Success(let response, let statusCode):
                completion(response, nil, statusCode)
            case .Invalid(let response, let statusCode):
                completion(nil, nil, statusCode)
            case .Failure(let error, let statusCode):
                completion(nil, error, statusCode)
            }
        }
    }
}
