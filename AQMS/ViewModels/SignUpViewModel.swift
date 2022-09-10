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
    var hatcheries: [Hatchery] = []
    var selectedHatchery: Hatchery?
    func getUnregisteredHatcheries(onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        APIManager.instance.getUnregisteredHatcheries(onSuccess: { hatcheries in
            self.hatcheries = hatcheries
            onSuccess("Successfully fetch the unregistered hatcheries.")
        }, onError: { error in
            print(error)
            onError(error.description)
        })
    }
    
    func getCAANumbers() -> [String] {
        let string = hatcheries.compactMap({$0.license?.caaRegistrationNumber})
        return string == [] ? [""] : string
    }
    
    func setSelectedHatcheryAt(index: Int) {
        selectedHatchery = hatcheries[index]
    }
    
    func getSelectedHatcheryDetails() -> Hatchery? {
        return selectedHatchery
    }
    
}
