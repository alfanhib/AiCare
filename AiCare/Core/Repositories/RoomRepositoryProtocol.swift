//
//  RoomRepositoryProtocol.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation

protocol RoomRepositoryProtocol {
    func getAllRooms() async throws -> [Room]
    func getRoom(id: String) async throws -> Room?
    func addRoom(_ room: Room) async throws
    func updateRoom(_ room: Room) async throws
    func deleteRoom(id: String) async throws
}
