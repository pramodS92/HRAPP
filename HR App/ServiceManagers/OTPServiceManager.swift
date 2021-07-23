//
//  OTPServiceManager.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-18.
//

import Foundation
import Alamofire

protocol OnSuccessOTP {
    func onSuccessGenerateOTP(phoneNo: String, status: String, otp: String)
    func onSuccessValidateOTP(status: String)
    func OnFailier()
}

class OTPServiceManager {
    
    var delegate: OnSuccessOTP?
    
    public func generateOTP(userId: String, transactionId: String, _ callback: OnSuccessOTP) {
        self.delegate = callback
        
        OTPService.shared.generateOTP(userId: userId, transactionId: transactionId) { (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(GenerateOTPModel.self, from: response! as! Data) {
                    print("hello123", responseBody)
                    self.delegate?.onSuccessGenerateOTP(phoneNo: responseBody.phoneNo, status: responseBody.status, otp: responseBody.otp)
                }
            } else {
                self.delegate?.OnFailier()
                return
            }
        }
        
    }
    
    public func validateOTP(userId: String, transactionId: String, otp: String, _ callback: OnSuccessOTP) {
        self.delegate = callback
        
        OTPService.shared.validateOTP(userId: userId, transactionId: transactionId, otp: otp) { (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(ValidateOTPModel.self, from: response! as! Data) {
                    print(responseBody)
                    self.delegate?.onSuccessValidateOTP(status: responseBody.status)
                }
            } else {
                self.delegate?.OnFailier()
                return
            }
        }
    }
    
}
