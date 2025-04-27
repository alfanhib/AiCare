//
//  DefaultPlantIdentify.swift
//  AiCare
//
//  Created by Alfan on 26/04/25.
//
import Foundation
import UIKit

protocol PlantIdentifyUseCaseProtocol {
    func execute(with image: UIImage) async throws -> PlantIdentificationResponse
}

struct DefaultPlantIdentifyUseCase: PlantIdentifyUseCaseProtocol {
    @Injected(\.plantIdentifyService)
    var plantIdentifyService
    
    func execute(with image: UIImage) async throws -> PlantIdentificationResponse {
        return try await plantIdentifyService.fetchPlantIdentificationItems(image: image)
    }
}



