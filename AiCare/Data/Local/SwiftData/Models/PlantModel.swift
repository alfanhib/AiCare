//
//  PlantModel.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation
import SwiftData

@Model
final class Plant {
    var id: String
    var name: String
    var scientificName: String?
    var plantDesc: String?
    var imageURL: URL?
    var localImagePath: String?
    var careInstructions: String?
    var wateringFrequency: Int // dalam hari
    var sunlightRequirement: String?
    var soilType: String?
    var lastWatered: Date?
    var dateAdded: Date
    var isFavorite: Bool
    
    // Relationships
    @Relationship(deleteRule: .cascade) var schedules: [CareSchedule]?
    @Relationship var room: Room?
    
    init(id: String = UUID().uuidString,
         name: String,
         scientificName: String? = nil,
         plantDesc: String? = nil,
         imageURL: URL? = nil,
         localImagePath: String? = nil,
         careInstructions: String? = nil,
         wateringFrequency: Int = 7,
         sunlightRequirement: String? = nil,
         soilType: String? = nil,
         lastWatered: Date? = nil,
         dateAdded: Date = Date(),
         isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.scientificName = scientificName
        self.plantDesc = plantDesc
        self.imageURL = imageURL
        self.localImagePath = localImagePath
        self.careInstructions = careInstructions
        self.wateringFrequency = wateringFrequency
        self.sunlightRequirement = sunlightRequirement
        self.soilType = soilType
        self.lastWatered = lastWatered
        self.dateAdded = dateAdded
        self.isFavorite = isFavorite
        self.plantDesc = plantDesc
    }
}
