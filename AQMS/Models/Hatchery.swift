//
//  Hatchery.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/7/22.
//

import Foundation
import ObjectMapper

// MARK: - Hatchery
class Hatchery: Mappable {
    var id: Int?
    var name, address, address2: String?
    var pinCode: String?
    var contactPerson: String?
    var faxNumber, email, city: String?
    var district, zone, state: String?
    var expired: Bool?
    var permittedSpeciesID: PermittedSpeciesID?
    var approvalStatus: String?
    var rejectReason: String?
    var contactNumber: String?
    var userProfile: Int?
    var isDelete: Bool?
    var country, updateRequestDetails: String?
    var updateRequestFlag, rzrpayCustomerID, rzrpayVirtualAccID: String?
    var createUser: CreateUser?
    var updateUser: Bool?
    var createdAt, updatedAt: String?
    var bankDetails: [BankDetail]?
    var license: License?
    var fyImportedStock: Int?
    var phoneNumber: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.address <- map["address"]
        self.address2 <- map["address2"]
        self.pinCode <- map["pinCode"]
        self.contactPerson <- map["contactPerson"]
        self.faxNumber <- map["faxNumber"]
        self.email <- map["email"]
        self.city <- map["city"]
        self.district <- map["district"]
        self.zone <- map["zone"]
        self.state <- map["state"]
        self.expired <- map["expired"]
        self.permittedSpeciesID <- map["permittedSpeciesId"]
        self.approvalStatus <- map["approvalStatus"]
        self.rejectReason <- map["rejectReason"]
        self.contactNumber <- map["contactNumber"]
        self.userProfile <- map["userProfile"]
        self.isDelete <- map["isDelete"]
        self.country <- map["country"]
        self.updateRequestDetails <- map["updateRequestDetails"]
        self.updateRequestFlag <- map["updateRequestFlag"]
        self.rzrpayCustomerID <- map["rzrpayCustomerId"]
        self.rzrpayVirtualAccID <- map["rzrpayVirtualAccId"]
        self.createUser <- map["createUser"]
        self.updateUser <- map["updateUser"]
        self.createdAt <- map["created_at"]
        self.updatedAt <- map["updated_at"]
        self.bankDetails <- map["bankDetails"]
        self.license <- map["license"]
        self.fyImportedStock <- map["fyImportedStock"]
        self.phoneNumber <- map["phoneNumber"]
    }
}

// MARK: - CreateUser
class CreateUser: Mappable {
    var id: Int?
    var username, email, provider: String?
    var confirmed, blocked: Bool?
    var role, userProfile: Int?
    var name, createdAt, updatedAt: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.id <- map["id"]
        self.username <- map["username"]
        self.email <- map["email"]
        self.provider <- map["provider"]
        self.confirmed <- map["confirmed"]
        self.blocked <- map["blocked"]
        self.role <- map["role"]
        self.userProfile <- map["userProfile"]
        self.name <- map["name"]
        self.createdAt <- map["created_at"]
        self.updatedAt <- map["updated_at"]
    }
}

// MARK: - License
class License: Mappable {
    var id, hatcheryID: Int?
    var issuingDate, validFrom, validTo: String?
    var noOfBroodsStockPerYear: Int?
    var document: String?
    var caaRegistrationNumber: String?
    var createUser: Int?
    var updateUser: Bool?
    var createdBy, updatedBy: String?
    var createdAt, updatedAt: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.id <- map["id"]
        self.hatcheryID <- map["hatcheryId"]
        self.issuingDate <- map["issuingDate"]
        self.validFrom <- map["validFrom"]
        self.validTo <- map["validTo"]
        self.noOfBroodsStockPerYear <- map["noOfBroodsStockPerYear"]
        self.document <- map["document"]
        self.caaRegistrationNumber <- map["CAARegistrationNumber"]
        self.createUser <- map["createUser"]
        self.updateUser <- map["updateUser"]
        self.createdBy <- map["created_by"]
        self.updatedBy <- map["updated_by"]
        self.createdAt <- map["created_at"]
        self.updatedAt <- map["updated_at"]
    }
}

// MARK: - PermittedSpeciesID
class PermittedSpeciesID: Mappable {
    var id: Int?
    var name, details: String?
    var picture: String?
    var isDelete: Bool?
    var type: String?
    var cubicleFee, gst, duration, weightPerCubicle: Int?
    var stockPerCubicle, maxAllowedCubicles, quarterlyBookingLimit, quarterlyCubicleLimit: Int?
    var monthlyBookingLimit, monthlyCubicleLimit, incenerationFee, createUser: Int?
    var updateUser: Int?
    var createdAt, updatedAt: String?
    var bookingIPLimit, quarantineFee, labFee: Int?
    var chargeDelay: Bool?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.details <- map["details"]
        self.picture <- map["picture"]
        self.isDelete <- map["isDelete"]
        self.type <- map["type"]
        self.cubicleFee <- map["cubicle_fee"]
        self.gst <- map["gst"]
        self.duration <- map["duration"]
        self.weightPerCubicle <- map["weightPerCubicle"]
        self.stockPerCubicle <- map["stockPerCubicle"]
        self.maxAllowedCubicles <- map["maxAllowedCubicles"]
        self.quarterlyBookingLimit <- map["quarterlyBookingLimit"]
        self.quarterlyCubicleLimit <- map["quarterlyCubicleLimit"]
        self.monthlyBookingLimit <- map["monthlyBookingLimit"]
        self.monthlyCubicleLimit <- map["monthlyCubicleLimit"]
        self.incenerationFee <- map["incenerationFee"]
        self.createUser <- map["createUser"]
        self.updateUser <- map["updateUser"]
        self.createdAt <- map["created_at"]
        self.updatedAt <- map["updated_at"]
        self.bookingIPLimit <- map["bookingIPLimit"]
        self.quarantineFee <- map["quarantine_fee"]
        self.labFee <- map["lab_fee"]
        self.chargeDelay <- map["chargeDelay"]
    }
}

class BankDetail: Codable {
    var ifsc, accountName, bankName, branchName: String?
    var accountNumber, accountType, bankAccountDetailProof: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.ifsc <- map["IFSC"]
        self.accountName <- map["accountName"]
        self.bankName <- map["bankName"]
        self.branchName <- map["branchName"]
        self.accountNumber <- map["accountNumber"]
        self.accountType <- map["accountType"]
        self.bankAccountDetailProof <- map["bankAccountDetailProof"]
    }
}
