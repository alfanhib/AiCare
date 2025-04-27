//
//  CareScheduleModel.swift
//  AiCare
//
//  Created by Alfan on 27/04/25.
//

import Foundation
import SwiftData

@Model
final class CareSchedule {
    var id: String
    var title: String
    var careDesc: String?
    var dueDate: Date
    var isCompleted: Bool
    var taskType: String // watering, fertilizing, repotting, etc.
    var dateAdded: Date
    var reminderEnabled: Bool
    
    // Relationship
    @Relationship var plant: Plant?
    
    init(id: String = UUID().uuidString,
         title: String,
         careDesc: String? = nil,
         dueDate: Date,
         isCompleted: Bool = false,
         taskType: String,
         dateAdded: Date = Date(),
         reminderEnabled: Bool = true,
         plant: Plant? = nil) {
        self.id = id
        self.title = title
        self.careDesc = careDesc
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.taskType = taskType
        self.dateAdded = dateAdded
        self.reminderEnabled = reminderEnabled
        self.plant = plant
    }
}
