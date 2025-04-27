//
//  UseCaseInjection.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation

// Plant Use Cases
struct GetPlantsUseCaseKey: InjectedKey {
    static var currentValue: any GetPlantsUseCaseProtocol = GetPlantsUseCase()
}

struct AddPlantUseCaseKey: InjectedKey {
    static var currentValue: any AddPlantUseCaseProtocol = AddPlantUseCase()
}

struct PlantIdentifyUseCaseKey: InjectedKey {
    static var currentValue: any PlantIdentifyUseCaseProtocol = PlantIdentifyUseCase()
}

// Extend InjectedValues
extension InjectedValues {
    // Plant Use Cases
    var getPlantsUseCase: any GetPlantsUseCaseProtocol {
        get { Self[GetPlantsUseCaseKey.self] }
        set { Self[GetPlantsUseCaseKey.self] = newValue }
    }
    
    var addPlantUseCase: any AddPlantUseCaseProtocol {
        get { Self[AddPlantUseCaseKey.self] }
        set { Self[AddPlantUseCaseKey.self] = newValue }
    }
    
    var plantIdentifyUseCase: any PlantIdentifyUseCaseProtocol {
        get { Self[PlantIdentifyUseCaseKey.self] }
        set { Self[PlantIdentifyUseCaseKey.self] = newValue }
    }
}
