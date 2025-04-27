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
    
    func fetchPlantIdentificationItems(
        image: UIImage,
        latitude: Double? = nil,
        longitude: Double? = nil
    ) async throws -> PlantIdentificationResponse {
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            throw HTTPClientError.invalidRequestData
        }
        
        let base64Image = imageData.base64EncodedString()
        
        var requestBody: [String: Any] = [
            "images": [base64Image],
            "similar_images": true
        ]
        
        if let latitude = latitude, let longitude = longitude {
            requestBody["latitude"] = latitude
            requestBody["longitude"] = longitude
        } else {
            // Default coordinates jika tidak ada
            requestBody["latitude"] = 49.207
            requestBody["longitude"] = 16.608
        }
        
        return try await httpClient.post(url: APIEndpoints.plantIdentifierURL, body: requestBody)
    }
}
