//
//  SpecialLocationInfoService.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-18.
//

import Foundation
import Alamofire

class SpecialLocationInfoService {
    static let shared = SpecialLocationInfoService()
    private init() {}
}

enum SpecialLocationInfoServiceRouter {
    
    case getSpecialLocationNameList
    case getSpecialLocationDetailsById
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getSpecialLocationNameList:
            return NetworkConstants.path.getSpecialLocationNameList
        case .getSpecialLocationDetailsById:
            return NetworkConstants.path.getSpecialLocationDetailsById
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
        case .getSpecialLocationNameList:
            return true
        case .getSpecialLocationDetailsById:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .getSpecialLocationNameList:
            return true
        case .getSpecialLocationDetailsById:
            return true
        }
    }
    
    var accessToken: String {
        let token: String = UserDefaults.standard.string(forKey: UserDefaultConstants.KeyConstants.AccessTokenKey) ?? ""
        return "Bearer " + token
    }
    
    func asurlRequest(searchBy: String) -> RequestInfo {
        let requestHeaders = RequestHeader(accessToken: accessToken)
        let requestInfo = RequestInfo(method: httpMethod, params: nil, headers: requestHeaders.headers, url: url + searchBy)
        return requestInfo
    }
    
}

extension SpecialLocationInfoService {
    
    func getSpecialLocationNameList(searchBy: String, completion:@escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = SpecialLocationInfoServiceRouter.getSpecialLocationNameList.asurlRequest(searchBy: searchBy)
        
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
    
    func getSpecialLocationDetailsById(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = SpecialLocationInfoServiceRouter.getSpecialLocationDetailsById.asurlRequest(searchBy: searchBy)
        
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
