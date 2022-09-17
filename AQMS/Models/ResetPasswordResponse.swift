//
//  ResetPasswordResponse.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/15/22.
//

import Foundation
import ObjectMapper

class ResetPasswordResponse: Mappable {
    var statusCode: Int?
    var error: String?
    var message: Message?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.statusCode <- map["statusCode"]
        self.error <- map["error"]
        self.message <- map["message"]
    }
}

// MARK: - Message
class Message: Mappable {
    var isValid: Bool?
    var password, passwordConfirmation: Password?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.isValid <- map["isValid"]
        self.password <- map["password"]
        self.passwordConfirmation <- map["passwordConfirmation"]
    }
}

// MARK: - Password
class Password: Mappable {
    var isInvalid: Bool?
    var message: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.isInvalid <- map["isInvalid"]
        self.message <- map["message"]
    }
}
