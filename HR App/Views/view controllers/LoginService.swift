////
////
//// LoginService.swift
//// HttpsTest
////
////Created by Pramod Ranasinghe on 4/27/21
//// Copyright © 2021 CBC Tech Solutions. All rights reserved.
//
//
//import Foundation
//import Alamofire
//
//class LoginService{
//            private static var Manager: Alamofire.SessionManager = {
//          
//                 // Create the server trust policies
//                 let serverTrustPolicies: [String: ServerTrustPolicy] = [
//                     
//                      "devportal:8443": .disableEvaluation
//                 ]
//       
//                 // Create custom manager
//                 let configuration = URLSessionConfiguration.default
//                 configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//                 let manager = Alamofire.SessionManager(
//                      configuration: URLSessionConfiguration.default,
//                      serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
//                 )
//       
//                 return manager
//            }()
//       
//       
//       
//            /**
//             Calls the Login Web Service to authenticate the user
//             */
//            public func login(username:String, password: String){
//   
//   // Handle Authentication challenge
//       
//         let delegate: Alamofire.SessionDelegate = LoginService.Manager.delegate
//                delegate.sessionDidReceiveChallenge = { session, challenge -> <#Result#> in
//             var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
//             var credential: URLCredential?
//             if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
//                  disposition = URLSession.AuthChallengeDisposition.useCredential
//                  credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//             } else {
//                  if challenge.previousFailureCount > 0 {
//                       disposition = .cancelAuthenticationChallenge
//                  } else {
//                       credential = LoginService.Manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
//                       if credential != nil {
//                            disposition = .useCredential
//                       }
//                  }
//             }
//             return (disposition, credential)
//        }
//   
////Web service Request
//                 let parameters = [
//                      "username": "TEST",
//                      "password": "PASSWORD",
//                         ]
//                 let header: HTTPHeaders = ["Accept": "application/json"]
//                 LoginService.Manager.request("https://devportal:8443/rest/login", method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers :header).responseJSON { response in
//                      debugPrint(response)
//       
//                      if let json = response.result.value {
//                           print("JSON: \(json)")
//                      }
//                 }
//       
//       
//       
//            }
//       }
