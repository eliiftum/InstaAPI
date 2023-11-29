//
//  HighlightDetailViewModel.swift
//  InstaAPI
//
//  Created by Elif Tüm on 29.10.2023.
//

import Foundation
protocol HighlightDetailBusinessLogic {
    func didFinishWithResponse(response: HighlightStoriesModel)
    func didFinishWithError(error: CustomError)
}
class HighlightDetailViewModel {
    
    var delegate: HighlightDetailBusinessLogic?
    
    func getDetails(detailsId: String) {
            NetworkManager.shared.request(with: .highlightStories(storiesId: detailsId)) { (response: Result<HighlightStoriesModel, CustomError>) in
                switch response {
                case .success(let success):
                    self.delegate?.didFinishWithResponse(response: success)
                case .failure(let failure):
                    self.delegate?.didFinishWithError(error: failure)
                }
            }
        
    }
}
