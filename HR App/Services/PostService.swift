//
//  PostService.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-08-05.
//

import Foundation
import Alamofire

class PostInfoService {
    static let shared = PostInfoService()
    private init() {}
}

enum PostInfoServiceRouter {
    
    case getPost
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .getPost:
            return NetworkConstants.path.getPost
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
        let requestInfo = RequestInfo(method: httpMethod, params: nil, headers: requestHeaders.headers, url: url + searchBy)
        return requestInfo
    }
    
}

extension PostInfoService {
    
    func getPost(searchBy: String, completion: @escaping(Any?, Error?, Int?) -> ()) {
        let requestInfo = PostInfoServiceRouter.getPost.asurlRequest(searchBy: searchBy)
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
