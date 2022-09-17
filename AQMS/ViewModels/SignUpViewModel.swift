//
//  SignUpViewModel.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/7/22.
//

import Foundation
import UIKit
import SwiftyUserDefaults
import Alamofire

class SignUpViewModel: BaseViewModel {
    var hatcheries: [Hatchery] = []
    var selectedHatchery: Hatchery?
    
    var fileProfileType = ""
    
    var isHatcheryInCharge: Bool = false
    var mAccountName: String = ""
    var mAccountNumber: String = ""
    var mAccountType: String = ""
    var mBankName: String = ""
    var mBranchName: String = ""
    var mIFSCCode: String = ""
    var mAccountNameTwo: String = ""
    var mAccountNumberTwo: String = ""
    var mAccountTypeTwo: String = ""
    var mBankNameTwo: String = ""
    var mBranchNameTwo: String = ""
    var mIFSCCodeTwo: String = ""
    var mUserName: String = ""
    var mUserGST: String = ""
    var mUserAddress: String = ""
    var mUserPhoneNumber: String = ""
    var mNumberOfBookingPerMonth: String = ""
    var mUserEmail: String = ""
    var mUserPassword: String = ""
    var mUserSIPnumber: String = ""
    var mPerMitedSampleLimit: String = ""
    var mPerMitIssueDate: String = ""
    var mPerMitExpiryDate: String = ""
    var mSupplierId: String = ""
    var mOTP: String = ""
    var mBankAccountDetailProof: String = ""
    var mAuthOneEmail: String = ""
    var mAuthTwoEmail: String = ""
    var mAuthOneName: String = ""
    var mAuthTwoName: String = ""
    var mAadharOne: String = ""
    var mAadharTwo: String = ""
    var mAuthOnePhoneNumber: String = ""
    var mAuthtwoPhoneNumber: String = ""
    
    var mSIPDocument: String = ""
    var mCheckPicture: String = ""
    var mProfilePictureThree: String = ""
    //var document = MutableLiveData<File>()
    
    var caaUploaded: Bool = false
    
    var obsEnrollmentSuccess: Bool = false
    var obsDialogMessage: String = ""
    
    private var profileUrl: String = ""
    private var authOneUrl: String = ""
    private var authTwoUrl: String = ""
    
    private var caaDocumentError: Bool = false
    private var profilePictureError: Bool = false
    private var authOnePictureError: Bool = false
    private var authTwoPictureError: Bool = false
    
    var chequeOneUrl: String = ""
    var chequeTwoUrl: String = ""
    var cAADocumentUrl: String = ""

    
    func getUnregisteredHatcheries(onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        APIManager.instance.getUnregisteredHatcheries(onSuccess: { hatcheries in
            self.hatcheries = hatcheries
            onSuccess("Successfully fetch the unregistered hatcheries.")
        }, onError: { error in
            print(error)
            onError(error.description)
        })
    }
    
