//
//  ProductReferenceGuideModel.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-08-05.
//

import Foundation

struct ProductReferenceGuideModel: Codable {
    let user: User?
    let status: Int?
    let data: [ProductReferenceGuideData]?
    let welcomeDescription: String?

    enum CodingKeys: String, CodingKey {
        case user, status, data
        case welcomeDescription = "description"
    }
}

struct ProductReferenceGuideData: Codable {
    
}
