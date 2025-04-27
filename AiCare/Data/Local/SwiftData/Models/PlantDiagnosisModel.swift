//
//  PlantDiagnosisModel.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation
import SwiftData

@Model
final class PlantDiagnosis {
    var id: String
    var diagnosisDate: Date
    var issue: String
    var solution: String?
    var imageURL: URL?
    var localImagePath: String?
    var notes: String?
    
    // Relationship
    @Relationship var plant: Plant?
    
    init(id: String = UUID().uuidString,
         diagnosisDate: Date = Date(),
         issue: String,
         solution: String? = nil,
         imageURL: URL? = nil,
         localImagePath: String? = nil,
         notes: String? = nil,
         plant: Plant? = nil) {
        self.id = id
        self.diagnosisDate = diagnosisDate
        self.issue = issue
        self.solution = solution
        self.imageURL = imageURL
        self.localImagePath = localImagePath
        self.notes = notes
        self.plant = plant
    }
}
