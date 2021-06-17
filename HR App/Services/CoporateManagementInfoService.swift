//
//  CoporateManagementInfoService.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-17.
//

import Foundation
import Alamofire

class CoporateManagementInfoService {
    static let shared = CoporateManagementInfoService()
    private init() {}
}

enum CoporateManagementInfoServiceRouter {
    
    case getCoporateManagementNameList
    case getCoporateManagementById
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getCoporateManagementNameList:
            return NetworkConstants.path.getCoporateManagementNameList
        case .getCoporateManagementById:
            return NetworkConstants.path.getEmployeeDetailsById
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
        case .getCoporateManagementNameList:
            return true
        case .getCoporateManagementById:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .getCoporateManagementNameList:
            return true
        case .getCoporateManagementById:
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

extension CoporateManagementInfoService {
    
    func getCoporateManagementNameList(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = CoporateManagementInfoServiceRouter.getCoporateManagementNameList.asurlRequest(searchBy: searchBy)
        
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
    
    func getCoporateManagementById(employeeId: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = CoporateManagementInfoServiceRouter.getCoporateManagementById.asurlRequest(searchBy: employeeId)
        
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
