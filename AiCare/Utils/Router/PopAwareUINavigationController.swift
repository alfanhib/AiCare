//
//  PopAwareUINavigationController.swift
//  AiCare
//
//  Created by Alfan on 25/04/25.
//

import UIKit

class PopAwareUINavigationController: UINavigationController, UINavigationControllerDelegate {
    var popHandler: (() -> Void)?
    var stackSizeProvider: (() -> Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        didShow _: UIViewController,
        animated _: Bool
    ) {
        if let stackSizeProvider = stackSizeProvider,
           stackSizeProvider() > navigationController.viewControllers.count {
            popHandler?()
        }
    }
}
