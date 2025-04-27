//
//  PlantScannerViewModel.swift
//  AiCare
//
//  Created by Alfan on 24/04/25.
//

import Foundation
import SwiftUI
import AVFoundation



class PlantIdentifierViewModel: NSObject, ObservableObject {
    
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
    
    @Published var capturedImage: UIImage?
    @Published var isCapturing = false
    @Published var plantResponse: PlantIdentificationResponse?
    @Published var isShowingResults = false
    @Published var navigateToPlantDetail = false
    @Published var selectedTab: ScanTab = .plant
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    
    private let captureSession = AVCaptureSession()
    private var photoOutput: AVCapturePhotoOutput?
    
    
    
    override init() {
        super.init()
        setupCaptureSession()
    }
    
    private func setupCaptureSession() {
        captureSession.sessionPreset = .photo
        
        guard let backCameraDevice = AVCaptureDevice.default(for: .video), let input = try? AVCaptureDeviceInput(device: backCameraDevice) else {
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
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
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
            return
        }
        
        let settings = AVCapturePhotoSettings()
        
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func setCapturedImage(_ image: UIImage) {
        self.capturedImage = image
        identifyPlant()
    }
    
    func identifyPlant() {
        guard let image = capturedImage else {
            return
        }
        
        isShowingResults = true
        
        Task {
            do {
                await MainActor.run {
                }
            } catch {
                await MainActor.run {
                }
            }
        }
    }
    
    func resetCapture() {
        isShowingResults = false
        plantResponse = nil
        capturedImage = nil
    }
    
    var captureSession_: AVCaptureSession {
        return captureSession
    }
}

extension PlantIdentifierViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        isCapturing = false
        
        if let error = error {
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.capturedImage = image
        }
    }
}
