//
//  ExchangeOfficeInfoService.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-16.
//

import Foundation
import Alamofire

class ExchangeOfficeInfoService {
    static let shared = ExchangeOfficeInfoService()
    private init() {}
}

enum ExchangeOfficeInfoServiceRouter {
    
    case getExchangeOfficeNameList
    
    var baseUrl: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getExchangeOfficeNameList:
            return NetworkConstants.path.getExchangeOfficeNameList
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getExchangeOfficeNameList:
            return HTTPMethod.get
        }
    }
    
    var url: String {
        return "http://" + baseUrl + path
    }
    
    var acceptType: Bool {
        switch self {
        case .getExchangeOfficeNameList:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .getExchangeOfficeNameList:
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

extension ExchangeOfficeInfoService {
    
    func getExchangeOfficeNameList(searchBy: String, completion:@escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = ExchangeOfficeInfoServiceRouter.getExchangeOfficeNameList.asurlRequest(searchBy: searchBy)
        
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
