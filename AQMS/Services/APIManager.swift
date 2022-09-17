//
//  APIManager.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/1/22.
//

import Foundation
import CryptoKit
import Alamofire
import SwiftyUserDefaults

class APIManager {
    static let instance = APIManager()
    private init() {}
    let userDefaults = UserDefaults.standard
    
    //MARK: Login with identifier and password
    func userLogin(username: String, password:String, onSuccess: @escaping (UserResponseModel) -> Void, onError: @escaping (String) -> Void) {
        //Converting string to url
        let urlString = BASE_LOGIN_URL
        guard let serviceUrl = URL(string: urlString) else { return }
        let notifToken = Defaults.fcmToken
        let user = username
        let pass = password
        let parameterDictionary = [IDENTIFIER : user,
                                     PASSWORD : pass,
                                    NOT_TOKEN : notifToken]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameterDictionary as Any) {
            request.httpBody = jsonData
            
        }
        let string = Utility.convertDataToStringWith(data: request.httpBody ?? Data())
        
        let val = string.hmac()
        let operation = "user-profile:login"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                                       HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_JSON]
        
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    let userResponse = UserResponseModel(JSON: responseDict, context: .none)
                    onSuccess(userResponse ?? UserResponseModel(JSON: [:], context: .none)!)
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    onError("Identifier or password invalid.")
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }
    
    //MARK: Get Unregistered Hatery List
    func getUnregisteredHatcheries(onSuccess: @escaping ([Hatchery]) -> Void, onError: @escaping (String) -> Void) {
        //Converting string to url
        let urlString = BASE_URL+UN_REGISTERED_HATCHERY_URL_PATH
        guard let serviceUrl = URL(string: urlString) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let val = HMACSHA256Gen().encode(path: UN_REGISTERED_HATCHERY_URL_PATH)
        let operation = "hatchery:view-unregistered"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                                       HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_JSON]
        
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    var responseJson: String? = nil
                    responseJson = String(data: response.data ?? Data(), encoding: .utf8)
                    let responseDict = self.convertJSONStringToArray(responseJson ?? "")
                    print(responseDict)
                    let hatcheries = responseDict?.compactMap({Hatchery(JSON: $0 as! [String : Any], context: .none)})
                    onSuccess(hatcheries ?? [])
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    onError("Identifier or password invalid.")
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }
    
    
    func uploadFile(endUrl: String, fileData: Data?, headers: HTTPHeaders, fileName: String, mimeType: String, onSuccess: @escaping ([FileUploadResponse]) -> Void, onError: @escaping (String) -> Void){
        
        AF.upload(multipartFormData: { multipartFormData in
            if let data = fileData {
                multipartFormData.append(data, withName: "files", fileName: fileName, mimeType: mimeType)
            }
        }, to: endUrl, method: .post , headers: headers).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    var responseJson: String? = nil
                    responseJson = String(data: response.data ?? Data(), encoding: .utf8)
                    let responseDict = self.convertJSONStringToArray(responseJson ?? "")
                    print(responseDict)
                    let fileUploadResponse = responseDict?.compactMap({FileUploadResponse(JSON: $0 as! [String : Any], context: .none)})
                    onSuccess(fileUploadResponse ?? [])
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    onError("Failed to upload file.")
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }
    
    
    func faceEnroll(base64String: String, profileType: String, hatcheryId: Int, onSuccess: @escaping (FaceEnrollResponse, String) -> Void, onError: @escaping (String) -> Void) {
        //Converting string to url
        let urlString = FACE_ENROLE_URL
        guard let serviceUrl = URL(string: urlString) else { return }
        let rrnValue = "45897855885588"
        let timeStamp = Utility.getCurrentUTCTimeString()
        let sklValue = "IVPAF-LSVMG-JMZCE-TXVEM"
        let serviceCode = "23"
        let userId = "37"
        let fileName = "\(hatcheryId)-\(profileType)-\(Int64(Date().timeIntervalSince1970 * 1000))"
        let parameterDictionary = [LIVE_FACE_IMAGE : base64String,
                                               RRN : rrnValue,
                                    REF_TIME_STAMP : timeStamp,
                                               SLK : sklValue,
                                      SERVICE_CODE : serviceCode,
                                           USER_ID : userId,
                                     ENROLLMENT_ID : fileName]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameterDictionary as Any) {
            request.httpBody = jsonData
            
        }
        var string = Utility.convertDataToStringWith(data: request.httpBody ?? Data())
        string = string.replacingOccurrences(of: "\\/", with: "/")
