//
//  Utility.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/7/22.
//

import Foundation
import UIKit

public class Utility {
    class func getRootViewController() -> UIViewController? {
        // getting access to the window object from SceneDelegate
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return nil
        }

        return sceneDelegate.window?.rootViewController
    }
    
    /// Get the top most view in the app
    /// — Returns: It returns current foreground UIViewcontroller
    
    class func topMostViewController() -> UIViewController {
        var topViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topViewController?.presentedViewController) != nil) {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController!
    }
}
