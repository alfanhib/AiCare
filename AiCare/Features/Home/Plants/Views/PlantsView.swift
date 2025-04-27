//
//  HomeView.swift
//  AiCare
//
//  Created by Alfan on 22/04/25.
//

import SwiftUI

struct PlantsView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        // Badge Newbie
                        HStack {
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.white)
                            
                            Text("Newbie")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.softGreen)
                        .cornerRadius(30)
                        
                        Spacer()
                        
                        // Icon buttons
                        Button(action: {}) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                                .foregroundColor(Color.eerieBlack)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "bell.fill")
                                .font(.title2)
                                .foregroundColor(Color.eerieBlack)
                        }
                    }
                    .padding(.bottom)
                    .padding(.horizontal)
                    
                    // Cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            // Next Level Card
                            VStack(alignment: .leading, spacing: 10) {
                                // Trophy icon
                                Image(systemName: "trophy.fill")
                                    .font(.title)
                                    .foregroundColor(.yellow)
                                    .padding(12)
                                    .background(Color.green)
                                    .clipShape(Circle())
                                
                                Text("Next Level")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(.green)
                                
                                // Progress bar
                                ProgressBar(value: viewModel.nextLevelProgress(), color: .green)
                                
                                Text("Do \(viewModel.tasksToNextLevel) more tasks")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(width: geometry.size.width * 0.42, height: 180)
                            .background(Color.white)
                            .cornerRadius(15)
                            
                            // Daily Task Card
                            VStack(alignment: .leading, spacing: 10) {
                                // Clipboard icon
                                Image(systemName: "list.clipboard.fill")
                                    .font(.title)
                                    .foregroundColor(.yellow)
                                    .padding(12)
                                    .background(Color.green)
                                    .clipShape(Circle())
                                
                                Text("\(viewModel.taskCount) Daily Task")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(.green)
                                
                                // Progress bar
                                ProgressBar(value: viewModel.dailyTaskProgress(), color: .yellow)
                                
                                Text("\(viewModel.tasksCompleted)/\(viewModel.totalTasks) Completed")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(width: geometry.size.width * 0.42, height: 180)
                            .background(Color.white)
                            .cornerRadius(15)
                            
                            // Additional card can be added here
                            VStack(alignment: .leading, spacing: 10) {
                                Image(systemName: "leaf.fill")
                                    .font(.title)
                                    .foregroundColor(.yellow)
                                    .padding(12)
                                    .background(Color.green)
                                    .clipShape(Circle())
                                
                                Text("Plants")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(.green)
                                
                                Spacer()
                                
                                Text("All plants")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(width: geometry.size.width * 0.42, height: 180)
                            .background(Color.white)
                            .cornerRadius(15)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Find a plant", text: $searchText)
                            .onChange(of: searchText) { newValue in
                                viewModel.searchQuery = newValue
                            }
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                                viewModel.searchQuery = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct ProgressBar: View {
    var value: CGFloat
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 8)
                    .foregroundColor(color.opacity(0.3))
                    .cornerRadius(4)
                
                Rectangle()
                    .frame(width: min(CGFloat(value) * geometry.size.width, geometry.size.width), height: 8)
                    .foregroundColor(color)
                    .cornerRadius(4)
                    .animation(.linear, value: value)
            }
        }
        .frame(height: 8)
    }
}

#Preview {
    BaseView()
}
