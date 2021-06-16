//
//  RegionalOfficeInfoService.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-16.
//

import Foundation

import Foundation
import Alamofire

class RegionalOfficeInfoService {
    static let shared = RegionalOfficeInfoService()
    private init() {}
}

enum RegionalOfficeInfoServiceRouter {
    
    case getRegionalOfficeNameList
    case getRegionalOfficeDetailsById
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getRegionalOfficeNameList:
            return NetworkConstants.path.getRegionalOfficeNameList
        case .getRegionalOfficeDetailsById:
            return NetworkConstants.path.getRegionalOfficeDetailsById
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRegionalOfficeNameList:
            return HTTPMethod.get
        case .getRegionalOfficeDetailsById:
            return HTTPMethod.get
        }
    }
    
    var url: String {
        return "http://" + baseURL + path
    }
    
    var acceptType: Bool {
        switch self {
        case .getRegionalOfficeNameList:
            return true
        case .getRegionalOfficeDetailsById:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .getRegionalOfficeNameList:
            return true
        case .getRegionalOfficeDetailsById:
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

extension RegionalOfficeInfoService {
    
    func getRegionalOfficeNameList(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = RegionalOfficeInfoServiceRouter.getRegionalOfficeNameList.asurlRequest(searchBy: searchBy)
        
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
    
    func getRegionalOfficeDetailsById(regionalOfficeId: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = RegionalOfficeInfoServiceRouter.getRegionalOfficeDetailsById.asurlRequest(searchBy: regionalOfficeId)
        
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
