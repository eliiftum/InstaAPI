//
//  HighlightStoriesModel.swift
//  InstaAPI
//
//  Created by Elif Tüm on 28.10.2023.
//

import Foundation

struct HighlightStoriesModel: Codable {
    let result: [HighlightStoriesResult]?
}

struct HighlightStoriesResult: Codable {
    let imageVersions2: ImageVersions2?
    let originalHeight, originalWidth: Int?
    let pk: String?
    let takenAt: Int?
    let videoVersions: [VideoVersion]?
    let hasAudio: Bool?

    enum CodingKeys: String, CodingKey {
        case imageVersions2 = "image_versions2"
        case originalHeight = "original_height"
        case originalWidth = "original_width"
        case pk
        case takenAt = "taken_at"
        case videoVersions = "video_versions"
        case hasAudio = "has_audio"
    }
}

struct ImageVersions2: Codable {
    let candidates: [VideoVersion]?
}

struct VideoVersion: Codable {
    let width, height: Int?
    let url: String?
    let urlWrapped, urlDownloadable: String?
    let type: Int?

    enum CodingKeys: String, CodingKey {
        case width, height, url
        case urlWrapped = "url_wrapped"
        case urlDownloadable = "url_downloadable"
        case type
    }
}
