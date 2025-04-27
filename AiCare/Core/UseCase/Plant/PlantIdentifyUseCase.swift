//
//  PlantIdentify.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation
import UIKit

struct PlantIdentifyParameters {
    let image: UIImage
    let latitude: Double?
    let longitude: Double?
}

protocol PlantIdentifyUseCaseProtocol: ThrowingUseCase
where ParameterType == PlantIdentifyParameters, ResultType == PlantIdentificationResponse {}

struct PlantIdentifyUseCase: PlantIdentifyUseCaseProtocol {
    @Injected(\.plantIdentifyService)
    var plantIdentifyService: PlantIdentifyServiceProtocol
    
    func execute(with parameters: PlantIdentifyParameters) async throws -> PlantIdentificationResponse {
        return try await plantIdentifyService.fetchPlantIdentificationItems(
            image: parameters.image,
            latitude: parameters.latitude,
            longitude: parameters.longitude
        )
    }
}
