//
//  SignUpViewModel.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/7/22.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class SignUpViewModel: BaseViewModel {
    
    func getUnregisteredHatcheries(onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        APIManager.instance.getUnregisteredHatcheries(onSuccess: { hatcheries in
            print(hatcheries)
        }, onError: { error in
            print(error)
            onError(error.description)
        })
    }
    
}
