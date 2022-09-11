//
//  RegistrationVC.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/3/22.
//

import Foundation
import UIKit
import DropDown
import IQKeyboardManagerSwift
import UniformTypeIdentifiers
import Alamofire

class RegistrationVC: UIViewController {

    
    @IBOutlet weak var uploadCAABtn: UIButton!
    @IBOutlet weak var pdfImageView: UIImageView!
    @IBOutlet weak var profilePictureBtn: UIButton!
    @IBOutlet weak var profileTypeTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailAddressTF: UITextField!
    //Auth One Persion
    @IBOutlet weak var addAuthOnePersionTickBtn: UIButton!
    @IBOutlet weak var authOnePersionNameTF: UITextField!
    @IBOutlet weak var authOnePersionMobileNumberTF: UITextField!
    @IBOutlet weak var authOnePersionEmailAddressTF: UITextField!
    @IBOutlet weak var authOnePersionAadharNumberTF: UITextField!
    @IBOutlet weak var authOnePersionProfilePictureBtn: UIButton!
    //Auth two person
    @IBOutlet weak var addAuthTwoPersionTickBtn: UIButton!
    @IBOutlet weak var authTwoPersionNameTF: UITextField!
    @IBOutlet weak var authTwoPersionMobileNumberTF: UITextField!
    @IBOutlet weak var authTwoPersionEmailAddressTF: UITextField!
    @IBOutlet weak var authTwoPersionAadharNumberTF: UITextField!
    @IBOutlet weak var authTwoPersionProfilePictureBtn: UIButton!
    
    //Bank details
    @IBOutlet weak var bankAccountNameTF: UITextField!
    @IBOutlet weak var bankAccountNumberTF: UITextField!
    @IBOutlet weak var bankAccountTypeTF: UITextField!
    @IBOutlet weak var bankNameTF: UITextField!
    @IBOutlet weak var bankBranchNameTF: UITextField!
    @IBOutlet weak var bankIFSCCodeTF: UITextField!
    @IBOutlet weak var uploadChequeBtn: UIButton!
    
    //Secondary Bank Details
    @IBOutlet weak var addSecondaryBankDetailsTickBtn: UIButton!
    @IBOutlet weak var secondaryBankAccountNameTF: UITextField!
    @IBOutlet weak var secondaryBankAccountNumberTF: UITextField!
    @IBOutlet weak var secondaryBankAccountTypeTF: UITextField!
    @IBOutlet weak var secondaryBankNameTF: UITextField!
    @IBOutlet weak var secondaryBankBranchNameTF: UITextField!
    @IBOutlet weak var secondaryBankIFSCCodeTF: UITextField!
    @IBOutlet weak var secondaryBankUploadChequeBtn: UIButton!
    
    //Password
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var getOTPBtn: UIButton!
    @IBOutlet weak var enterOTPTF: UITextField!
    @IBOutlet weak var enterPasswordTF: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    
    @IBOutlet weak var authPersonOneDetailsView: UIView!
    @IBOutlet weak var authPersonOneDetailsViewConstraint: NSLayoutConstraint!//405
    @IBOutlet weak var authPersonTwoAddCheckView: UIView!
    @IBOutlet weak var authPersonTwoAddCheckVIewConstraint: NSLayoutConstraint!//70
    @IBOutlet weak var authPersonTwoDetailsView: UIView!
    
    @IBOutlet weak var authPersonTwoDetailsViewConstraint: NSLayoutConstraint!//405
    @IBOutlet weak var AddSecondaryBankCheckView: UIView!
    
    @IBOutlet weak var secondaryBankDetailsView: UIView!
    @IBOutlet weak var secondaryBankDetailsViewConstraint: NSLayoutConstraint!//594
    
    
    var isAddAuthorizedPersonOneVisible: Bool = false
    var isAddAuthorizedPersonTwoVisible: Bool = false
    var isAddSecondaryBankDetailsVisible: Bool = false
    
