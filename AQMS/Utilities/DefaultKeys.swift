//
//  DefaultKeys.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/4/22.
//

import Foundation
import SwiftyUserDefaults

    
extension DefaultsKeys {
    var fcmToken : DefaultsKey<String>{ return .init("fcmToken", defaultValue: "") }
    var userResponse : DefaultsKey<String>{ return .init("userResponse", defaultValue: "") }
    var accessToken : DefaultsKey<String>{ return .init("accessToken", defaultValue: "") }
    var hatcheryIds : DefaultsKey<Int>{ return .init("hatcheryIds", defaultValue: -1) }
    var authOnePersion : DefaultsKey<String>{ return .init("authOnePersion", defaultValue: "") }
    var authTwoPersion : DefaultsKey<String>{ return .init("authTwoPersion", defaultValue: "") }
    var userImage : DefaultsKey<String>{ return .init("userImage", defaultValue: "") }
    var userName : DefaultsKey<String>{ return .init("userName", defaultValue: "") }
    var name : DefaultsKey<String>{ return .init("name", defaultValue: "") }
}
