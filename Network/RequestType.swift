//
//  RequestType.swift
//  InstaAPI
//
//  Created by Elif Tum on 26.07.2023.
//

import Foundation


enum RequestType {
    
    case highlights(username: String)
    case highlightStories(storiesId: String)
    
    var url: URL? {
        switch self {
        case .highlights(let _):
            let url = URLConstants.baseURL.rawValue + URLConstants.highlights.rawValue
            return URL(string: url)
        case .highlightStories(let _):
            let url = URLConstants.baseURL.rawValue + URLConstants.highlightStories.rawValue
            return URL(string: url)
        }
       
    }
    
    var httpMethod : HttpMethod {
        switch self {
        default:
            return .POST
        }
    }
    
    var body: String? {
        switch self {
        case .highlightStories(let storiesId):
            let highlightId = "{\"highlightId\": \"\(storiesId)\"}"
            return highlightId
        case .highlights(let username):
            let username = "{\"username\": \"\(username)\"}"
            return username
        default:
            return nil
        }
    }
}


enum HttpMethod : String {
    case GET
    case POST
}




enum URLConstants: String {
    
    case baseURL = "https://instagram120.p.rapidapi.com/api/instagram"
    case highlights = "/highlights"
    case highlightStories = "/highlightStories"
}
