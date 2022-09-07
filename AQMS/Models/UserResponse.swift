//
//  LoginModel.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/1/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome <- map["try? newJSONDecoder().decode(UserResponseModel.self, from: jsonData)

import Foundation
import ObjectMapper

//// MARK: - UserResponseModel
class UserResponseModel: Mappable {
    var jwt: String?
    var user: User?
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.jwt <- map["jwt"]
        self.user <- map["user"]
    }

}

// MARK: - User
class User: Mappable {

    var blocked, confirmed: Bool?
    var createdAt, email: String?
    var id: Int?
    var name, provider: String?
    var role: Role?
    var updatedAt: String?
    var userProfile: UserProfile?
    var username: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.blocked <- map["blocked"]
        self.confirmed <- map["confirmed"]
        self.createdAt <- map["created_at"]
        self.email <- map["email"]
        self.id <- map["id"]
        self.name <- map["name"]
        self.provider <- map["provider"]
        self.role <- map["role"]
        self.updatedAt <- map["updated_at"]
        self.userProfile <- map["userProfile"]
        self.username <- map["username"]
    }

}

// MARK: - Role
class Role: Mappable {

    var roleDescription: String?
    var id: Int?
    var name, type: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.roleDescription <- map["description"]
        self.id <- map["id"]
        self.name <- map["name"]
        self.type <- map["type"]
    }

}

// MARK: - UserProfile
class UserProfile: Mappable {
    var address: String?
    var authPerson1, authPerson2: AuthPerson?
    var createUser, createdAt: String?
    var hatcheryID, id: Int?
    var name, notificationToken, phoneNumber, picture: String?
    var rejectReason, updateRequestDetails, updateRequestFlag: String?
    var updateUser, isDelete, isHatcheryIncharge: Bool?
    var updatedAt: String?
    var user: Int?


    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.address <- map["address"]
        self.authPerson1 <- map["authPerson1"]
        self.authPerson2 <- map["authPerson2"]
        self.createUser <- map["createUser"]
        self.createdAt <- map["created_at"]
        self.hatcheryID <- map["hatcheryId"]
        self.id <- map["id"]
        self.isDelete <- map["isDelete"]
        self.isHatcheryIncharge <- map["isHatcheryIncharge"]
        self.name <- map["name"]
        self.notificationToken <- map["notificationToken"]
        self.phoneNumber <- map["phoneNumber"]
        self.picture <- map["picture"]
        self.rejectReason <- map["rejectReason"]
        self.updateRequestDetails <- map["updateRequestDetails"]
        self.updateRequestFlag <- map["updateRequestFlag"]
        self.updateUser <- map["updateUser"]
        self.updatedAt <- map["updated_at"]
        self.user <- map["user"]
    }
}

// MARK: - AuthPerson
class AuthPerson: Mappable {
    var aadhaarNumber: String?
    var allowDisplayName, allowUtf8LocalPart: Int?
    var blacklistedChars, email: String?
    var hostBlacklist: [AnyObject]?
    var ignoreMaxLength, ignoreWhitespace: Int?
    var name, phoneNumber, picture: String?
    var requireDisplayName, requireTLD: Int?
    var updatedAt: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.aadhaarNumber <- map["aadhaarNumber"]
        self.allowDisplayName <- map["allow_display_name"]
        self.allowUtf8LocalPart <- map["allow_utf8_local_part"]
        self.blacklistedChars <- map["blacklisted_chars"]
        self.email <- map["email"]
        self.hostBlacklist <- map["host_blacklist"]
        self.ignoreMaxLength <- map["ignore_max_length"]
        self.ignoreWhitespace <- map["ignore_whitespace"]
        self.name <- map["name"]
        self.phoneNumber <- map["phoneNumber"]
        self.picture <- map["picture"]
        self.requireDisplayName <- map["require_display_name"]
        self.requireTLD <- map["require_tld"]
        self.updatedAt <- map["updated_at"]
    }
}

