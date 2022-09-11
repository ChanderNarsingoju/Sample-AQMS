//
//  BaseVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/7/22.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    
}

extension UIViewController {
    /// Display message in prompt view
    ///
    /// — Parameters:
    /// — title: Title to display Alert
    /// — message: Pass string of content message
    /// — options: Pass multiple UIAlertAction title like “OK”,”Cancel” etc
    /// — completion: The block to execute after the presentation finishes.
    
    func presentAlertWithTitleAndMessage(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        Utility.topMostViewController().present(alertController, animated: true, completion: nil)
    }
    
}
