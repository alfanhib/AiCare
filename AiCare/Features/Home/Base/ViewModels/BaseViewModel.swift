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
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func showError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = error.localizedDescription
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
        }
    }
    
    deinit {
    }
    
}

enum DashboardTabType: String {
    case Plant = "Plant"
    case Rooms = "Rooms"
    case Scan = "Scan"
    case Calendar = "Calendar"
    case Expert = "Expert"
}