    func saveTextFieldValueWith(textField: UITextField) {
        switch textField.tag {
        case PROFILE_TYPE_TF_TAG: //Profile Type
            if textField.text?.lowercased() == "In Charge".lowercased(){
                isHatcheryInCharge = true
            } else {
                isHatcheryInCharge = false
            }
            break
        case ADDRESS_TF_TAG: //Address
            mUserAddress = textField.text?.trim() ?? ""
            break
        case NAME_TF_TAG: //Name
            mUserName = textField.text?.trim() ?? ""
            break
        case EMAIL_ADDRESS_TF_TAG: //Email
            mUserEmail = textField.text?.trim() ?? ""
            break
        case AUTH_ONE_PERSION_NAME_TF_TAG: //Auth one person name
            mAuthOneName = textField.text?.trim() ?? ""
            break
        case AUTH_ONE_PERSION_MOBILE_NUMBER_TF_TAG: //Auth one person Phone Number
            mAuthOnePhoneNumber = textField.text?.trim() ?? ""
            if mAuthOnePhoneNumber.count >= 10 {
                checkUniqueness(attribute: "auth1Phone", value: mAuthOnePhoneNumber)
            }
            break
        case AUTH_ONE_PERSION_EMAIL_ADDRESS_TF_TAG: //Auth one person Email
            mAuthOneEmail = textField.text?.trim() ?? ""
            break
        case AUTH_ONE_PERSION_AADHAR_NUMBER_TF_TAG: //Auth one person Aadhar Number
            mAadharOne = textField.text?.trim() ?? ""
            if mAadharOne.count >= 12 {
                checkUniqueness(attribute: "auth1Aadhaar", value: mAadharOne)
            }
            break
        case AUTH_TWO_PERSION_NAME_TF_TAG: //Auth two person Name
            mAuthTwoName = textField.text?.trim() ?? ""
            break
        case AUTH_TWO_PERSION_MOBILE_NUMBER_TF_TAG: //Auth two person Phone Number
            mAuthtwoPhoneNumber = textField.text?.trim() ?? ""
            if mAuthtwoPhoneNumber.count >= 10 {
                checkUniqueness(attribute: "auth2Phone", value: mAuthtwoPhoneNumber)
            }
            break
        case AUTH_TWO_PERSION_EMAIL_ADDRESS_TF_TAG: //Auth two person Email
            mAuthTwoEmail = textField.text?.trim() ?? ""
            break
        case AUTH_TWO_PERSION_AADHAR_NUMBER_TF_TAG: //Auth one person Aadhar Number
            mAadharTwo = textField.text?.trim() ?? ""
            if mAadharTwo.count >= 12 {
                checkUniqueness(attribute: "auth2Aadhaar", value: mAadharTwo)
            }
            break
        case BANK_ACCOUNT_NAME_TF_TAG: //Bank account name
            mAccountName = textField.text?.trim() ?? ""
            break
        case BANK_ACCOUNT_NUMBER_TF_TAG: //Bank account number
            mAccountNumber = textField.text?.trim() ?? ""
            if mAccountNumber.count >= 6 && mIFSCCode != "" {
                var value = [String: String]()
                value["accountNumber"] = mAccountNumber
                value["IFSC"] = mIFSCCode
                checkAccountNumberUniqueness(attribute: "bankAccount", value: value)
            }
            break
        case BANK_ACCOUNT_TYPE_TF_TAG: //Bank account type
            mAccountType = textField.text?.trim() ?? ""
            break
        case BANK_NAME_TF_TAG: //Bank Name
            mBankName = textField.text?.trim() ?? ""
            break
        case BANK_BRANCH_NAME_TF_TAG: //Bank Branch
            mBranchName = textField.text?.trim() ?? ""
            break
        case BANK_IFSC_CODE_TF_TAG: //Bank IFSC code
            mIFSCCode = textField.text?.trim() ?? ""
            if mIFSCCode.count >= 2 && mAccountNumber != "" {
                var value = [String: String]()
                value["accountNumber"] = mAccountNumber
                value["IFSC"] = mIFSCCode
                checkAccountNumberUniqueness(attribute: "bankAccount", value: value)
            }
            break
        case SECONDARY_BANK_ACCOUNT_NAME_TF_TAG: //Secondary Bank Account Name
            mAccountNameTwo = textField.text?.trim() ?? ""
            break
        case SECONDARY_BANK_ACCOUNT_NUMBER_TF_TAG: //Secondary Bank Account Number
            mAccountNumberTwo = textField.text?.trim() ?? ""
            break
        case SECONDARY_BANK_ACCOUNT_TYPE_TF_TAG: //Secondary Bank Account Type
            mAccountTypeTwo = textField.text?.trim() ?? ""
            break
        case SECONDARY_BANK_NAME_TF_TAG: //Secondary Bank Nmae
            mBankNameTwo = textField.text?.trim() ?? ""
            break
        case SECONDARY_BANK_BRANCH_NAME_TF_TAG: //Secondary Bank Branch Nmae
            mBranchNameTwo = textField.text?.trim() ?? ""
            break
        case SECONDARY_BANK_IFSC_CODE_TF_TAG: //Secondary Bank IFSC code
            mIFSCCodeTwo = textField.text?.trim() ?? ""
            break
        case MOBILE_NUMBER_TF_TAG: // Phone number
            mUserPhoneNumber = textField.text?.trim() ?? ""
            if mUserPhoneNumber.count >= 10 {
                checkUniqueness(attribute: "phoneNumber", value: mUserPhoneNumber)
            }
            break
        case ENTER_OTP_TF_TAG: // OTP
            mOTP = textField.text?.trim() ?? ""
            break
        case ENTER_PASSWORD_TF_TAG: //Password
            mUserPassword = textField.text?.trim() ?? ""
            break
        
        default:
            break
        }
    }
    
