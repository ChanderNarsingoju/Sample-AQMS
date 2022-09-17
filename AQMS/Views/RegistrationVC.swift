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
import AVFoundation
import Photos

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
    let imagePicker = UIImagePickerController()
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
        
        //Setting tags
        profileTypeTF.tag = PROFILE_TYPE_TF_TAG
        addressTF.tag = ADDRESS_TF_TAG
        nameTF.tag = NAME_TF_TAG
        emailAddressTF.tag = EMAIL_ADDRESS_TF_TAG
        authOnePersionNameTF.tag = AUTH_ONE_PERSION_NAME_TF_TAG
        authOnePersionMobileNumberTF.tag = AUTH_ONE_PERSION_MOBILE_NUMBER_TF_TAG
        authOnePersionEmailAddressTF.tag = AUTH_ONE_PERSION_EMAIL_ADDRESS_TF_TAG
        authOnePersionAadharNumberTF.tag = AUTH_ONE_PERSION_AADHAR_NUMBER_TF_TAG
        authTwoPersionNameTF.tag = AUTH_TWO_PERSION_NAME_TF_TAG
        authTwoPersionMobileNumberTF.tag = AUTH_TWO_PERSION_MOBILE_NUMBER_TF_TAG
        authTwoPersionEmailAddressTF.tag = AUTH_TWO_PERSION_EMAIL_ADDRESS_TF_TAG
        authTwoPersionAadharNumberTF.tag = AUTH_TWO_PERSION_AADHAR_NUMBER_TF_TAG
        bankAccountNameTF.tag = BANK_ACCOUNT_NAME_TF_TAG
        bankAccountNumberTF.tag = BANK_ACCOUNT_NUMBER_TF_TAG
        bankAccountTypeTF.tag = BANK_ACCOUNT_TYPE_TF_TAG
        bankNameTF.tag = BANK_NAME_TF_TAG
        bankBranchNameTF.tag = BANK_BRANCH_NAME_TF_TAG
        bankIFSCCodeTF.tag = BANK_IFSC_CODE_TF_TAG
        secondaryBankAccountNameTF.tag = SECONDARY_BANK_ACCOUNT_NAME_TF_TAG
        secondaryBankAccountNumberTF.tag = SECONDARY_BANK_ACCOUNT_NUMBER_TF_TAG
        secondaryBankAccountTypeTF.tag = SECONDARY_BANK_ACCOUNT_TYPE_TF_TAG
        secondaryBankNameTF.tag = SECONDARY_BANK_NAME_TF_TAG
        secondaryBankBranchNameTF.tag = SECONDARY_BANK_BRANCH_NAME_TF_TAG
        secondaryBankIFSCCodeTF.tag = SECONDARY_BANK_IFSC_CODE_TF_TAG
        mobileNumberTF.tag = MOBILE_NUMBER_TF_TAG
        enterOTPTF.tag = ENTER_OTP_TF_TAG
        enterPasswordTF.tag = ENTER_PASSWORD_TF_TAG
        
        mobileNumberTF.maxLength = 10
        authOnePersionMobileNumberTF.maxLength = 10
        authTwoPersionMobileNumberTF.maxLength = 10
                
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
            viewModel?.saveTextFieldValueWith(textField: field)
            field.resignFirstResponder()
        }
    }
    
}

