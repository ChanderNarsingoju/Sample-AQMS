//
//  SignUpVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/3/22.
//

import Foundation
import UIKit
import DropDown
import AVKit

class SignUpVC: UIViewController {

    @IBOutlet weak var selectPermitTF: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var detailLbl: UILabel!
    
    let viewModel: SignUpViewModel = SignUpViewModel()
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        fetchUnRegisteredHatcharies()
    }
    
    func fetchUnRegisteredHatcharies() {
        if Reachability.isConnectedToNetwork() {
            viewModel.getUnregisteredHatcheries { success in
                //fetched hatcharies.
            } onError: { error in
                self.view.makeToast(error)
            }
        } else {
            self.presentAlertWithTitleAndMessage(title: "", message: NO_INTERNET_MESSAGE, options: OK, completion: { index in
                
            })
        }
    }

    func updateUI() {
        submitBtn.titleLabel?.addCharacterSpacing()
        
        detailLbl.text = "COASTAL AQUACULTURE AUTHORITY \n Department of fisheries \n Ministry of fisheries \n\n\n Animal husbandry and Dairying \n Government of India \n\n\n Chennai-600 035. Tamilnadu, India. \n Phone : 044-24353502 \n\n\n Web : www.caa.gov.in \n\n\n Email : aquaauth@vsnl.net \n                  aquaauth@gmail.com"
    }
    
    func setUpDropDownForField(field: UITextField){
        dropDown.anchorView = field
        dropDown.tag = field.tag
        dropDown.direction = .bottom
        dropDown.dataSource = viewModel.getCAANumbers()
        dropDown.shadowColor = UIColor.black
        dropDown.dismissMode = .automatic
        
        // Top of drop down will be below the anchorView
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedDropDown(index: index, item: item)
        }
        
        dropDown.show()
    }
    
    @IBAction func submitActon(_ sender: Any) {
        if selectPermitTF.text == "" {
            presentAlertWithTitleAndMessage(title: "", message: SELECT_CAA_PERMIT_NUMBER, options: "OK") { index in
                //
            }
            return
        }
        let mainStoryboard: UIStoryboard = UIStoryboard(name: MAIN_STORYOARD, bundle: nil)
        let signUpVC = mainStoryboard.instantiateViewController(withIdentifier: SIGNUP_HATCHERY_DETAILS_IDENTIFIER) as! SignUpHatcheryDetailsVC
        signUpVC.viewModel = viewModel
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func learnHowToRegisterActon(_ sender: Any) {
        guard let filePath = Bundle.main.path(forResource: "how_to_register_video", ofType: "mp4") else { return}
        let player = AVPlayer(url: URL(fileURLWithPath: filePath))
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func selectedDropDown(index: Int, item: String){
        dropDown.hide()
        if let field = dropDown.anchorView as? UITextField {
            field.text = item
            viewModel.setSelectedHatcheryAt(index: index)
            field.resignFirstResponder()
        }
    }
}

extension SignUpVC: UITextFieldDelegate {
    //MARK: Text field delegate methods
    
    /// textFieldShouldBeginEditing will call, when user start typing
    ///
    /// - Parameter textField: text field
    /// - Returns: It returns the acceptance of the text.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setUpDropDownForField(field: textField)
        textField.resignFirstResponder()
        return false
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
        dropDown.hide()
    }
}


