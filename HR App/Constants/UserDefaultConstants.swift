//
//
// UserDefaultConstants.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/16/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation

struct UserDefaultConstants {
    
    struct KeyConstants {
        static let InitialLogin = "InitialLogin"
        static let isTokeSaved = "isTokeSaved"
        static let AccessTokenKey = "AccessTokenKey"
        static let RefreshTokenKey = "RefreshTokenKey"
        static let UserName = "UserName"
    }
    
    struct BiometricsPinConstants {
        static let LocalPin = "LocalPin"
        static let isLocalPinEnabled = "isLocalPinEnabled"
        static let isBiometricsEnabled = "isBiometricsEnabled"
        static let isScreenActive = "isScreenActive"
        static let isOtpEntered = "isOtpEntered"
    }
}
