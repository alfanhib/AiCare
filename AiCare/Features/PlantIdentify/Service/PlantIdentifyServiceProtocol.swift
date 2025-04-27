//
//  PlantIdentifyProtocol.swift
//  AiCare
//
//  Created by Alfan on 24/04/25.
//

import Foundation
import UIKit

protocol PlantIdentifyServiceProtocol {
//    func fetchPlantIdentificationItems() async throws -> [PlantIdentificationItem]
    func fetchPlantIdentificationItems(image: UIImage) async throws -> PlantIdentificationResponse
}
