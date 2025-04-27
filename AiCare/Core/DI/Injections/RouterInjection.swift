//
//  RouterInjection.swift
//  AiCare
//
//  Created by Alfan on 25/04/25.
//

import Foundation

// MARK: - Router Key
struct RouterKey: InjectedKey {
    static var currentValue: Router<AppRoute> = Router()
}

// MARK: - InjectedValues Extension
extension InjectedValues {
    var router: Router<AppRoute> {
        get { Self[RouterKey.self] }
        set { Self[RouterKey.self] = newValue }
    }
}
