//
//  RepositoryInjection.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//
import Foundation
import SwiftData

@MainActor
struct PlantRepositoryKey: InjectedKey {
    static var currentValue: PlantRepositoryProtocol = SwiftDataPlantRepository(modelContext: SwiftDataStack.shared.mainContext)
}

@MainActor
struct RoomRepositoryKey: InjectedKey {
    static var currentValue: RoomRepositoryProtocol = SwiftDataRoomRepository(modelContext: SwiftDataStack.shared.mainContext)
}

@MainActor
struct ScheduleRepositoryKey: InjectedKey {
    static var currentValue: ScheduleRepositoryProtocol = SwiftDataScheduleRepository(modelContext: SwiftDataStack.shared.mainContext)
}

extension InjectedValues {
    var plantRepository: PlantRepositoryProtocol {
        get { Self[PlantRepositoryKey.self] }
        set { Self[PlantRepositoryKey.self] = newValue }
    }
    
    var roomRepository: RoomRepositoryProtocol {
        get { Self[RoomRepositoryKey.self] }
        set { Self[RoomRepositoryKey.self] = newValue }
    }
    
    var scheduleRepository: ScheduleRepositoryProtocol {
        get { Self[ScheduleRepositoryKey.self] }
        set { Self[ScheduleRepositoryKey.self] = newValue }
    }
}
