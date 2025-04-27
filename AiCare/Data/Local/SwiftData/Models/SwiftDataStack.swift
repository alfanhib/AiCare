//
//  SwiftDataStack.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//
import Foundation
import SwiftData

import Foundation
import SwiftData

@MainActor
class SwiftDataStack {
    static let shared = SwiftDataStack()
    
    private(set) var container: ModelContainer
    
    private init() {
        let schema = Schema([
            Plant.self,
            Room.self,
            CareSchedule.self,
            PlantDiagnosis.self
        ])
        
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        
        do {
            container = try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    var mainContext: ModelContext {
        return container.mainContext
    }
    
    func newContext() -> ModelContext {
        return ModelContext(container)
    }
    
    static func previewContainer() -> ModelContainer {
        let schema = Schema([
            Plant.self,
            Room.self,
            CareSchedule.self,
            PlantDiagnosis.self
        ])
        
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        
        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])
            
            // Add sample data for previews
            let previewContext = container.mainContext
            
            // Sample rooms
            let livingRoom = Room(name: "Ruang Tamu", iconName: "sofa")
            let bedroom = Room(name: "Kamar Tidur", iconName: "bed.double")
            
            // Sample plants
            let monstera = Plant(
                name: "Monstera",
                scientificName: "Monstera deliciosa",
                plantDesc: "Tanaman hias populer dengan daun berlubang yang indah",
                wateringFrequency: 7,
                sunlightRequirement: "Cahaya tidak langsung",
                soilType: "Tanah yang subur dan drainase baik",
                isFavorite: true
            )
            monstera.room = livingRoom
            
            let snake = Plant(
                name: "Lidah Mertua",
                scientificName: "Sansevieria trifasciata",
                plantDesc: "Tanaman yang mudah dirawat dan pembersih udara yang baik",
                wateringFrequency: 14,
                sunlightRequirement: "Cahaya rendah hingga sedang",
                soilType: "Tanah kaktus dengan drainase baik",
                isFavorite: false
            )
            snake.room = bedroom
            
            // Save to preview context
            previewContext.insert(livingRoom)
            previewContext.insert(bedroom)
            previewContext.insert(monstera)
            previewContext.insert(snake)
            
            return container
        } catch {
            fatalError("Failed to create preview ModelContainer: \(error)")
        }
    }
}
