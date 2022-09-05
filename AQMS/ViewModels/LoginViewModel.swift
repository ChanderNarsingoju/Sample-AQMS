//
//  LoginViewModel.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/4/22.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class LoginViewModel: BaseViewModel {
    
    func userLogin(username: String, password: String, onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        APIManager.instance.userLogin(username: username, password: password) { responce in
            print(responce)
            let respString = responce.toJSONString()
            Defaults.userResponse = respString ?? ""
            Defaults.accessToken = responce.jwt ?? ""
            Defaults.hatcheryIds = responce.user?.userProfile?.hatcheryID ?? -1
            Defaults.authOnePersion = responce.user?.userProfile?.authPerson1?.toJSONString() ?? ""
            Defaults.authTwoPersion = responce.user?.userProfile?.authPerson2?.toJSONString() ?? ""
            Defaults.userImage = responce.user?.userProfile?.picture ?? ""
            Defaults.name = responce.user?.userProfile?.name ?? ""
            Defaults.userName = responce.user?.username ?? ""
            self.gotoHomePage()
            onSuccess("Successfully logged in.")
        } onError: { error in
            print(error)
            onError(error.description)
        }
    }
    
}
