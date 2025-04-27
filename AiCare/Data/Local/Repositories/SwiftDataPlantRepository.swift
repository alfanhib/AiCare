//
//  SwiftDataPlantRepository.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation
import SwiftData

@MainActor
class SwiftDataPlantRepository: PlantRepositoryProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getAllPlants() async throws -> [Plant] {
        let descriptor = FetchDescriptor<Plant>(sortBy: [SortDescriptor(\.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func getPlantsByRoom(roomId: String) async throws -> [Plant] {
        let predicate = #Predicate<Plant> { plant in
            plant.room?.id == roomId
        }
        let descriptor = FetchDescriptor<Plant>(predicate: predicate, sortBy: [SortDescriptor(\.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func getPlant(id: String) async throws -> Plant? {
        let predicate = #Predicate<Plant> { plant in
            plant.id == id
        }
        let descriptor = FetchDescriptor<Plant>(predicate: predicate)
        let plants = try modelContext.fetch(descriptor)
        return plants.first
    }
    
    func addPlant(_ plant: Plant) async throws {
        modelContext.insert(plant)
        try modelContext.save()
    }
    
    func updatePlant(_ plant: Plant) async throws {
        try modelContext.save()
    }
    
    func deletePlant(id: String) async throws {
        guard let plant = try await getPlant(id: id) else {
            return
        }
        modelContext.delete(plant)
        try modelContext.save()
    }
    
    func searchPlants(query: String) async throws -> [Plant] {
        let predicate = #Predicate<Plant> { plant in
            plant.name.localizedStandardContains(query) ||
            (plant.scientificName?.localizedStandardContains(query) ?? false)
        }
        let descriptor = FetchDescriptor<Plant>(predicate: predicate, sortBy: [SortDescriptor(\.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func getFavoritePlants() async throws -> [Plant] {
        let predicate = #Predicate<Plant> { plant in
            plant.isFavorite == true
        }
        let descriptor = FetchDescriptor<Plant>(predicate: predicate, sortBy: [SortDescriptor(\.name)])
        return try modelContext.fetch(descriptor)
    }
}
