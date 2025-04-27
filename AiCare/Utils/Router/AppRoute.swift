//
//  AppRoute.swift
//  AiCare
//
//  Created by Alfan on 25/04/25.
//

import UIKit

enum AppRoute: Equatable {
    case onboarding
    case home(tab: DashboardTabType = .Plant)
    case plantDetail(id: String)
    case plantIdentify
}

extension AppRoute {
    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        switch (lhs, rhs) {
        case (.onboarding, .onboarding):
            return true
        case (.home(let lhsTab), .home(let rhsTab)):
            return lhsTab == rhsTab
        case (.plantDetail(let lhs), .plantDetail(let rhs)):
            return lhs == rhs
        case (.plantIdentify, .plantIdentify):
            return true
        default:
            return false
        }
    }
}