    func getCAANumbers() -> [String] {
        let string = hatcheries.compactMap({$0.license?.caaRegistrationNumber})
        return string == [] ? [""] : string
    }
    
    func setSelectedHatcheryAt(index: Int) {
        selectedHatchery = hatcheries[index]
    }
    
    func getSelectedHatcheryDetails() -> Hatchery? {
        return selectedHatchery
    }
    
    func checkUniqueness(attribute : String , value: String) {
        APIManager.instance.checkUniqueness(attribute: attribute, value: value) { isSuccess in
            //
        } onError: { error in
            Utility.getRootViewController()?.view.makeToast(error)
        }

    }
    
    func checkAccountNumberUniqueness(attribute : String , value: [String: String]) {
        APIManager.instance.checkAccountNumberUniqueness(attribute: attribute, value: value) { isSuccess in
            //
        } onError: { error in
            Utility.getRootViewController()?.view.makeToast(error)
        }

    }
    
    func uploadFileToServer(fileData: Data, fileType: String, extention: String, documentName: String, onSuccess: @escaping (Bool) -> Void) {
        let fileExtension = extention
        var mimeType = ""
        if fileExtension == "png" || fileExtension == "jpg" || fileExtension == "jpeg" {
            mimeType = HEADER_CONTENT_TYPE_IMAGE
        }
        if fileExtension == "pdf" {
            mimeType = HEADER_CONTENT_TYPE_PDF
        }
        if mimeType == "" {
            Utility.getRootViewController()?.view.makeToast(UNSUPPORTED_FILE_EXTENSION)
            return
        }
        
        let documentName = documentName
        let headers = HTTPHeaders.init(["Content-Disposition": "form-data; name=\"files\"; filename=\"\(documentName)\""])
        Utility.getRootViewController()?.view.makeToast(UPLOADING_FILE)
        APIManager.instance.uploadFile(endUrl: UPLOAD_URL, fileData: fileData, headers: headers, fileName: documentName, mimeType: mimeType) { response in
            print(response)
            let fileURL = response.first?.url ?? ""
            switch fileType {
            case FileUploadTypes.CAA.rawValue:
                self.cAADocumentUrl = fileURL
                self.caaUploaded = true
                break
            case FileUploadTypes.OWNER.rawValue:
                self.profileUrl = fileURL
                break
            case FileUploadTypes.AUTHORIZED_ONE.rawValue:
                self.authOneUrl = fileURL
                break
            case FileUploadTypes.AUTHORIZED_TWO.rawValue:
                self.authTwoUrl = fileURL
                break
            case FileUploadTypes.CHEQUE_ONE.rawValue:
                self.chequeOneUrl = fileURL
                break
            case FileUploadTypes.CHEQUE_TWO.rawValue:
                self.chequeTwoUrl = fileURL
                break
            default:
                break
            }
            onSuccess(true)
        } onError: { error in
            print(error)
            switch fileType {
            case FileUploadTypes.CAA.rawValue:
                self.caaDocumentError = false
                break
            case FileUploadTypes.OWNER.rawValue:
                self.profilePictureError = false
                break
            case FileUploadTypes.AUTHORIZED_ONE.rawValue:
                self.authOnePictureError = false
                break
            case FileUploadTypes.AUTHORIZED_TWO.rawValue:
                self.authTwoPictureError = false
                break
            case FileUploadTypes.CHEQUE_ONE.rawValue:
                break
            case FileUploadTypes.CHEQUE_TWO.rawValue:
                break
            default:
                break
            }
        }
    }
    
