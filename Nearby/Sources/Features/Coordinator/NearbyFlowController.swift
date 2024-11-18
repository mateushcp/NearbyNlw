//
//  NearbyFlowController.swift
//  Nearby
//
//  Created by Mateus Henrique Coelho de Paulo on 04/11/24.
//

import Foundation
import UIKit


class NearbyFlowController {
    private var navigationController: UINavigationController?
    
    public init() {
    }
    
    func start() -> UINavigationController? {
        let contentView = SplashView()
//        let startViewController = SplashViewController(contentView: contentView, delegate: self)
        let startViewController = HomeViewController()
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController
    }
    
}

extension NearbyFlowController: SplashFlowDelegate {
    func decideNavigationFlow() {
        let contentView = WelcomeView()
        let welcomeViewController = WelcomeViewController(contentView: contentView)
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
}

