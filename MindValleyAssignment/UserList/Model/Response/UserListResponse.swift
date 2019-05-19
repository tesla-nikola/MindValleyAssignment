//
//  UserListResponse.swift
//  MindValleyAssignment
//
//  Created by Soham Ray on 14/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

typealias UserListReponse = [UserListReponseElement]

private struct DummyCodable: Codable {}

struct Users: Codable
{
    var userList: [UserListReponseElement]
    
    init(from decoder: Decoder) throws {
        var users = [UserListReponseElement]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let route = try? container.decode(UserListReponseElement.self) {
                users.append(route)
            } else {
                _ = try? container.decode(DummyCodable.self) // <-- TRICK
            }
        }
        self.userList = users
    }
}

struct UserListReponseElement: Codable {
    let id: String?
    let createdAt: String?
    let width: Int?
    let height: Int?
    let color: String?
    let likes: Int?
    let likedByUser: Bool?
    let user: User?
    let urls: Urls?
    let categories: [Category]?
    let links: UserListReponseLinks?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case color
        case likes
        case likedByUser = "liked_by_user"
        case user
        case urls,categories, links
    }
}

struct Category: Codable {
    let id: Int?
    let title: String?
    let photoCount: Int?
    let links: CategoryLinks?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case photoCount = "photo_count"
        case links
    }
}

struct CategoryLinks: Codable {
    let linksSelf, photos: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case photos
    }
}

enum Title: String, Codable {
    case buildings = "Buildings"
    case nature = "Nature"
    case objects = "Objects"
    case people = "People"
}

struct UserListReponseLinks: Codable {
    let linksSelf: String?
    let html, download: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
    }
}

struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb: String?
}

struct User: Codable {
    let id, username, name: String?
    let profileImage: ProfileImage?
    let links: UserLinks?
    
    enum CodingKeys: String, CodingKey {
        case id, username, name
        case profileImage = "profile_image"
        case links
    }
}

struct UserLinks: Codable {
    let linksSelf: String?
    let html: String?
    let photos, likes: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes
    }
}

struct ProfileImage: Codable {
    let small, medium, large: String?
}

