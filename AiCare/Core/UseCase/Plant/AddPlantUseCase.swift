//
//  AddPlantUseCase.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation

struct AddPlantParameters {
    let plant: Plant
}

protocol AddPlantUseCaseProtocol: ThrowingUseCase
where ParameterType == AddPlantParameters, ResultType == Void {}

struct AddPlantUseCase: AddPlantUseCaseProtocol {
    @Injected(\.plantRepository)
    var plantRepository: PlantRepositoryProtocol
    
    func execute(with parameters: AddPlantParameters) async throws {
        try await plantRepository.addPlant(parameters.plant)
    }
}
