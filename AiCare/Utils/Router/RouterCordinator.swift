//
//  RouterCordinator.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

extension Router where T == AppRoute {
    
    func navigateToOnboarding() {
        makeRoot(.onboarding)
    }
    
    func navigateToHome() {
        makeRoot(.home(tab: .Plant))
    }
    
    func navigateToIdentify() {
        push(.plantIdentify)
    }
    
}
