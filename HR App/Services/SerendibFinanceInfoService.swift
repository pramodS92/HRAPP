//
//  SerendibFinanceInfoService.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-17.
//

import Foundation
import Alamofire

class SerendibFinanceInfoService {
    
    static let shared = SerendibFinanceInfoService()
    private init() {}
}

enum SerendibFinanceInfoServiceRouter {
    
    case getSerendibFinanceNameList
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getSerendibFinanceNameList:
            return NetworkConstants.path.getSerendibFinanceNameList
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
        case .getSerendibFinanceNameList:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .getSerendibFinanceNameList:
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

extension SerendibFinanceInfoService {
    
    func getSerendibFinanceNameList(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        
        let requestInfo = SerendibFinanceInfoServiceRouter.getSerendibFinanceNameList.asurlRequest(searchBy: searchBy)
        
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
