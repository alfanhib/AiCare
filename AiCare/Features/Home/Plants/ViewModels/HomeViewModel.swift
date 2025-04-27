//
//  HomeViewModel.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: BaseViewModel {
    // Published properties untuk UI
    @Published var username: String = "Newbie"
    @Published var userLevel: String = "Newbie"
    @Published var taskCount: Int = 1
    @Published var tasksCompleted: Int = 5
    @Published var totalTasks: Int = 6
    @Published var tasksToNextLevel: Int = 5
    @Published var searchQuery: String = ""
    @Published var showCongratulations: Bool = true
    
    // Private properties
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        setupBindings()
        fetchUserData()
    }
    
    private func setupBindings() {
        // Contoh binding jika ada
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] query in
                if !query.isEmpty {
                    self?.searchPlants(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    
    /// Mengambil data pengguna dari repository
    func fetchUserData() {
        // Di implementasi nyata, ini akan memanggil repository atau service
        // Untuk demo, kita gunakan data statis
        
        // Simulasi network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.username = "Newbie"
            self?.userLevel = "Newbie"
            self?.taskCount = 1
            self?.tasksCompleted = 5
            self?.totalTasks = 6
            self?.tasksToNextLevel = 5
        }
    }
    
    /// Mencari tanaman berdasarkan query
    func searchPlants(query: String) {
        // Implementasi pencarian tanaman
        print("Searching for plants: \(query)")
        // Akan terhubung ke repository untuk mendapatkan data tanaman
    }
    
    /// Menandai tugas sebagai selesai
    func completeTask(taskId: String) {
        // Implementasi untuk menyelesaikan tugas
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Hanya untuk demo - tingkatkan jumlah tugas yang diselesaikan
            if self.tasksCompleted < self.totalTasks {
                self.tasksCompleted += 1
                
                // Periksa apakah sudah mencapai target level
                if self.tasksCompleted >= self.totalTasks {
                    self.showCongratulationMessage()
                }
            }
        }
    }
    
    /// Menampilkan pesan selamat ketika target tercapai
    private func showCongratulationMessage() {
        self.showCongratulations = true
        
        // Sembunyikan setelah beberapa detik
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.showCongratulations = false
        }
    }
    
    /// Menghitung kemajuan untuk next level (0.0 - 1.0)
    func nextLevelProgress() -> CGFloat {
        let currentTasks = max(0, tasksToNextLevel - tasksCompleted)
        return CGFloat(1.0 - (Double(currentTasks) / Double(tasksToNextLevel)))
    }
    
    /// Menghitung kemajuan untuk tugas harian (0.0 - 1.0)
    func dailyTaskProgress() -> CGFloat {
        return CGFloat(Double(tasksCompleted) / Double(totalTasks))
    }
}
