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
        let mainStoryboard: UIStoryboard = UIStoryboard(name: MAIN_STORYOARD, bundle: nil)
        let homeVC = mainStoryboard.instantiateViewController(withIdentifier: HOME_PAGE_IDENTIFIER) as! HomeVC
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
        let mainStoryboard: UIStoryboard = UIStoryboard(name: MAIN_STORYOARD, bundle: nil)
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: LOGIN_PAGE_IDENTIFIER) as! LoginVC
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
    
    func generateImageUrlWith(path: String) -> String {
        let string = "\(BASE_URL)\(path)?s=\(HMACSHA256Gen().encode(path: path))"
        return string
    }
    
    
}
