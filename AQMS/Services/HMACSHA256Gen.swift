//
//  HMACSHA256Gen.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/1/22.
//

import Foundation
import CommonCrypto
import CryptoKit
class HMACSHA256Gen {

    private let algorithm = "HmacSHA256"
    private let key = "9EbGeKgNjRnT"
    
//    func encode(data: [String: AnyObject]) -> String? {
//
////        let sha256HMAC = HMAC<SHA256>.
////        val secretKey = SecretKeySpec(key.toByteArray(charset("UTF-8")), algorithm)
////        sha256HMAC.init(secretKey)
////
////        return String(Hex.encodeHex(sha256HMAC.doFinal(data.toString().toByteArray(charset("UTF-8")))))
//    }

    func encode(data: Data) -> String? {
        let secretString = "9EbGeKgNjRnT"
        let key = SymmetricKey(data: Data(secretString.utf8))

        let string = String(decoding: data, as: UTF8.self)

        let signature = HMAC<SHA256>.authenticationCode(for: Data(string.utf8), using: key)
        let value = Data(signature).map { String(format: "%02hhx", $0) }.joined()
        print(value)
        return value
    }
    
}

enum CryptoAlgorithm {
case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

 var HMACAlgorithm: CCHmacAlgorithm {
    var result: Int = 0
    switch self {
    case .MD5:      result = kCCHmacAlgMD5
    case .SHA1:     result = kCCHmacAlgSHA1
    case .SHA224:   result = kCCHmacAlgSHA224
    case .SHA256:   result = kCCHmacAlgSHA256
    case .SHA384:   result = kCCHmacAlgSHA384
    case .SHA512:   result = kCCHmacAlgSHA512
    }
    return CCHmacAlgorithm(result)
 }

 var digestLength: Int {
    var result: Int32 = 0
    switch self {
    case .MD5:      result = CC_MD5_DIGEST_LENGTH
    case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
    case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
    case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
    case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
    case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
    }
    return Int(result)
 }
}

extension String {
    
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
        
        let digest = stringFromResult(result: result, length: digestLen)
        
        return digest
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
}
