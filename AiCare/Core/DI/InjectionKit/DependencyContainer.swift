//
//  DependencyContainer.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//


import Foundation

class DependencyContainer {
    private init() {}
    
    static func register() {
        Task {
            await registerServices()
            await registerRepositories()
            
        }
    }
    
    private static func registerServices() {
    }
    
    @MainActor
    private static func registerRepositories() {
        let modelContext = SwiftDataStack.shared.mainContext
        
        InjectedValues[\.plantRepository] = SwiftDataPlantRepository(modelContext: modelContext)
        InjectedValues[\.roomRepository] = SwiftDataRoomRepository(modelContext: modelContext)
        InjectedValues[\.scheduleRepository] = SwiftDataScheduleRepository(modelContext: modelContext)
    }
    
}