    var viewModel: SignUpViewModel?
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        IQKeyboardManager.shared.disabledToolbarClasses = [RegistrationVC.self]
    }

    func updateUI() {
        
        profileTypeTF.delegate = self
        addressTF.delegate = self
        nameTF.delegate = self
        emailAddressTF.delegate = self
        authOnePersionNameTF.delegate = self
        authOnePersionMobileNumberTF.delegate = self
        authOnePersionEmailAddressTF.delegate = self
        authOnePersionAadharNumberTF.delegate = self
        authTwoPersionNameTF.delegate = self
        authTwoPersionMobileNumberTF.delegate = self
        authTwoPersionEmailAddressTF.delegate = self
        authTwoPersionAadharNumberTF.delegate = self
        bankAccountNameTF.delegate = self
        bankAccountNumberTF.delegate = self
        bankAccountTypeTF.delegate = self
        bankNameTF.delegate = self
        bankBranchNameTF.delegate = self
        bankIFSCCodeTF.delegate = self
        secondaryBankAccountNameTF.delegate = self
        secondaryBankAccountNumberTF.delegate = self
        secondaryBankAccountTypeTF.delegate = self
        secondaryBankNameTF.delegate = self
        secondaryBankBranchNameTF.delegate = self
        secondaryBankIFSCCodeTF.delegate = self
        mobileNumberTF.delegate = self
        enterOTPTF.delegate = self
        enterPasswordTF.delegate = self
        
        //Setting dropdown icons
        let imageView1 = UIImageView()
        imageView1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView1.image = #imageLiteral(resourceName: "down_icon")
        let rightView1 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightView1.addSubview(imageView1)
        imageView1.center = rightView1.center
        profileTypeTF.rightView = rightView1
        profileTypeTF.rightViewMode = .always
        
        let imageView2 = UIImageView()
        imageView2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView2.image = #imageLiteral(resourceName: "down_icon")
        let rightView2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightView2.addSubview(imageView2)
        imageView2.center = rightView2.center
        bankAccountTypeTF.rightView = rightView2
        bankAccountTypeTF.rightViewMode = .always
        
        let imageView3 = UIImageView()
        imageView3.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView3.image = #imageLiteral(resourceName: "down_icon")
        let rightView3 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightView3.addSubview(imageView3)
        imageView3.center = rightView3.center
        secondaryBankAccountTypeTF.rightView = rightView3
        secondaryBankAccountTypeTF.rightViewMode = .always

        submitBtn.titleLabel?.addCharacterSpacing()
        authPersonOneDetailsViewConstraint.constant = 0
        authPersonTwoAddCheckVIewConstraint.constant = 0
        authPersonTwoDetailsViewConstraint.constant = 0
        secondaryBankDetailsViewConstraint.constant = 0
        
        authPersonOneDetailsView.isHidden = true
        authPersonTwoDetailsView.isHidden = true
        authPersonTwoAddCheckView.isHidden = true
        secondaryBankDetailsView.isHidden = true
    }
    
    func setUpDropDownForField(field: UITextField){
        dropDown.anchorView = field
        dropDown.tag = field.tag
        dropDown.direction = .bottom
        var dataSource:[String] = []
        if field == profileTypeTF {
            dataSource = ["Owner", "In Charge"]
        }
        if field == bankAccountTypeTF || field == secondaryBankAccountTypeTF {
            dataSource = ["CORPORATE", "PERSONAL"]
        }
        dropDown.dataSource = dataSource
        dropDown.shadowColor = UIColor.black
        dropDown.dismissMode = .automatic
        
        // Top of drop down will be below the anchorView
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedDropDown(index: index, item: item)
        }
        
        dropDown.show()
    }
    
    func selectedDropDown(index: Int, item: String){
        dropDown.hide()
        if let field = dropDown.anchorView as? UITextField {
            field.text = item
            //viewModel.setSelectedHatcheryAt(index: index)
            field.resignFirstResponder()
        }
    }
    
    func openCamera() {
       let imgPicker = UIImagePickerController()
       imgPicker.delegate = self
       imgPicker.sourceType = .camera
       imgPicker.allowsEditing = false
       imgPicker.showsCameraControls = true
       self.present(imgPicker, animated: true, completion: nil)
    }
    
}

