//
//  OTPModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-17.
//

import Foundation

struct GenerateOTPModel: Codable {
    let phoneNo, status, otp: String
}

struct ValidateOTPModel: Codable {
    let status: String
}

