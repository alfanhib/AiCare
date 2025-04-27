//
//  PlantRepositoryProtocol.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation

protocol PlantRepositoryProtocol {
    func getAllPlants() async throws -> [Plant]
    func getPlantsByRoom(roomId: String) async throws -> [Plant]
    func getPlant(id: String) async throws -> Plant?
    func addPlant(_ plant: Plant) async throws
    func updatePlant(_ plant: Plant) async throws
    func deletePlant(id: String) async throws
    func searchPlants(query: String) async throws -> [Plant]
    func getFavoritePlants() async throws -> [Plant]
}
