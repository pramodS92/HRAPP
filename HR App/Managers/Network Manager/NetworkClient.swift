//
//
// NetworkClient.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/7/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire
import SwiftyJSON

enum Result<T> {
    case Success(Any?, Int)
    case Invalid(Any?, Int)
    case Failure(Error?, Int)
}

class NetworkClient {
    
    static let shared = NetworkClient()
    
    // DO NOT USE THIS IN PRODUCTION
    // Bypass the Authentication
    private var manager: Alamofire.Session =
        {
            let serverTrustPolicies: [String: ServerTrustEvaluating] = ["122.255.63.41": DisabledTrustEvaluator()]
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
            let manager = Alamofire.Session(
                configuration: URLSessionConfiguration.default,
                serverTrustManager: ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: serverTrustPolicies)
            )
            return manager
        }()
    
    
    func requestData(requestInfo: RequestInfo,isSecure: Bool, completion: @escaping (Result<String>) -> Void) {
        // Check internet connection availability
        
        let networkSession: Alamofire.Session = isSecure ? manager : .default
        networkSession.request(requestInfo.url, method: requestInfo.method, parameters: requestInfo.params, encoding: URLEncoding.default, headers: requestInfo.headers).responseJSON { response in
            
            print("*** NetworkClient :   ",response)
            
            let statusCode = response.response?.statusCode ?? 0
            switch response.result {
            case .success:
                
                if let data = response.data {
                    switch statusCode {
                    case 200...299:
                        completion(.Success(data, statusCode))
                    case 401...404:
                        completion(.Invalid(response, statusCode))
                    default:
                        let json = JSON(data)
                        let message = json["Error"].stringValue
                        completion(.Invalid(message, statusCode))
                    }
                }
            case .failure(let error):
                
                completion(.Failure(error, statusCode))
            }
        }
    }
    
}
