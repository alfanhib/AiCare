//
//  PlantScannerViewModel.swift
//  AiCare
//
//  Created by Alfan on 24/04/25.
//

//
//  PlantScannerViewModel.swift
//  AiCare
//
//  Created by Alfan on 24/04/25.
//

import Foundation
import SwiftUI
import AVFoundation
import Combine

class PlantIdentifierViewModel: NSObject, ObservableObject {
    
    // MARK: - Dependencies
    @Injected(\.plantIdentifyUseCase) var plantIdentifyUseCase: any PlantIdentifyUseCaseProtocol
    @Injected(\.addPlantUseCase) var addPlantUseCase: any AddPlantUseCaseProtocol
    
    enum ScanTab: String, CaseIterable {
        case plant = "Plant"
        case disease = "Disease"
        case potSize = "Pot Size"
        case health = "Health"
        
        var icon: String {
            switch self {
            case .plant: return "leaf.fill"
            case .disease: return "microbe.fill"
            case .potSize: return "square.stack.fill"
            case .health: return "heart.fill"
            }
        }
    }
    
    // MARK: - Published Properties
    @Published var capturedImage: UIImage?
    @Published var isCapturing = false
    @Published var plantResponse: PlantIdentificationResponse?
    @Published var isShowingResults = false
    @Published var navigateToPlantDetail = false
    @Published var selectedTab: ScanTab = .plant
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    private let captureSession = AVCaptureSession()
    private var photoOutput: AVCapturePhotoOutput?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    override init() {
        super.init()
        setupCaptureSession()
    }
    
    // MARK: - Camera Setup
    private func setupCaptureSession() {
        captureSession.sessionPreset = .photo
        
        guard let backCameraDevice = AVCaptureDevice.default(for: .video), let input = try? AVCaptureDeviceInput(device: backCameraDevice) else {
            errorMessage = "Tidak dapat mengakses kamera"
            return
        }
        
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        
        let photoOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
            self.photoOutput = photoOutput
        }
    }
    
    func startCaptureSession() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    func stopCaptureSession() {
        captureSession.stopRunning()
    }
    
    func capturePhoto() {
        isCapturing = true
        
        guard let photoOutput = photoOutput else {
            isCapturing = false
            errorMessage = "Tidak dapat mengambil foto"
            return
        }
        
        let settings = AVCapturePhotoSettings()
        
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    // MARK: - Plant Identification
    func identifyPlant() {
        guard let image = capturedImage else {
            errorMessage = "Tidak ada gambar yang dipilih"
            return
        }
        
        isLoading = true
        
        Task {
            do {
                let parameters = PlantIdentifyParameters(
                    image: image,
                    latitude: nil,  // Bisa diambil dari lokasi pengguna jika diizinkan
                    longitude: nil
                )
                
                let response = try await plantIdentifyUseCase.execute(with: parameters)
                
                await MainActor.run {
                    self.plantResponse = response
                    self.isShowingResults = true
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Gagal mengidentifikasi tanaman: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
    
    // MARK: - Saving Plant
    func savePlantToCollection(suggestion: PlantSuggestion) async throws {
        // Parse watering frequency
        var parsedWateringFrequency = 7 // Default 7 hari
        if let watering = suggestion.details.watering {
            if let maxWateringValue = watering.max {
                switch maxWateringValue {
                    case 1:
                    parsedWateringFrequency = 1
                case 2:
                    parsedWateringFrequency = 3
                case 3:
                    parsedWateringFrequency = 7
                case 4:
                    parsedWateringFrequency = 14
                default:
                    parsedWateringFrequency = 7
                }
            }
        }
        
        // Simpan gambar ke lokal
        let localImagePath = saveImageLocally(image: capturedImage)
        
        let newPlant = Plant(
            name: suggestion.name,
            scientificName: suggestion.name,
            plantDesc: suggestion.details.description?.value,
            imageURL: URL(string: suggestion.details.image?.value ?? ""),
            localImagePath: localImagePath,
            careInstructions: suggestion.details.bestWatering,
            wateringFrequency: parsedWateringFrequency,
            sunlightRequirement: suggestion.details.bestLightCondition,
            soilType: suggestion.details.bestSoilType
        )
        
        let parameters = AddPlantParameters(plant: newPlant)
        try await addPlantUseCase.execute(with: parameters)
        
        await MainActor.run {
            self.navigateToPlantDetail = true
        }
    }
    
    // MARK: - Utilities
    func resetCapture() {
        isShowingResults = false
        plantResponse = nil
        capturedImage = nil
    }
    
    private func saveImageLocally(image: UIImage?) -> String? {
        guard let image = image else { return nil }
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = image.jpegData(compressionQuality: 0.8) {
            do {
                try data.write(to: fileURL)
                return fileURL.path
            } catch {
                print("Error saving image: \(error)")
                return nil
            }
        }
        return nil
    }
    
    // MARK: - Getters
    var captureSession_: AVCaptureSession {
        return captureSession
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension PlantIdentifierViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        isCapturing = false
        
        if let error = error {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = "Gagal mengambil foto: \(error.localizedDescription)"
            }
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = "Gagal memproses foto"
            }
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.capturedImage = image
            print("isi image \(image)")
            self?.identifyPlant()
        }
    }
}
