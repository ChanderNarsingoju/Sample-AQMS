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
    func getUnregisteredHatcheries(onSuccess: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
        APIManager.instance.getUnregisteredHatcheries(onSuccess: { hatcheries in
            self.hatcheries = hatcheries
            onSuccess("Successfully fetch the unregistered hatcheries.")
        }, onError: { error in
            print(error)
            onError(error.description)
        })
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
    
    func UploadFileToServer(fileURL: URL, fileData: Data, fileType: String) {
        let fileExtension = fileURL.pathExtension
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
        
        let documentName = fileURL.lastPathComponent
        let headers = HTTPHeaders.init(["Content-Disposition": "form-data; name=\"files\"; filename=\"\(documentName)\""])
        Utility.getRootViewController()?.view.makeToast(UPLOADING_FILE)
        APIManager.instance.uploadFile(endUrl: UPLOAD_URL, fileData: fileData, headers: headers, fileName: documentName, mimeType: mimeType) { response in
            print(response)
            switch fileType {
            case FileUploadTypes.CAA.rawValue:
                break
            case FileUploadTypes.OWNER.rawValue:
                break
            case FileUploadTypes.AUTHORIZED_ONE.rawValue:
                break
            case FileUploadTypes.AUTHORIZED_TWO.rawValue:
                break
            case FileUploadTypes.CHEQUE_ONE.rawValue:
                break
            case FileUploadTypes.CHEQUE_TWO.rawValue:
                break
            default:
                break
            }
        } onError: { error in
            print(error)
            switch fileType {
            case FileUploadTypes.CAA.rawValue:
                break
            case FileUploadTypes.OWNER.rawValue:
                break
            case FileUploadTypes.AUTHORIZED_ONE.rawValue:
                break
            case FileUploadTypes.AUTHORIZED_TWO.rawValue:
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
    
}

public enum FileUploadTypes: String {
    case CAA = "caa"
    case OWNER = "owner"
    case AUTHORIZED_ONE = "auth1"
    case AUTHORIZED_TWO = "auth2"
    case CHEQUE_ONE = "cheque1"
    case CHEQUE_TWO = "cheque2"
}
