//
//  PlantIdentifyModel.swift
//  AiCare
//
//  Created by Alfan on 24/04/25.
//

import Foundation

import Foundation

// MARK: - Response Models
struct PlantIdentificationResponse: Codable {
    let accessToken: String
    let modelVersion: String
    let customId: String?
    let input: PlantIdentificationInput
    let result: PlantIdentificationResult
    let status: String
    let slaCompliantClient: Bool
    let slaCompliantSystem: Bool
    let created: Double
    let completed: Double
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case modelVersion = "model_version"
        case customId = "custom_id"
        case input
        case result
        case status
        case slaCompliantClient = "sla_compliant_client"
        case slaCompliantSystem = "sla_compliant_system"
        case created
        case completed
    }
}

struct PlantIdentificationInput: Codable {
    let latitude: Double
    let longitude: Double
    let similarImages: Bool
    let images: [String]
    let datetime: String
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case similarImages = "similar_images"
        case images
        case datetime
    }
}

struct PlantIdentificationResult: Codable {
    let classification: Classification
    let isPlant: IsPlant
    
    enum CodingKeys: String, CodingKey {
        case classification
        case isPlant = "is_plant"
    }
}

struct Classification: Codable {
    let suggestions: [PlantSuggestion]
}

struct PlantSuggestion: Codable, Identifiable {
    let id: String
    let name: String
    let probability: Double
    let similarImages: [SimilarImage]?
    let details: PlantDetails
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case probability
        case similarImages = "similar_images"
        case details
    }
}

struct SimilarImage: Codable {
    let id: String
    let url: String
    let licenseName: String?
    let licenseUrl: String?
    let citation: String?
    let similarity: Double
    let urlSmall: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case licenseName = "license_name"
        case licenseUrl = "license_url"
        case citation
        case similarity
        case urlSmall = "url_small"
    }
}

struct PlantDetails: Codable {
    let commonNames: [String]?
    let taxonomy: Taxonomy
    let url: String?
    let gbifId: Int?
    let inaturalistId: Int?
    let rank: String?
    let description: Description?
    let synonyms: [String]?
    let image: PlantImage?
    let edibleParts: [String]?
    let watering: String?
    let bestLightCondition: String?
    let bestSoilType: String?
    let commonUses: String?
    let culturalSignificance: String?
    let toxicity: String?
    let bestWatering: String?
    
    enum CodingKeys: String, CodingKey {
        case commonNames = "common_names"
        case taxonomy
        case url
        case gbifId = "gbif_id"
        case inaturalistId = "inaturalist_id"
        case rank
        case description
        case synonyms
        case image
        case edibleParts = "edible_parts"
        case watering
        case bestLightCondition = "best_light_condition"
        case bestSoilType = "best_soil_type"
        case commonUses = "common_uses"
        case culturalSignificance = "cultural_significance"
        case toxicity
        case bestWatering = "best_watering"
    }
}

struct Taxonomy: Codable {
    let className: String?
    let genus: String?
    let order: String?
    let family: String?
    let phylum: String?
    let kingdom: String?
    
    enum CodingKeys: String, CodingKey {
        case className = "class"
        case genus
        case order
        case family
        case phylum
        case kingdom
    }
}

struct Description: Codable {
    let value: String
    let citation: String?
    let licenseName: String?
    let licenseUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case value
        case citation
        case licenseName = "license_name"
        case licenseUrl = "license_url"
    }
}

struct PlantImage: Codable {
    let value: String
    let citation: String?
    let licenseName: String?
    let licenseUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case value
        case citation
        case licenseName = "license_name"
        case licenseUrl = "license_url"
    }
}

struct IsPlant: Codable {
    let probability: Double
    let threshold: Double
    let binary: Bool
}
