//
//  PlantIdentifyInjection.swift
//  AiCare
//
//  Created by Alfan on 24/04/25.
//

import Foundation

struct PlantIdentifyInjectionKey: InjectedKey {
    static var currentValue: PlantIdentifyServiceProtocol = PlantIdentifyServiceFactory.shared.makePlantIdentifyService()
}

extension InjectedValues {
    var plantIdentifyService: PlantIdentifyServiceProtocol {
        get { Self[PlantIdentifyInjectionKey.self] }
        set { Self[PlantIdentifyInjectionKey.self] = newValue }
    }
}
