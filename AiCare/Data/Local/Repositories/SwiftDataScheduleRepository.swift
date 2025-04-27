//
//  SwiftDataScheduleRepository.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation
import SwiftData
import Foundation
import SwiftData

@MainActor
class SwiftDataScheduleRepository: ScheduleRepositoryProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getAllSchedules() async throws -> [CareSchedule] {
        let descriptor = FetchDescriptor<CareSchedule>(sortBy: [SortDescriptor(\.dueDate)])
        return try modelContext.fetch(descriptor)
    }
    
    func getSchedulesByPlant(plantId: String) async throws -> [CareSchedule] {
        let predicate = #Predicate<CareSchedule> { schedule in
            schedule.plant?.id == plantId
        }
        let descriptor = FetchDescriptor<CareSchedule>(predicate: predicate, sortBy: [SortDescriptor(\.dueDate)])
        return try modelContext.fetch(descriptor)
    }
    
    func getSchedulesByDateRange(start: Date, end: Date) async throws -> [CareSchedule] {
        let predicate = #Predicate<CareSchedule> { schedule in
            schedule.dueDate >= start && schedule.dueDate <= end
        }
        let descriptor = FetchDescriptor<CareSchedule>(predicate: predicate, sortBy: [SortDescriptor(\.dueDate)])
        return try modelContext.fetch(descriptor)
    }
    
    func getSchedule(id: String) async throws -> CareSchedule? {
        let predicate = #Predicate<CareSchedule> { schedule in
            schedule.id == id
        }
        let descriptor = FetchDescriptor<CareSchedule>(predicate: predicate)
        let schedules = try modelContext.fetch(descriptor)
        return schedules.first
    }
    
    func addSchedule(_ schedule: CareSchedule) async throws {
        modelContext.insert(schedule)
        try modelContext.save()
    }
    
    func updateSchedule(_ schedule: CareSchedule) async throws {
        try modelContext.save()
    }
    
    func deleteSchedule(id: String) async throws {
        guard let schedule = try await getSchedule(id: id) else {
            return
        }
        modelContext.delete(schedule)
        try modelContext.save()
    }
    
    func markScheduleAsCompleted(id: String, completedDate: Date) async throws {
        guard let schedule = try await getSchedule(id: id) else {
            return
        }
        schedule.isCompleted = true
        try modelContext.save()
    }
}
