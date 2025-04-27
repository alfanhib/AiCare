//
//  GetPlantUseCase.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation

protocol GetPlantsUseCaseProtocol: ThrowingUseCase
where ParameterType == Void, ResultType == [Plant] {}

struct GetPlantsUseCase: GetPlantsUseCaseProtocol {
    @Injected(\.plantRepository)
    var plantRepository: PlantRepositoryProtocol
    
    func execute(with parameters: Void) async throws -> [Plant] {
        return try await plantRepository.getAllPlants()
    }
}
