//
//
// AccessTokenResponseModel.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/15/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation

struct AccessTokenResponseModel: Codable {
    let accessToken: String
    let expiresIn, refreshExpiresIn: Int
    let refreshToken, tokenType, idToken: String
    let notBeforePolicy: Int
    let sessionState, scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case idToken = "id_token"
        case notBeforePolicy = "not-before-policy"
        case sessionState = "session_state"
        case scope
    }
}
