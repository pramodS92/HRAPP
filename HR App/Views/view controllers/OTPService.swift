////
////Created by Aruni Amarasinghe
//
//import Foundation
////import Alamofire
//import SwiftyJSON
//
//enum OTPRouter {
//    
//    case generateOTP
//    case validateOTP
//    
//    var url:URL {
//        switch self {
//        case .generateOTP:
//            return URL(string: ServiceURL.Api.Path.triggerOTP)!
//        case .validateOTP:
//            return URL(string: ServiceURL.Api.Path.validateOTP)!
//        }
//    }
//    
//    var method:HTTPMethod{
//        switch self {
//        case .generateOTP:
//            return .post
//        case .validateOTP:
//            return .put
//        }
//    }
//}
//
//
//
//
//class OTPService{
//    
////    func generateOTP(nic:String,mobileNo:String,onResponse:onAPIResponse?){
////
////        let params:[String:Any] = [
////            "userid":nic,
////            "otpLength":6,
////            "mobile":mobileNo
////        ]
////
//////        NetworkManager.APIRequest(url: OTPRouter.generateOTP.url, method: OTPRouter.generateOTP.method, params: params, headers: ServiceURL.Api.Headers.headerString) { response in
//////            let jsonData:JSON = JSON(response as! NSDictionary)
//////            onResponse?(jsonData)
//////        }
////    }
////
////    func validateOTP(nic:String,otpReference:String,otp:String,onResponse:onAPIResponse?){
////        let params:[String:Any] = [
////            "userid":nic,
////            "transactionId":otpReference,
////            "otp":otp
////        ]
//////        NetworkManager.APIRequest(url: OTPRouter.validateOTP.url, method: OTPRouter.validateOTP.method, params: params, headers: ServiceURL.Api.Headers.headerString) { response in
//////
//////        let jsonData: JSON = JSON(response as! NSDictionary)
//////        print("Kasunka AB \(jsonData)")
//////
//////        onResponse?(jsonData)
//////        }
////    }
//    
//}