extension RegistrationVC {
    @IBAction func selectPDFFileAction(_ sender: Any) {
        viewModel?.fileProfileType = FileUploadTypes.CAA.rawValue
        let docPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        docPicker.delegate = self
        docPicker.modalPresentationStyle = .fullScreen
        self.present(docPicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadProfilePicture(_ sender: Any) {
        viewModel?.fileProfileType = FileUploadTypes.OWNER.rawValue
        captureFromCamera(isFront: true)
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
        viewModel?.fileProfileType = FileUploadTypes.AUTHORIZED_ONE.rawValue
        captureFromCamera(isFront: true)
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
        viewModel?.fileProfileType = FileUploadTypes.AUTHORIZED_TWO.rawValue
        captureFromCamera(isFront: true)
    }
    
    @IBAction func bankChequeUploadAction(_ sender: Any) {
        viewModel?.fileProfileType = FileUploadTypes.CHEQUE_ONE.rawValue
        showImagePickerActionSheet(sender: sender as! UIButton)
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
        viewModel?.fileProfileType = FileUploadTypes.CHEQUE_TWO.rawValue
        showImagePickerActionSheet(sender: sender as! UIButton)
    }
    
    @IBAction func getOTPAction(_ sender: Any) {
        if mobileNumberTF.text == nil || mobileNumberTF.text == "" {
            presentAlertWithTitleAndMessage(title: "", message: PLEASE_ENTER_PHONE_NUMBER, options: "OK") { index in
                //
            }
            return
        }
        if mobileNumberTF.text?.count != 10 {
            presentAlertWithTitleAndMessage(title: "", message: PLEASE_ENTER_VALID_PHONE_NUMBER, options: "OK") { index in
                //
            }
            return
        }
        
        if emailAddressTF.text == nil || emailAddressTF.text == "" {
            presentAlertWithTitleAndMessage(title: "", message: PLEASE_ENTER_EMAIL_ADDRESS, options: "OK") { index in
                //
            }
            return
        }
        if Reachability.isConnectedToNetwork() {
            viewModel?.generateOTPFor(mobileNumber: mobileNumberTF.text!, email: emailAddressTF.text!)
        } else {
            self.view.makeToast(NO_INTERNET_MESSAGE)
        }
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel?.saveTextFieldValueWith(textField: textField)
    }
    
    /// This methohd will call when user stopping with entering text on text field.
    ///
    /// - Parameter textField: text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        dropDown.hide()
        viewModel?.saveTextFieldValueWith(textField: textField)
    }
    
}

extension RegistrationVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let path: URL = urls.first!
        guard path.startAccessingSecurityScopedResource(),
              let data = try? Data(contentsOf: path) else { return }
        path.stopAccessingSecurityScopedResource()
        let extention = path.pathExtension
        let docName = path.lastPathComponent
        viewModel?.uploadFileToServer(fileData: data, fileType: FileUploadTypes.CAA.rawValue, extention: extention, documentName: docName, onSuccess: { isSuccess in
            if !isSuccess {
                self.view.makeToast("Failed to upload CAA Document!")
            } else{
                self.pdfImageView.image = #imageLiteral(resourceName: "pdflogo")
            }
        })
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Cancelled")
        self.view.makeToast("Task Cancelled")
    }
}

extension RegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            guard let image = info[.originalImage] as? UIImage else {
                print("Expected a dictionary containing an image, but was provided the following: \(info)")
                return
            }
            
            if picker.sourceType == .photoLibrary || picker.sourceType == .savedPhotosAlbum {
                if let URL = info[.referenceURL] as? URL {
                    let options = PHFetchOptions()
                    options.fetchLimit = 1
                    let assets = PHAsset.fetchAssets(withALAssetURLs: [URL], options: options)
                    if assets.count > 0 {
                        let orgImgData = image.jpegData(compressionQuality: 1)!
                        //let orgimageSize: Int = orgImgData.length
                       // let fileName = URL.lastPathComponent
                        displaySelected(image: image)
                        self.imagePicker.dismiss(animated: false, completion: nil)
                        let jpegImage = UIImage(data: orgImgData)!
                        if Reachability.isConnectedToNetwork() {
                            viewModel?.handlePickedImage(image: jpegImage, profileType: viewModel?.fileProfileType ?? "")
                        } else {
                            self.view.makeToast(NO_INTERNET_MESSAGE)
                        }
                    }
                    if #available(iOS 14, *) {
                        if assets.count == 0 {
                            self.showChangePermissionAlert(title: "Limited Photo Usage Access", message:  "You did not provide access to the selected photo(s). Please click on Settings to update the photo usage access.")
                        }
                    }
                }
            }
            else {
                
                let orgImgData = image.jpegData(compressionQuality: 1)!
                //let orgimageSize: Int = orgImgData.length
                displaySelected(image: image)
                let jpegImage = UIImage(data: orgImgData)!
                self.imagePicker.dismiss(animated: false, completion: nil)
                if Reachability.isConnectedToNetwork() {
                    viewModel?.handlePickedImage(image: jpegImage, profileType: viewModel?.fileProfileType ?? "")
                } else {
                    self.view.makeToast(NO_INTERNET_MESSAGE)
                }
            }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        self.view.makeToast("Task Cancelled")
    }
    
    func displaySelected(image: UIImage){
        switch viewModel?.fileProfileType {
        case FileUploadTypes.OWNER.rawValue:
            profilePictureBtn.setImage(image, for: .normal)
            break
        case FileUploadTypes.AUTHORIZED_ONE.rawValue:
            authOnePersionProfilePictureBtn.setImage(image, for: .normal)
            break
        case FileUploadTypes.AUTHORIZED_TWO.rawValue:
            authTwoPersionProfilePictureBtn.setImage(image, for: .normal)
            break
        case FileUploadTypes.CHEQUE_ONE.rawValue:
            uploadChequeBtn.setImage(image, for: .normal)
            break
        case FileUploadTypes.CHEQUE_TWO.rawValue:
            secondaryBankUploadChequeBtn.setImage(image, for: .normal)
            break
        default:
            break
        }
    }
}

extension RegistrationVC {
    
