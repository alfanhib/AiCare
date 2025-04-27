//
//  Env.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//

import Foundation

enum Env {
    case development
    case staging
    case production
    
    static var current: Env {
        #if DEBUG
            return .development
        #else
            return .production
        #endif
    }
    
    var baseURL: String {
        switch self {
            case .development:
                return "https://plant.id/api/v3"
            case .staging:
                return "https://plant.id/api/v3"
            case .production:
                return "https://plant.id/api/v3"
        }
    }
}

