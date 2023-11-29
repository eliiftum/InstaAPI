//
//  UIImageView+Extension.swift
//  InstaAPI
//
//  Created by Elif Tüm on 02.11.2023.
//

import Foundation

import SDWebImage
extension UIImageView {
    func setImage(url: String) {
        if let url = URL(string: url) {
            self.sd_setImage(with: url)
        }
    }
    
    func makeCircular() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
