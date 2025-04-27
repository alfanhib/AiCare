//
//  PlantIdentifierView.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//

import SwiftUI
import AVFoundation
import Vision

struct PlantIdentifierView: View {
    
    @Injected(\.router) var router: Router<AppRoute>
    @StateObject private var viewModel = PlantIdentifierViewModel()
    
    var body: some View {
        ZStack {
            Color.eerieBlack.ignoresSafeArea()
            
            cameraView
            
            if viewModel.isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                    
                    Text("Identify Plant...")
                        .foregroundStyle(Color.white)
                        .padding(.top)
                }
            }

        }
    }
    
    private var cameraView: some View {
        VStack {
            HStack {
                Button(action: {
                    router.pop()
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(Color.black)
                        }
                }
                .padding(.leading, 20)
                Spacer()
            }
            .padding(.top, 20)
            
            ZStack {
                CameraPreviewView(session: viewModel.captureSession_)
                
                
                    
                
                VStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                        
                        
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: 2)
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack(spacing: 20) {
                            ForEach(PlantIdentifierViewModel.ScanTab.allCases, id: \.self) { tab in
                                VStack {
                                    Circle()
                                        .fill(viewModel.selectedTab == tab ? Color.white : Color.white.opacity(0.6))
                                        .frame(width: 60, height: 60)
                                        .overlay(
                                            Image(systemName: tab.icon)
                                        )
                                        .onTapGesture {
                                            viewModel.selectedTab = tab
                                        }
                                    
                                    Text(tab.rawValue)
                                        .foregroundStyle(Color.white)
                                        .font(.system(size: 12))
                                }
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        
                        HStack {
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                        Image(systemName: "photo")
                                            .foregroundStyle(Color.white)
                                    }
                            }
                            
                            Spacer()

                            Button {
                                viewModel.capturePhoto()
                            } label: {
                                Circle()
                                    .strokeBorder(Color.white, lineWidth: 3)
                                    .frame(width: 70, height: 70)
                                    .background(
                                        Circle()
                                            .fill(Color.orange)
                                            .frame(width: 60, height: 60)
                                    )
                            }
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                        Image(systemName: "gear")
                                            .foregroundStyle(Color.white)
                                    }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom)
                    }
                    .background(
                        Rectangle()
                            .fill(Color.black.opacity(0.7))
                            .ignoresSafeArea()
                    )
                }
            }
        }
    }
    
}

struct CameraPreviewView: UIViewRepresentable {
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        
        let view = UIView(frame: .zero)
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}


#Preview {
    PlantIdentifierView()
}