//        let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
//
//        do {
//            try string.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
//        } catch {
//            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//        }
        
        let val = string.hmac()
        let operation = "common:face-recognition"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                          HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_JSON]
        
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    let userResponse = FaceEnrollResponse(JSON: responseDict, context: .none)
                    onSuccess(userResponse ?? FaceEnrollResponse(JSON: [:], context: .none)!, fileName)
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    onError("Identifier or password invalid.")
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }
    
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
    
    func generateRegistrationOTP(mobileNumber: String, userEmail: String, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        //Converting string to url
        let urlString = REGISTRATION_OTP_URL
        guard let serviceUrl = URL(string: urlString) else { return }
        let parameterDictionary = [EMAIL : userEmail,
                                  NUMBER : mobileNumber]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameterDictionary as Any) {
            request.httpBody = jsonData
            
        }
        let string = Utility.convertDataToStringWith(data: request.httpBody ?? Data())
        
        let val = string.hmac()
        let operation = "common:validate-otp"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                          HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_JSON]
        
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    onSuccess(true)
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    onError("Failed.")
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }
    
    func forgotPasswordWith(mobileNumber: String, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        //Converting string to url
        let urlString = FORGOT_PASSWORD_OTP_URL
        guard let serviceUrl = URL(string: urlString) else { return }
        let parameterDictionary = [IDENTIFIER : mobileNumber]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameterDictionary as Any) {
            request.httpBody = jsonData
            
        }
        let string = Utility.convertDataToStringWith(data: request.httpBody ?? Data())
        
        let val = string.hmac()
        let operation = "user-profile:reset-password"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                          HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_JSON]
        
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    onSuccess(true)
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    onError(responseDict["message"] as? String ?? "Failed.")
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }
    
    func resetPasswordWith(password: String, resetPassword: String, tokenValue: String, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        //Converting string to url
        let urlString = RESET_PASSWORD_URL
        guard let serviceUrl = URL(string: urlString) else { return }
        let parameterDictionary = [NEW_PASSWORD : password,
                                CONFIRM_PASSWORD : resetPassword,
                                     TOKEN_CODE : tokenValue]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameterDictionary as Any) {
            request.httpBody = jsonData
            
        }
        let string = Utility.convertDataToStringWith(data: request.httpBody ?? Data())
        
        let val = string.hmac()
        let operation = "user-profile:reset-password"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                          HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_JSON]
        
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    onSuccess(true)
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict["message"])
                    if let message = responseDict["message"] as? String {
                        onError(message)
                    } else {
                        let resetPasswordResponse = ResetPasswordResponse(JSON: responseDict, context: .none)
                        onError(resetPasswordResponse?.message?.password?.message ?? "Failed.")
                    }
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }
    
    func checkUniqueness(attribute : String , value: String, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        let urlString = TEST_UNIQUE_FIELDS_URL
        guard let serviceUrl = URL(string: urlString) else { return }
        let parameterDictionary = [[ATTRIBUTE : attribute,
                                       VALUE : value,
                                  CURRENT_ID : ""]]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameterDictionary as Any) {
            request.httpBody = jsonData
            
        }
        let string = Utility.convertDataToStringWith(data: request.httpBody ?? Data())
        
        let val = string.hmac()
        let operation = "common:validate-form"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                          HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_JSON]
        
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    if let attrObj = responseDict[attribute] as? [String: AnyObject]{
                        let unique = attrObj["unique"] as! Bool
                        if !unique {
                            onError(attrObj["message"] as? String ?? "")
                            return
                        }
                    }
                    onSuccess(true)
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    onError("Failed")
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }
    
    func checkAccountNumberUniqueness(attribute : String , value: [String: String], onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        let urlString = TEST_UNIQUE_FIELDS_URL
        guard let serviceUrl = URL(string: urlString) else { return }
        let parameterDictionary = [[ATTRIBUTE : attribute,
                                       VALUE : value,
                                  CURRENT_ID : ""]]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameterDictionary as Any) {
            request.httpBody = jsonData
            
        }
        let string = Utility.convertDataToStringWith(data: request.httpBody ?? Data())
        
        let val = string.hmac()
        let operation = "common:validate-form"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                          HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_JSON]
        
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    if let attrObj = responseDict[attribute] as? [String: AnyObject]{
                        let unique = attrObj["unique"] as! Bool
                        if !unique {
                            onError(attrObj["message"] as? String ?? "")
                            return
                        }
                    }
                    onSuccess(true)
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    onError("Failed")
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }
    
    /*func getBookings(onSuccess: @escaping (UserResponseModel) -> Void, onError: @escaping (String) -> Void) {
        //Converting string to url
        let urlString = BASE_LOGIN_URL
        guard let serviceUrl = URL(string: urlString) else { return }
        let notifToken = Defaults.fcmToken
        let user = username
        let pass = password
        let parameterDictionary = [IDENTIFIER : user,
                                     PASSWORD : pass,
                                    NOT_TOKEN : notifToken]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = HTTPMethod.post.rawValue
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameterDictionary as Any) {
            request.httpBody = jsonData
            
        }
        let string = String(decoding: request.httpBody ?? Data(), as: UTF8.self)
        
        let val = string.hmac(algorithm: .SHA256, key: ENCODE_SECRET_KEY)
        let operation = "user-profile:login"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                                       HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_JSON]
        
        request.allHTTPHeaderFields = headers
        AF.request(request).responseJSON { (response:AFDataResponse<Any>) in
            print(response)
            switch(response.result) {
            case .success(_):
                if response.response?.statusCode == 200 {
                    let responseDict = self.convertJsonStringToDictionary(data: response.data ?? Data())
                    print(responseDict)
                    let userResponse = UserResponseModel(JSON: responseDict, context: .none)
                    onSuccess(userResponse ?? UserResponseModel(JSON: [:], context: .none)!)
                } else if response.response?.statusCode == 400 || response.response?.statusCode == 401 {
                    onError("Identifier or password invalid.")
                } else if response.response?.statusCode == 500{
                    onError("Could not connect to server.")
                } else if response.response?.statusCode == nil {
                    onError("No internet connection.")
                }
                break
            case .failure(let error):
                print(error as Any)
                onError(error.localizedDescription)
                break
            }
        }
    }*/
    
    func convertJsonStringToDictionary(data:Data) -> [String:Any]{
        var responseJson: String? = nil
        responseJson = String(data: data, encoding: .utf8)
        // JSON string to dictionary convertion.
        var error: Error?
        var outerJson: Any?
        defer {
        }
        do {
            if let anEncoding = responseJson?.data(using: .utf8) {
                outerJson = try? JSONSerialization.jsonObject(with: anEncoding, options: .allowFragments)
            }
        }
        var responseDictionary = [String: Any]()
        // If JSON Data as Dictionary.
        if (outerJson is [String: Any]) {
            if let aJson = outerJson as? [String: Any] {
                responseDictionary = aJson
            }
        }
        // If error occurs.
        if responseDictionary.isEmpty {
            if let anError = error {
                print("JSON convertion Error: \(anError)")
            }
            print("JSON convertion Error localized description: \(error?.localizedDescription ?? "")")
        } else {
            // log response  data dictionary if necessary.
        }
        return responseDictionary
        
    }

    public func convertJSONStringToArray(_ JSONObject : String) -> Array<AnyObject>? {
        if let data = JSONObject.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Array<AnyObject>
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}