    func showImagePickerActionSheet(sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: NSLocalizedString("Choose Option", comment: ""), preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.captureFromCamera()
        })
        
        let libraryAction = UIAlertAction(title: NSLocalizedString("Library", comment: ""), style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.pickFromLibrary()
        })
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(libraryAction)
        optionMenu.addAction(cancelAction)
        optionMenu.popoverPresentationController?.sourceView = sender
        //self.formControllerObj.present(optionMenu, animated: true, completion: nil)
        let windowTopVC = UIApplication.shared.keyWindow?.rootViewController
        
        windowTopVC?.present(optionMenu, animated: true, completion: nil)
        
    }
    
    func pickFromLibrary() {
        //  photoLibraryAllowsAccessToApplication()
        self.checkAuthorizationWithHandler { (success) in
            if success {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    DispatchQueue.main.async {
                        self.imagePicker.delegate = self
                        self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                        if #available(iOS 11, *) {
                            self.imagePicker.modalPresentationStyle = .overFullScreen
                        } else {
                            self.imagePicker.modalPresentationStyle = .popover
                        }
                        self.imagePicker.popoverPresentationController?.sourceView = self.view
                        let windowTopVC = UIApplication.shared.keyWindow?.rootViewController
                        
                        windowTopVC?.present(self.imagePicker, animated: true, completion: nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showChangePermissionAlert(title: "Photos Unavailable", message: "Please click on settings to allow the Photos usage.")
                }
            }
        }
    }
    
    func captureFromCamera(isFront: Bool = false) {
        //cameraAllowsAccessToApplicationCheck()
        self.checkCameraAuthorizationWithHandler { (success) in
            if success {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    DispatchQueue.main.async {
                        
                        if UIImagePickerController.isCameraDeviceAvailable( UIImagePickerController.CameraDevice.rear) {
                            self.imagePicker.delegate = self
                            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                            if isFront {
                                self.imagePicker.cameraDevice = .front
                            }
                            
                            self.imagePicker.modalPresentationStyle = .fullScreen
                            self.imagePicker.popoverPresentationController?.sourceView = self.view
                            let windowTopVC = UIApplication.shared.keyWindow?.rootViewController
                            
                            windowTopVC?.present(self.imagePicker, animated: true, completion: nil)
                            
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showChangePermissionAlert(title: "Camera Unavailable", message: "Please click on settings to allow the Camera usage.")
                }
            }
        }
    }
    
    //MARK:- CAMERA ACCESS CHECK
    func cameraAllowsAccessToApplicationCheck() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authorizationStatus {
        case .notDetermined:
            // permission dialog not yet presented, request authorization
            AVCaptureDevice.requestAccess(for: AVMediaType.video,
                                             completionHandler: { (granted:Bool) -> Void in
                if granted {
                    print("access granted", terminator: "")
                }
                else {
                    print("access denied", terminator: "")
                }
            })
        case .authorized:
            print("Access authorized", terminator: "")
        case .denied, .restricted:
            showChangePermissionAlert(title: "Camera Unavailable", message: "Please click on settings to allow the Camera usage.")
        default:
            print("DO NOTHING", terminator: "")
        }
    }
    
    func photoLibraryAllowsAccessToApplication() {
        
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .notDetermined:
            //"Automatically handled by iOS"
            break;
        case .authorized:
            print("Access authorized", terminator: "")
        case .denied, .restricted:
            showChangePermissionAlert(title: "Photos Unavailable", message: "Please click on settings to allow the Photos usage.")
        default:
            print("DO NOTHING", terminator: "")
        }
    }
    
    //checking if there is an authorisation for accessing photo library.
    func checkAuthorizationWithHandler(completion: @escaping ((_ success: Bool) -> Void)) {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ (status) in
                self.checkAuthorizationWithHandler(completion: completion)
            })
        }
        else if PHPhotoLibrary.authorizationStatus() == .authorized {
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    //checking if there is an authorisation for accessing Camera.
    func checkCameraAuthorizationWithHandler(completion: @escaping ((_ success: Bool) -> Void)) {
        
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authorizationStatus == .notDetermined {
            
            AVCaptureDevice.requestAccess(for: AVMediaType.video,
                                             completionHandler: { (granted:Bool) -> Void in
                self.checkCameraAuthorizationWithHandler(completion: completion)
            })
        }
        else if authorizationStatus == .authorized {
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    //MARK:- CAMERA & GALLERY NOT ALLOWING ACCESS - ALERT
    func showChangePermissionAlert(title: String, message: String)
    {
        //Camera not available - Alert
        let cameraUnavailableAlertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .destructive) { (_) -> Void in
            let settingsUrl = Foundation.URL(string:UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
            }
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        cameraUnavailableAlertController .addAction(settingsAction)
        cameraUnavailableAlertController .addAction(cancelAction)
        
        Utility.topMostViewController().present(cameraUnavailableAlertController , animated: true, completion: nil)
    }
}
    
    


