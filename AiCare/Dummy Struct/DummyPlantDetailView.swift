//
//  DummyPlantDetailView.swift
//  AiCare
//
//  Created by Alfan on 26/04/25.
//

import SwiftUI

// Helper class containing dummy data for previews
struct PreviewPlantDetailData {
    // Create dummy plant identification response
    static func createDummyPlantResponse() -> PlantIdentificationResponse {
        let taxonomy = Taxonomy(
            className: "Magnoliopsida",
            genus: "Monstera",
            order: "Alismatales",
            family: "Araceae",
            phylum: "Tracheophyta",
            kingdom: "Plantae"
        )
        
        let description = Description(
            value: "Monstera deliciosa, the Swiss cheese plant or split-leaf philodendron is a species of flowering plant native to tropical forests of southern Mexico, south to Panama. It has been introduced to many tropical areas, and has become a mildly invasive species in Hawaii, Seychelles, Ascension Island and the Society Islands.",
            citation: "Wikipedia",
            licenseName: "CC BY-SA 3.0",
            licenseUrl: "https://creativecommons.org/licenses/by-sa/3.0/"
        )
        
        let plantImage = PlantImage(
            value: "https://example.com/monstera.jpg",
            citation: "Plant Database",
            licenseName: "CC BY 4.0",
            licenseUrl: "https://creativecommons.org/licenses/by/4.0/"
        )
        
        let plantDetails = PlantDetails(
            commonNames: ["Swiss Cheese Plant", "Split-leaf Philodendron"],
            taxonomy: taxonomy,
            url: "https://en.wikipedia.org/wiki/Monstera_deliciosa",
            gbifId: 2870200,
            inaturalistId: 128522,
            rank: "species",
            description: description,
            synonyms: ["Philodendron pertusum", "Tornelia fragrans"],
            image: plantImage,
            edibleParts: ["fruit"],
            watering: "Medium",
            bestLightCondition: "This plant thrives in medium to bright indirect light. It can tolerate lower light conditions, but growth may slow. Avoid direct sunlight as it can burn the leaves.",
            bestSoilType: "Well-draining potting mix rich in organic matter. A mix designed for aroids or a regular potting soil with added perlite, orchid bark, and/or coco coir works well.",
            commonUses: "Commonly used as an indoor ornamental plant, prized for its dramatic, perforated leaves and tropical appearance.",
            culturalSignificance: "In some tropical regions, the fruit is used in traditional cuisine. The plant has become a popular design element in modern interior decor.",
            toxicity: "The leaves and stems contain calcium oxalate crystals that are toxic to pets and can cause irritation if ingested. Keep away from cats, dogs, and small children.",
            bestWatering: "Allow the top 1-2 inches of soil to dry out between waterings. Water thoroughly when needed, but ensure the plant is not sitting in water. Reduce watering in winter."
        )
        
        let similarImage1 = SimilarImage(
            id: "img1",
            url: "https://example.com/similar1.jpg",
            licenseName: "CC BY 4.0",
            licenseUrl: "https://creativecommons.org/licenses/by/4.0/",
            citation: "Plant DB",
            similarity: 0.92,
            urlSmall: "https://example.com/similar1_small.jpg"
        )
        
        let similarImage2 = SimilarImage(
            id: "img2",
            url: "https://example.com/similar2.jpg",
            licenseName: "CC BY 4.0",
            licenseUrl: "https://creativecommons.org/licenses/by/4.0/",
            citation: "Plant DB",
            similarity: 0.87,
            urlSmall: "https://example.com/similar2_small.jpg"
        )
        
        let plantSuggestion = PlantSuggestion(
            id: "plant123",
            name: "Monstera deliciosa",
            probability: 0.98,
            similarImages: [similarImage1, similarImage2],
            details: plantDetails
        )
        
        let classification = Classification(suggestions: [plantSuggestion])
        
        let isPlant = IsPlant(
            probability: 0.99,
            threshold: 0.5,
            binary: true
        )
        
        let result = PlantIdentificationResult(
            classification: classification,
            isPlant: isPlant
        )
        
        let input = PlantIdentificationInput(
            latitude: 49.207,
            longitude: 16.608,
            similarImages: true,
            images: ["base64_encoded_image"],
            datetime: "2025-04-26T10:30:00.000Z"
        )
        
        return PlantIdentificationResponse(
            accessToken: "dummy_token",
            modelVersion: "plant_id:5.0.0",
            customId: nil,
            input: input,
            result: result,
            status: "COMPLETED",
            slaCompliantClient: true,
            slaCompliantSystem: true,
            created: 1745468220.564997,
            completed: 1745468220.808081
        )
    }
    
    // Dummy image for previews
    static var dummyPlantImage: UIImage {
        UIImage(imageLiteralResourceName: "monstera")
    }
    
    // Mock router for previews if needed
    static var mockRouter: () -> Void {
        return {}
    }
}