    func handlePickedImage(image: UIImage, profileType: String) {
        if profileType == FileUploadTypes.OWNER.rawValue || profileType == FileUploadTypes.AUTHORIZED_ONE.rawValue || profileType == FileUploadTypes.AUTHORIZED_TWO.rawValue {
            uploadProfilePicture(image: image, profileType: profileType)
        } else if profileType == FileUploadTypes.CHEQUE_ONE.rawValue || profileType == FileUploadTypes.CHEQUE_TWO.rawValue {
            uploadFileToServer(fileData: image.pngData() ?? image.jpegData(compressionQuality: 1.0)!, fileType: profileType, extention: "jpeg", documentName: "asset.jpeg") { isSuccess in
                
            }
        }
    }
    
    func uploadProfilePicture(image: UIImage, profileType: String) {
        //guard let base64 = image.toBase64() else { return }
        let imageObj = image.scalePreservingAspectRatio(targetSize: CGSize(width: 320, height: 640))
        let imageData = imageObj.compressTo(1.0)

        let strBase64 = imageData?.base64EncodedString(options: .endLineWithCarriageReturn).trim().replacingOccurrences(of: "\n", with: "")
        if let base64 = strBase64 {
            APIManager.instance.faceEnroll(base64String: base64, profileType: profileType, hatcheryId: selectedHatchery?.id ?? 0) { (response, fileName) in
                print(response)
                if response.status == 1 {
                    Utility.getRootViewController()?.view.makeToast(response.errdesc)
                    self.uploadFileToServer(fileData: image.pngData() ?? image.jpegData(compressionQuality: 1.0)!, fileType: profileType, extention: "jpeg", documentName: "\(fileName).jpeg") { isSuccess in
                        if isSuccess{
                            Utility.getRootViewController()?.view.makeToast("Face registered successfully!")
                        } else {
                            Utility.getRootViewController()?.view.makeToast("File upload failed!")
                        }
                    }
                    
                } else if response.status == 0 {
                    if response.errdesc == "Query face found" {
                        let returnEnrollment = response.enrolledid?.components(separatedBy: "-")
                        if returnEnrollment?[0] ?? "" == "\(self.selectedHatchery?.id ?? 0)" {
                            let profile = returnEnrollment?[1] ?? ""
                            var profileLabel = ""
                            if profile == profileType {
                                self.uploadFileToServer(fileData: image.pngData() ?? image.jpegData(compressionQuality: 1.0)!, fileType: profileType, extention: "jpeg", documentName: "\(fileName).jpeg") { isSuccess in
                                    if isSuccess{
                                        Utility.getRootViewController()?.view.makeToast("Face registered successfully!")
                                    } else {
                                        Utility.getRootViewController()?.view.makeToast("File upload failed!")
                                    }
                                }
                            } else {
                                switch profile {
                                case "owner":
                                    profileLabel = "owner"
                                    break
                                case "auth1":
                                    profileLabel = "authorized person 1"
                                    break
                                case "auth2":
                                    profileLabel = "authorized person 2"
                                    break
                                default:
                                    break
                                }
                                Utility.getRootViewController()?.view.makeToast("Face is already registered with the current hatchery as \(profileLabel). Please scan a different face. Previous face enrollment ID : \(response.enrolledid ?? "")")
                            }
                        } else {
                            Utility.getRootViewController()?.view.makeToast("Face is already registered with a different hatchery. Please scan a different face. Previous face enrollment ID : \(response.enrolledid ?? "")")
                        }
                    } else {
                        Utility.getRootViewController()?.view.makeToast(response.errdesc ?? "")
                    }
                } else {
                    Utility.getRootViewController()?.view.makeToast("Something wrong with face enroll, please contact your administrator")
                }
            } onError: { error in
                Utility.getRootViewController()?.view.makeToast(error)
            }
        }
    }
    
    func generateOTPFor(mobileNumber: String, email: String) {
        APIManager.instance.generateRegistrationOTP(mobileNumber: mobileNumber, userEmail: email) { response in
            
        } onError: { error in
            
        }

    }
}

public enum FileUploadTypes: String {
    case CAA = "caa"
    case OWNER = "owner"
    case AUTHORIZED_ONE = "auth1"
    case AUTHORIZED_TWO = "auth2"
    case CHEQUE_ONE = "cheque1"
    case CHEQUE_TWO = "cheque2"
}
