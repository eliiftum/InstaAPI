//
//  NetworkManager.swift
//  AIImageGenerator
//
//  Created by Elif Tum on 26.07.2023.
//

import Foundation


class NetworkManager{
    
    static let shared = NetworkManager()
    
    func request<T: Codable>(with requestType: RequestType, completion: @escaping (Result<T, CustomError>) -> Void) {
        
        guard let url = requestType.url else {return}
        
        var request = URLRequest(url: url)
        
        let headers = [
            "content-type": "application/json",
            "X-RapidAPI-Key": "6f7b8d6eadmsh7d7d571050ca167p1a8290jsn0353efcd74c9",
            "X-RapidAPI-Host": "instagram120.p.rapidapi.com"
        ]
        
        request.allHTTPHeaderFields = headers
        
        if let body = requestType.body, let data = body.data(using: .utf8)   {
            
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        print(json)
                        
                        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
                           let jsonString = String(data: jsonData, encoding: .utf8) {
                            print(jsonString)
                            request.httpBody = jsonData
                        }
                    }
                    
                } catch {
                    completion(.failure(.bodyEncodeError))
                }
        }
        
        request.httpMethod = requestType.httpMethod.rawValue
        
        let session = URLSession.shared
        session.dataTask(with: request){data, response, error in
            guard let data = data else{
                completion(.failure(.dataError))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
            }
            catch _ {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}





