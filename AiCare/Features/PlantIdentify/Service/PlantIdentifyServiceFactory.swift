//
//  PlantIdentifyServiceFactory.swift
//  AiCare
//
//  Created by Alfan on 24/04/25.
//

import Foundation

class PlantIdentifyServiceFactory {
    static let shared = PlantIdentifyServiceFactory()
    
    private init() {
        
    }
    
    func makePlantIdentifyService() -> PlantIdentifyServiceProtocol {
        return PlantIdentifyService()
    }
    
}
