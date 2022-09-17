//
//  ForgotPasswordVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/15/22.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var enterMobileNumberTF: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var sendOTPBtn: UIButton!
    @IBOutlet weak var detailLbl: UILabel!
    
    let viewModel: SignUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        IQKeyboardManager.shared.disabledToolbarClasses = [ForgotPasswordVC.self]
    }

    func updateUI() {
        sendOTPBtn.titleLabel?.addCharacterSpacing()
    }
    
    @IBAction func sendOTPActon(_ sender: Any) {
        if enterMobileNumberTF.text == "" {
            presentAlertWithTitleAndMessage(title: "", message: PLEASE_ENTER_PHONE_NUMBER, options: "OK") { index in
                //
            }
            return
        }
        if enterMobileNumberTF.text?.count != 10 {
            presentAlertWithTitleAndMessage(title: "", message: PLEASE_ENTER_VALID_PHONE_NUMBER, options: "OK") { index in
                //
            }
            return
        }
        if Reachability.isConnectedToNetwork() {
            APIManager.instance.forgotPasswordWith(mobileNumber: enterMobileNumberTF.text!) { isSuccess in
                if isSuccess {
                    self.view.makeToast("Code For Reseting Password Has Been Sent To Your Registered Mobile Number")
                }
            } onError: { error in
                self.view.makeToast(error)
            }
        } else {
            self.view.makeToast(NO_INTERNET_MESSAGE)
        }
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: MAIN_STORYOARD, bundle: nil)
        let resetPasswordVC = mainStoryboard.instantiateViewController(withIdentifier: RESETPASSWORD_PAGE_IDENTIFIER) as! ResetPasswordVC
        self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ForgotPasswordVC: UITextFieldDelegate {
    //MARK: Text field delegate methods
    
    /// textFieldShouldBeginEditing will call, when user start typing
    ///
    /// - Parameter textField: text field
    /// - Returns: It returns the acceptance of the text.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    /// textFieldDidBeginEditing will call when user start typing on text field.
    ///
    /// - Parameter textField: text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    /// This method will call, while typing the text on text field.
    ///
    /// - Parameters:
    ///   - textField: text field
    ///   - range: range
    ///   - string: entered text
    /// - Returns: It returns the acceptence of the entered text.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == enterMobileNumberTF {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    /// This methohd will call when user stopping with entering text on text field.
    ///
    /// - Parameter textField: text field
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}


