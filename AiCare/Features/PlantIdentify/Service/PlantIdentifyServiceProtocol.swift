//
//  PlantIdentifyProtocol.swift
//  AiCare
//
//  Created by Alfan on 24/04/25.
//

import Foundation
import UIKit

protocol PlantIdentifyServiceProtocol {
    func fetchPlantIdentificationItems(
        image: UIImage,
        latitude: Double?,
        longitude: Double?
    ) async throws -> PlantIdentificationResponse
}
