//
//  SwiftDataRoomRepository.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation
import SwiftData

@MainActor
class SwiftDataRoomRepository: RoomRepositoryProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getAllRooms() async throws -> [Room] {
        let descriptor = FetchDescriptor<Room>(sortBy: [SortDescriptor(\.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func getRoom(id: String) async throws -> Room? {
        let predicate = #Predicate<Room> { room in
            room.id == id
        }
        let descriptor = FetchDescriptor<Room>(predicate: predicate)
        let rooms = try modelContext.fetch(descriptor)
        return rooms.first
    }
    
    func addRoom(_ room: Room) async throws {
        modelContext.insert(room)
        try modelContext.save()
    }
    
    func updateRoom(_ room: Room) async throws {
        try modelContext.save()
    }
    
    func deleteRoom(id: String) async throws {
        guard let room = try await getRoom(id: id) else {
            return
        }
        modelContext.delete(room)
        try modelContext.save()
    }
}
