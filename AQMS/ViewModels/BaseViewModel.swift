//
//  BaseViewModel.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/5/22.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class BaseViewModel: NSObject {
    func gotoHomePage() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeVCIdentifier") as! HomeVC
        let navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.isNavigationBarHidden = true
        
        // getting access to the window object from SceneDelegate
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        sceneDelegate.window?.rootViewController = navigationController
    }
    
    func gotoLoginPage() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVCIdentifier") as! LoginVC
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.isNavigationBarHidden = true
        
        // getting access to the window object from SceneDelegate
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        sceneDelegate.window?.rootViewController = navigationController
    }
}
