//
//  OTPService.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-17.
//

import Foundation
import Alamofire

class OTPService {
    static let shared = OTPService()
    private init() {}
}

enum OTPServiceRouter {
    
    case generateOTP
    case validateOTP
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .generateOTP:
            return NetworkConstants.path.genarateOTP
        case .validateOTP:
            return NetworkConstants.path.validateOTP
        }
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.post
    }
    
    var url: String {
        return "http://" + baseURL + path
    }
    
    var acceptType: Bool {
        switch self {
        case .generateOTP:
            return true
        case .validateOTP:
            return true
        }
    }
    
    var contentType: Bool {
        switch self {
        case .generateOTP:
            return true
        case .validateOTP:
            return true
        }
    }
    
    var accessToken: String {
        let token: String = UserDefaults.standard.string(forKey: UserDefaultConstants.KeyConstants.AccessTokenKey) ?? " "
        return "Bearer " + token
    }
    
    func asurlRequest(userId: String, transactionId: String, otp: String) -> OTPRequestInfo {
        let requestHeaders = OTPRequestHeader(accessToken: accessToken)
        
        let parameters: [String: Any] = [
            "userid": userId,
            "transactionId": transactionId
        ]
        
        let validateOtpParameters: [String: Any] = [
            "userid": userId,
            "transactionId": transactionId,
            "otp": otp
        ]
        
        switch self {
        case .generateOTP:
            let requestBody = GenerateOTPRequestBody(userId: userId, transactionId: transactionId)
            let requestInfo = OTPRequestInfo(method: httpMethod, params: parameters, headers: requestHeaders.headers, url: url)
            return requestInfo
        case .validateOTP:
            let requestBody = ValidateOTPRequestBody(userId: userId, transactionId: transactionId, otp: otp)
            let requestInfo = OTPRequestInfo(method: httpMethod, params: validateOtpParameters, headers: requestHeaders.headers, url: url)
            return requestInfo
        }
        
    }
}

extension OTPService {
    
    func generateOTP(userId: String, transactionId: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        
        let requestInfo = OTPServiceRouter.generateOTP.asurlRequest(userId: userId, transactionId: transactionId, otp: "")
        
        NetworkClient.shared.requestOtp(requestInfo: requestInfo, isSecure: false) { (response) in
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
    
    func validateOTP(userId: String, transactionId: String, otp: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        
        let requestInfo = OTPServiceRouter.validateOTP.asurlRequest(userId: userId, transactionId: transactionId, otp: otp)
        
        NetworkClient.shared.requestOtp(requestInfo: requestInfo, isSecure: false) { (response) in
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

struct GenerateOTPRequestBody: Codable {
    let userid, transactionID: String

    enum CodingKeys: String, CodingKey {
        case userid
        case transactionID = "transactionId"
    }

    init(userId: String, transactionId: String) {
        self.userid = userId
        self.transactionID = transactionId
    }
}

class OTPRequestBody: NSObject {
    var userid: String = "HRMAPI"
    var transactionId: String = "123456789"
}

struct ValidateOTPRequestBody: Codable {
    let userid, transactionID, otp: String

    enum CodingKeys: String, CodingKey {
        case userid
        case transactionID = "transactionId"
        case otp
    }

    init(userId: String, transactionId: String, otp: String) {
        self.userid = userId
        self.transactionID = transactionId
        self.otp = otp
    }
}

struct OTPRequestHeader {
    
    var accessToken:String
    var contentType = "application/json"
    var acceptType = "*/*"
    var cacheControl = "no-cache"
    var acceptEncoding = "gzip, deflate, br"
    var connection = "keep-alive"
    var contentLength = "149"
    var headers: HTTPHeaders {
        get {
            return ["Authorization": accessToken,
                    "Content-Type": contentType,
                    "Accept": acceptType,
                    "Cache-Control": cacheControl,
                    "Accept-Encoding": acceptEncoding,
                    "Connection": connection,
                    "Content-Length": contentLength ] as HTTPHeaders
        }
    }
    init(accessToken: String) {
        self.accessToken = accessToken
    }
}

struct OTPRequestInfo {
    var method: HTTPMethod
    var params: Any? = nil
    var headers: HTTPHeaders
    var url: String

    init(method: HTTPMethod, params: Any?, headers: HTTPHeaders, url: String) {
        self.method = method
        self.params = params
        self.headers = headers
        self.url = url
    }
}
