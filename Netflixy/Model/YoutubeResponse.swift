//
//  YoutubeResponse.swift
//  Netflixy
//
//  Created by abdurhman elbosaty on 12/01/2022.
//

import Foundation
// MARK: - YoutubeResponse
struct YoutubeResponse: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: PageInfo?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let kind, etag: String?
    let id: ID?
}

// MARK: - ID
struct ID: Codable {
    let kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
