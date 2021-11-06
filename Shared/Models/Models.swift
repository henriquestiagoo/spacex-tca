//
//  Models.swift
//  SpaceXTCA (iOS)
//
//  Created by Tiago Henriques on 01/11/2021.
//

import Foundation

struct Launch: Decodable, Equatable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, name, success, links, rocket, details
        case dateUtc = "date_utc"
        case flightNumber = "flight_number"
    }

    let id: String
    let name: String
    let dateUtc: String
    var rocket: String?
    var success: Bool?
    var links: Links?
    var details: String?
    var flightNumber: Int
}


struct Links: Decodable, Equatable {
    enum CodingKeys: String, CodingKey {
        case patch, webcast, article, wikipedia
        case youtubeId = "youtube_id"
    }
    var patch: Patch?
    var webcast: String?
    var youtubeId: String?
    var article: String?
    var wikipedia: String?
}

extension Links: Identifiable {
    var id: String { patch?.small ?? "" }
}

struct Patch: Decodable, Equatable {
    var small: String?
    var large: String?
}

extension Patch: Identifiable {
  var id: String { small ?? "" }
}
