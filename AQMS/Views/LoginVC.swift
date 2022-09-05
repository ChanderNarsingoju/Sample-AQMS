//
//  LoginVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/1/22.
//

import UIKit
import SwiftyUserDefaults
import ToastSwiftFramework

class LoginVC: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginBGView: UIView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var usernameTF: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    let viewModel = LoginViewModel()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        updateUI()
    }

    func updateUI() {
        //MARK: REMOVE these values
        usernameTF.text = "7287891362"
        passwordTF.text = "Test@123"
        passwordTF.isSecureTextEntry = true
        usernameTF.iconType = .image
        passwordTF.iconType = .image
        usernameTF.iconImage = #imageLiteral(resourceName: "username_icon")
        passwordTF.iconImage = #imageLiteral(resourceName: "password_icon")
        passwordTF.enablePasswordToggle()
        usernameTF.selectedLineColor = UIColor(red: 117/255.0, green: 157/255.0, blue: 185/255.0, alpha: 1.0)
        passwordTF.selectedLineColor = UIColor(red: 117/255.0, green: 157/255.0, blue: 185/255.0, alpha: 1.0)
        usernameTF.selectedTitleColor = UIColor(red: 117/255.0, green: 157/255.0, blue: 185/255.0, alpha: 1.0)
        passwordTF.selectedTitleColor = UIColor(red: 117/255.0, green: 157/255.0, blue: 185/255.0, alpha: 1.0)
        signInBtn.titleLabel?.addCharacterSpacing()
        signUpBtn.titleLabel?.addCharacterSpacing()
        loginBtn.titleLabel?.addCharacterSpacing()
        forgotPasswordBtn.titleLabel?.addCharacterSpacing()
    }
    
    @IBAction func signInAction(_ sender: Any) {
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = mainStoryboard.instantiateViewController(withIdentifier: "SignUpVCIdentifier") as! SignUpVC
        
        self.navigationController?.pushViewController(signUpVC, animated: true)
//        let navigationController = UINavigationController(rootViewController: signUpVC)
//        navigationController.isNavigationBarHidden = true
//
//        // getting access to the window object from SceneDelegate
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let sceneDelegate = windowScene.delegate as? SceneDelegate
//        else {
//            return
//        }
//        sceneDelegate.window?.rootViewController?.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if usernameTF.text == nil || usernameTF.text == "" {
            self.view.makeToast("Please Enter Email/Phone")
            return
        }
        if passwordTF.text == nil || passwordTF.text == "" {
            self.view.makeToast("Please Enter Password")
            return
        }
        if Reachability.isConnectedToNetwork() {
            viewModel.userLogin(username: usernameTF.text ?? "", password: passwordTF.text ?? "") { success in
                print(success)
            } onError: { failed in
                self.view.makeToast(failed)
            }
        } else {
            self.view.makeToast("No internet connection")
        }
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        
    }
}

