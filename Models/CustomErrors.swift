//
//  CustomError.swift
//  AIImageGenerator
//
//  Created by Elif Tum on 31.07.2023.
//

import Foundation

enum CustomError: Error{
    
    case decodingError
    case dataError
    case bodyEncodeError
    case urlError
    case responseError
    case noMoreImage
    
    var message : String{
        
        switch self {
        case .decodingError:
            return "Decode Error"
        case .dataError:
            return "Check your internet connection"
        case .urlError:
            return "URL Error"
        case .responseError:
            return "Response Error"
        case .noMoreImage:
            return "Please, research with new keyword. "
        case .bodyEncodeError:
            return "Body Encode Error!"
        }
    }
}
