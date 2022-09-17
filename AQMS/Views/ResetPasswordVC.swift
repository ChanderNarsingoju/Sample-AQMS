//
//  ResetPasswordVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/15/22.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var enterOTPTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var resetPasswordTF: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var resetPasswordBtn: UIButton!
    
    
    let viewModel: SignUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        IQKeyboardManager.shared.disabledToolbarClasses = [ResetPasswordVC.self]
    }

    func updateUI() {
        resetPasswordBtn.titleLabel?.addCharacterSpacing()
    }
    
    @IBAction func resetPasswordActon(_ sender: Any) {
        let password = passwordTF.text?.trim() ?? ""
        let resetPassword = resetPasswordTF.text?.trim() ?? ""
        let tokenValue = enterOTPTF.text?.trim() ?? ""
        if password == "" {
            presentAlertWithTitleAndMessage(title: "", message: PLEASE_ENTER_NEW_PASSWORD, options: "OK") { index in
                //
            }
            return
        }
        if resetPassword == "" {
            presentAlertWithTitleAndMessage(title: "", message: PLEASE_UPDATE_CONFIRM_PASSWORD_FIELD, options: "OK") { index in
                //
            }
            return
        }
        
        if tokenValue == "" {
            presentAlertWithTitleAndMessage(title: "", message: PLEASE_UPDATE_TOKEN_THAT_HAS_BEEN_SENT_TO_YOUR_PHONE, options: "OK") { index in
                //
            }
            return
        }
        
        if password != resetPassword {
            presentAlertWithTitleAndMessage(title: "", message: PASSWORDS_DOES_NOT_MATCH, options: "OK") { index in
                //
            }
            return
        }
        if Reachability.isConnectedToNetwork() {
            APIManager.instance.resetPasswordWith(password: password, resetPassword: resetPassword, tokenValue: tokenValue, onSuccess: { isSuccess in
                if isSuccess {
                    self.view.makeToast("Password Reset Successfully!")
                }
            }, onError: { error in
                    self.presentAlertWithTitleAndMessage(title: "", message: error, options: "OK") { index in
                    //
                }
            })
        } else {
            self.view.makeToast(NO_INTERNET_MESSAGE)
        }
        
        //let mainStoryboard: UIStoryboard = UIStoryboard(name: MAIN_STORYOARD, bundle: nil)
        //let signUpVC = mainStoryboard.instantiateViewController(withIdentifier: SIGNUP_HATCHERY_DETAILS_IDENTIFIER) as! SignUpHatcheryDetailsVC
        //signUpVC.viewModel = viewModel
        //self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ResetPasswordVC: UITextFieldDelegate {
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
        
        return true
    }
    
    /// This methohd will call when user stopping with entering text on text field.
    ///
    /// - Parameter textField: text field
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}


