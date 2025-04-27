//
//  ScheduleRepositoryProtocol.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation

protocol ScheduleRepositoryProtocol {
    func getAllSchedules() async throws -> [CareSchedule]
    func getSchedulesByPlant(plantId: String) async throws -> [CareSchedule]
    func getSchedulesByDateRange(start: Date, end: Date) async throws -> [CareSchedule]
    func getSchedule(id: String) async throws -> CareSchedule?
    func addSchedule(_ schedule: CareSchedule) async throws
    func updateSchedule(_ schedule: CareSchedule) async throws
    func deleteSchedule(id: String) async throws
    func markScheduleAsCompleted(id: String, completedDate: Date) async throws
}
