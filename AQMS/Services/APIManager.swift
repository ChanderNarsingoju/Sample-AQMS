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
        let string = String(decoding: request.httpBody ?? Data(), as: UTF8.self)
        
        let val = string.hmac(algorithm: .SHA256, key: ENCODE_SECRET_KEY)
        let operation = "user-profile:login"
        let headers = [HEADER_X_API_SIGNATURE: val,
                                      HEADER_X_API_VERSION: HEADER_X_API_VERSION_VAL,
                                    HEADER_X_API_OPERATION: operation,
                                       HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_VAL]
        
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
                                       HEADER_CONTENT_TYPE: HEADER_CONTENT_TYPE_VAL]
        
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
}



