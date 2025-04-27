//
//  BaseViewModel.swift
//  AiCare
//
//  Created by Alfan on 22/04/25.
//

import Foundation
import SwiftUI

class BaseViewModel: ObservableObject {
    
    @Published var currentTab: DashboardTabType = .Plant
    
    func updateSelectedTab(_ tab: DashboardTabType) {
        currentTab = tab
    }
    
}

enum DashboardTabType: String {
    case Plant = "Plant"
    case Rooms = "Rooms"
    case Scan = "Scan"
    case Calendar = "Calendar"
    case Expert = "Expert"
}
