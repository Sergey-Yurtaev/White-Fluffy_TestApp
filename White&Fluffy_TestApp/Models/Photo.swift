//
//  Photo.swift
//  White&Fluffy_TestApp
//
//  Created by  Sergey Yurtaev on 06.09.2022.
//

import Foundation

// MARK: - RandomResult
struct Photo: Decodable {
    let idPhoto: String?
    let createdAt: String?
    let urls: Urls?
    let user: User?
    let location: Location?
    let downloads: Int?
    
    enum CodingKeys: String, CodingKey {
        case idPhoto = "id"
        case createdAt = "created_at"
        case urls = "urls"
        case user = "user"
        case location = "location"
        case downloads = "downloads"
    }
}

// MARK: - Location
struct Location: Decodable {
    let name: String?
    let city: String?
    let country: String?
}

// MARK: - Urls
struct Urls: Codable {
    let full: String?
    let regular: String?
    let small: String?
}

// MARK: - User
struct User: Codable {
    let name: String?
}
