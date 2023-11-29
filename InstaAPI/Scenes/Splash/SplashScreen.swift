//
//  ViewController.swift
//  InstaAPI
//
//  Created by Elif Tüm on 30.10.2023.
//

import UIKit

class SplashScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            let vc = SearchVC()
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }


}

