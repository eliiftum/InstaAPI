//
//  HighlitsModel.swift
//  InstaAPI
//
//  Created by Elif Tüm on 28.10.2023.
//

import Foundation

struct HighlightsModel: Codable {
    let result: [HighlightsResult]?
}

struct HighlightsResult: Codable {
    let id, title: String?
    let coverMedia: CoverMedia?

    enum CodingKeys: String, CodingKey {
        case id, title
        case coverMedia = "cover_media"
    }
}

struct CoverMedia: Codable {
    let croppedImageVersion: CroppedImageVersion?

    enum CodingKeys: String, CodingKey {
        case croppedImageVersion = "cropped_image_version"
    }
}

struct CroppedImageVersion: Codable {
    let url: String?
    let urlWrapped: String?

    enum CodingKeys: String, CodingKey {
        case url
        case urlWrapped = "url_wrapped"
    }
}