extension RegistrationVC {
    @IBAction func selectPDFFileAction(_ sender: Any) {
        let docPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        docPicker.delegate = self
        docPicker.modalPresentationStyle = .fullScreen
        self.present(docPicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadProfilePicture(_ sender: Any) {
        openCamera()
    }
    
    @IBAction func addAuthOnePersionCheckAction(_ sender: Any) {
        if isAddAuthorizedPersonOneVisible {
            isAddAuthorizedPersonOneVisible = false
            addAuthOnePersionTickBtn.setImage(#imageLiteral(resourceName: "uncheck_icon"), for: .normal)
            addAuthTwoPersionTickBtn.setImage(#imageLiteral(resourceName: "uncheck_icon"), for: .normal)
            authPersonOneDetailsViewConstraint.constant = 0
            authPersonTwoAddCheckVIewConstraint.constant = 0
            authPersonTwoDetailsViewConstraint.constant = 0
            authPersonOneDetailsView.isHidden = true
            authPersonTwoDetailsView.isHidden = true
            authPersonTwoAddCheckView.isHidden = true
        } else {
            isAddAuthorizedPersonOneVisible = true
            addAuthOnePersionTickBtn.setImage(#imageLiteral(resourceName: "check_icon"), for: .normal)
            authPersonOneDetailsViewConstraint.constant = 405
            authPersonTwoAddCheckVIewConstraint.constant = 70
            authPersonTwoDetailsViewConstraint.constant = 0
            authPersonOneDetailsView.isHidden = false
            authPersonTwoAddCheckView.isHidden = false
            authPersonTwoDetailsView.isHidden = true
        }
    }
    
    @IBAction func authOneUploadProfilePicture(_ sender: Any) {
    }
    
    @IBAction func addAuthTwoPersionCheckAction(_ sender: Any) {
        if isAddAuthorizedPersonTwoVisible {
            isAddAuthorizedPersonTwoVisible = false
            addAuthTwoPersionTickBtn.setImage(#imageLiteral(resourceName: "uncheck_icon"), for: .normal)
                    authPersonTwoDetailsViewConstraint.constant = 0
                    authPersonTwoDetailsView.isHidden = true
        } else {
            isAddAuthorizedPersonTwoVisible = true
            addAuthTwoPersionTickBtn.setImage(#imageLiteral(resourceName: "check_icon"), for: .normal)
            authPersonTwoDetailsViewConstraint.constant = 405
            authPersonTwoDetailsView.isHidden = false
        }
    }
    
    @IBAction func authTwoUploadProfilePicture(_ sender: Any) {
    }
    
    @IBAction func bankChequeUploadAction(_ sender: Any) {
    }
    
    @IBAction func addSecondaryBankCheckAction(_ sender: Any) {
        if isAddSecondaryBankDetailsVisible {
            isAddSecondaryBankDetailsVisible = false
            addSecondaryBankDetailsTickBtn.setImage(#imageLiteral(resourceName: "uncheck_icon"), for: .normal)
            secondaryBankDetailsView.isHidden = true
            secondaryBankDetailsViewConstraint.constant = 0
        } else {
            isAddSecondaryBankDetailsVisible = true
            addSecondaryBankDetailsTickBtn.setImage(#imageLiteral(resourceName: "check_icon"), for: .normal)
            secondaryBankDetailsView.isHidden = false
            secondaryBankDetailsViewConstraint.constant = 594
        }
    }
    
    @IBAction func secondaryBankChequeUploadAction(_ sender: Any) {
    }
    
    @IBAction func getOTPAction(_ sender: Any) {
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegistrationVC: UITextFieldDelegate {
    //MARK: Text field delegate methods
    
    /// textFieldShouldBeginEditing will call, when user start typing
    ///
    /// - Parameter textField: text field
    /// - Returns: It returns the acceptance of the text.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == bankAccountTypeTF || textField == secondaryBankAccountTypeTF || textField == profileTypeTF {
            setUpDropDownForField(field: textField)
            textField.resignFirstResponder()
            return false
        }
        
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
        dropDown.hide()
    }
    
}

extension RegistrationVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let path: URL = urls.first!
        guard path.startAccessingSecurityScopedResource(),
              let data = try? Data(contentsOf: path) else { return }
        path.stopAccessingSecurityScopedResource()
        
        viewModel?.UploadFileToServer(fileURL: path, fileData: data, fileType: FileUploadTypes.CAA.rawValue)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Cancelled")
        self.view.makeToast("Task Cancelled")
    }
}

extension RegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as?
            UIImage {
            //self.imgV.image = img
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print("error")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        self.view.makeToast("Task Cancelled")
    }
}
    
    


