//
//  PlantIdentifyProtocol.swift
//  AiCare
//
//  Created by Alfan on 24/04/25.
//

import Foundation
import UIKit

class PlantIdentifyService: PlantIdentifyServiceProtocol {
    
    @Injected(\.httpClient) var httpClient
    
    func fetchPlantIdentificationItems(image: UIImage) async throws -> PlantIdentificationResponse {
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            throw HTTPClientError.invalidRequestData
        }
        
        let base64Image = imageData.base64EncodedString()
        
        let requestBody: [String:Any] = [
            "images": [base64Image],
            "latitude": 49.207,
            "longitude": 16.608,
            "similar_images": true
        ]
        
        return try await httpClient.post(url: APIEndpoints.plantIdentifierURL, body: requestBody)
    }
}
