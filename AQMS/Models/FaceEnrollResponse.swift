//
//  FaceEnrollResponse.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/17/22.
//

import Foundation
import ObjectMapper

class FaceEnrollResponse: Mappable {
    var txnstatus, errcode, errdesc: String?
    var status: Int?
    var enrolledid, facelivenesstransid, faceverifytransid: String?
    var enrolltransid: String?
    var responsetime: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.txnstatus <- map["txnstatus"]
        self.errcode <- map["errcode"]
        self.errdesc <- map["errdesc"]
        self.status <- map["status"]
        self.enrolledid <- map["enrolledid"]
        self.facelivenesstransid <- map["facelivenesstransid"]
        self.faceverifytransid <- map["faceverifytransid"]
        self.enrolltransid <- map["enrolltransid"]
        self.responsetime <- map["responsetime"]
    }
}
