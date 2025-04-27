//
//  PlantDetailView.swift
//  AiCare
//
//  Created by Alfan on 26/04/25.
//

import SwiftUI

struct PlantDetailView: View {
    
    let plantId: String
    
    let plantResponse: PlantIdentificationResponse = PreviewPlantDetailData.createDummyPlantResponse()
    let capturedImage: UIImage = PreviewPlantDetailData.dummyPlantImage
    @Injected(\.router) private var router
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Button {
                        router.navigateToHome()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    
                    Text("Plant Details")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                            .foregroundStyle(Color.black)
                    }
                }
                .padding()
                
                Image(uiImage: capturedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                
                if let firstSuggestion = plantResponse.result.classification.suggestions.first {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(firstSuggestion.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        if let commonNames = firstSuggestion.details.commonNames, !commonNames.isEmpty {
                            Text(commonNames.joined(separator: ", "))
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                        
                        Text("Confidence: \(Int(firstSuggestion.probability * 100)) %")
                            .font(.headline)
                            .foregroundStyle(Color.green)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Details")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        if let desc = firstSuggestion.details.description?.value, !desc.isEmpty {
                            Text(desc)
                                .font(.body)
                                .foregroundStyle(Color.secondary)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Plant Care")
                                .font(.headline)
                            
                            if let light = firstSuggestion.details.bestLightCondition {
                                careInfoRow(icon: "sun.max.fill", iconColor: .yellow, title: "Light", description: light)
                            }
                            
                            if let water = firstSuggestion.details.bestWatering {
                                careInfoRow(icon: "drop.fill", iconColor: .blue, title: "Watering", description: water)
                            }
                            
                            if let soil = firstSuggestion.details.bestSoilType {
                                careInfoRow(icon: "leaf.fill", iconColor: .green, title: "Soil", description: soil)
                            }
                            
                            if let toxicity = firstSuggestion.details.toxicity {
                                careInfoRow(icon: "exclamationmark.triangle.fill", iconColor: .red, title: "Toxicity", description: toxicity)
                            }
                        }
                        
                        if let similarImages = firstSuggestion.similarImages, !similarImages.isEmpty {
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Similar Plants")
                                    .font(.headline)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(similarImages, id: \.id) { image in
                                            AsyncImage(url: URL(string: image.url)) { phase in
                                                switch phase {
                                                case .empty:
                                                    Rectangle()
                                                        .fill(Color.gray.opacity(0.2))
                                                        .frame(width: 100, height: 100)
                                                        .cornerRadius(8)
                                                        .overlay(ProgressView())
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 100, height: 100)
                                                        .cornerRadius(8)
                                                case .failure:
                                                    Rectangle()
                                                        .fill(Color.gray.opacity(0.2))
                                                        .frame(width: 100, height: 100)
                                                        .cornerRadius(8)
                                                        .overlay(
                                                            Image(systemName: "photo")
                                                                .foregroundColor(.gray)
                                                        )
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private func taxonomyRow(label: String, value: String?) -> some View {
        HStack {
            Text(label)
                .fontWeight(.medium)
                .frame(width: 80, alignment: .leading)
            
            Text(value ?? "Unknown")
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
    
    private func careInfoRow(icon: String, iconColor: Color, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(iconColor)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    PlantDetailView(plantId: "123")
}
