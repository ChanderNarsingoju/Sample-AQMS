//
//  FileUploadResponse.swift
//  AQMS
//
//  Created by Narsingoju Chander on 9/11/22.
//

import Foundation
import ObjectMapper

class FileUploadResponse: Mappable {
    var id: Int?
    var name: String?
    var alternativeText, caption, width, height: String?
    var formats: String?
    var hash, ext, mime: String?
    var size: Double?
    var url: String?
    var previewURL: String?
    var provider: String?
    var providerMetadata: String?
    var createdAt, updatedAt: String?
    var related: [String]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
        self.alternativeText <- map["alternativeText"]
        self.caption <- map["caption"]
        self.width <- map["width"]
        self.height <- map["height"]
        self.formats <- map["formats"]
        self.hash <- map["hash"]
        self.ext <- map["ext"]
        self.mime <- map["mime"]
        self.size <- map["size"]
        self.url <- map["url"]
        self.previewURL <- map["previewUrl"]
        self.provider <- map["provider"]
        self.providerMetadata <- map["provider_metadata"]
        self.createdAt <- map["created_at"]
        self.updatedAt <- map["updated_at"]
        self.related <- map["related"]
    }
}
