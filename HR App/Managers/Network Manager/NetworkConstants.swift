//
//
// NetworkConstants.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/7/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire


// add all environments here
enum APIEnvironment {
    case development
    case production
}

struct NetworkConstants {
    
    static let environment: APIEnvironment = .development
    
    static var baseURL: String {
        switch environment {
        case .development:
            return "122.255.63.41"
        case .production:
            return ""
        }
    }
    

    struct path  {
        static var getAccessToken:String{
            return "/auth/realms/Combank/protocol/openid-connect/token"
        }
        static var genarateOTP: String{
            return ""
        }
        static var getDefaultUserDetails: String{
            return "/hrm/employee/"
        }
        static var getBranchNameList: String{
            return "/hrm/branch/list/"
        }
        static var getBranchDetailsByName: String{
            return "/hrm/branch/list/details/"
        }
        static var getBranchDetailsById: String{
            return "/hrm/branch/"
        }
        static var getDepartmentNameList: String{
            return "/hrm/department/list/"
        }
        static var getDepartmentDetailsById: String{
            return "/hrm/department/id/"
        }
        static var getEmployeeByName: String{
            return "/hrm/employee/name/"
        }
        static var getEmployeeDetailsById: String{
            return "/hrm/employee/id/"
        }
        static var getRegionalOfficeNameList: String {
            return "/hrm/regionaloffice/list/"
        }
        static var getRegionalOfficeDetailsById: String {
            return "/hrm/regionaloffice/id/"
        }
        static var getExchangeOfficeNameList: String {
            return "/hrm/exchangeOffice/list/"
        }
        static var getSerendibFinanceNameList: String {
            return "/hrm/department/id/136"
        }
        static var getCoporateManagementNameList: String {
            return "/hrm/corporate"
        }
        static var getSpecialLocationNameList: String {
            return "/hrm/specialLocation/list/"
        }
        static var getSpecialLocationDetailsById: String {
            return "/hrm/specialLocation/id/"
        }
        
    }
}

struct RequestInfo {
    var method: HTTPMethod
    var params: [String: Any]? = nil
    var headers: HTTPHeaders
    var url: String
    
    init(method: HTTPMethod, params: [String: Any]?, headers: HTTPHeaders, url: String) {
        self.method = method
        self.params = params
        self.headers = headers
        self.url = url
    }
}

struct RequestHeader {
    var accessToken:String
    var contentType = "application/x-www-form-urlencoded"
    var acceptType = "*/*"
    var cacheControl = "no-cache"
    var headers: HTTPHeaders {
        get {
            return ["Authorization": accessToken,
                    "Accept": acceptType,
                    "Cache-Control": cacheControl,
                    "Accept-Encoding": "gzip, deflate, br"] as HTTPHeaders
        }
    }
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}

