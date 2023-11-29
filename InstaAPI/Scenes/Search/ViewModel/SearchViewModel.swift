//
//  SearchViewModel.swift
//  InstaAPI
//
//  Created Elif Tüm on 30.10.2023.
//

import Foundation

protocol SearchBusinessLogic {
    func didFinishWithResponse(response:HighlightsModel)
    func didFinishWithError(error:CustomError)
}

struct SearchViewModel {
    
    var delegate: SearchBusinessLogic?
    
    func getHighlightes(userName: String){
        NetworkManager.shared.request(with: .highlights(username: userName)) { (response: Result<HighlightsModel, CustomError>) in
            switch response {
            case .success(let success):
                self.delegate?.didFinishWithResponse(response: success)
            case .failure(let failure):
                self.delegate?.didFinishWithError(error: failure)
            }
        }
    }
}
