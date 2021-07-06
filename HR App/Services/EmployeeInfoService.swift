//
//
// EmployeeInfoService.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/28/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire


class EmployeeInfoService {
    static let shared = EmployeeInfoService()
    private init() {}
}

enum EmployeeInfoServiceRouter {
    
    case getEmployeeByName
    case getEmployeeDetailsById
    case getEmployeeSalaryDetailsById
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getEmployeeByName:
            return NetworkConstants.path.getEmployeeByName
        case .getEmployeeDetailsById:
            return NetworkConstants.path.getEmployeeDetailsById
        case .getEmployeeSalaryDetailsById:
            return NetworkConstants.path.getEmployeeSalaryDetailsById
        }
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.get
    }
    
    var url: String {
        return "http://" + baseURL + path
    }
    
    var acceptType: Bool {
        return true
    }
    
    var contentType: Bool {
        return true
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

extension EmployeeInfoService {
    
    func getEmployeeByName(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = EmployeeInfoServiceRouter.getEmployeeByName.asurlRequest(searchBy: searchBy)
        
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
    
    func getEmployeeDetailsById(employeeId: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = EmployeeInfoServiceRouter.getEmployeeDetailsById.asurlRequest(searchBy: employeeId)
        
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
    
    func getEmployeeSalaryDetailsById(employeeId: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = EmployeeInfoServiceRouter.getEmployeeSalaryDetailsById.asurlRequest(searchBy: employeeId)
        
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
