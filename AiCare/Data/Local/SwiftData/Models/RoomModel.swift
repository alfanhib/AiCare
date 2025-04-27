//
//  RoomModel.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation
import SwiftData

@Model
final class Room {
    var id: String
    var name: String
    var roomDesc: String?
    var iconName: String?
    var dateAdded: Date
    
    // Relationships
    @Relationship(deleteRule: .nullify) var plants: [Plant]?
    
    init(id: String = UUID().uuidString,
         name: String,
         roomDesc: String? = nil,
         iconName: String? = nil,
         dateAdded: Date = Date()) {
        self.id = id
        self.name = name
        self.roomDesc = roomDesc
        self.iconName = iconName
        self.dateAdded = dateAdded
    }
}
