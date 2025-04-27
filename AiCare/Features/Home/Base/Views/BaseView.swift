//
//  BaseView.swift
//  AiCare
//
//  Created by Alfan on 22/04/25.
//

import SwiftUI

struct BaseView: View {
    
    @Injected(\.router) var router
    
    @StateObject var viewModel = BaseViewModel()
    
    let initialTab: DashboardTabType
    
    init(initalTab: DashboardTabType = .Plant) {
        self.initialTab = initalTab
        UITableView.appearance().isHidden = true
    }
    
    static let color0 = Color(red: 62/255, green: 181/255, blue: 116/255);
    
    static let color1 = Color(red: 255/255, green: 255/255, blue: 255/255);
    
    let gradient = Gradient(colors: [color0, color1]);
    
    var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.currentTab){
                PlantsView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Color.softGreen.opacity(0.3)
                    )
                    .tag(DashboardTabType.Plant)
                
                RoomsView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.softGreen.opacity(0.3))
                    .tag(DashboardTabType.Rooms)
                
                Text("Calendar")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.softGreen.opacity(0.3))
                    .tag(DashboardTabType.Calendar)
                
                Text("Expert")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.softGreen.opacity(0.3))
                    .tag(DashboardTabType.Expert)
            }
            .overlay(
                HStack(spacing: 0){
                    TabButton(tab: .Plant)
                    TabButton(tab: .Rooms)
                    Button {
                        router.navigateToIdentify()
                    } label: {
                        Image(systemName: "dot.viewfinder")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26, height: 26)
                            .foregroundStyle(Color.white)
                            .offset(x: -1)
                            .padding()
                            .background(Color.softGreen)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.04), radius: 5, x: 5, y: 5)
                            .shadow(color: .black.opacity(0.04), radius: 5, x: -5, y: -5)
                    }
                    .offset(y: -24)

                    TabButton(tab: .Calendar)
                    TabButton(tab: .Expert)
                }
                    .background(
                        Color.white
                            .clipShape(UICustomCurvedShape())
                            .shadow(color: .black.opacity(0.04), radius: 5, x: -5, y: -5)
                            .ignoresSafeArea()
                    )
                , alignment: .bottom
            )
        }
        .onAppear {
            viewModel.updateSelectedTab(initialTab)
        }
    }
    
    @ViewBuilder
    func TabButton(tab: DashboardTabType) -> some View {
        Button {
            withAnimation {
                viewModel.currentTab = tab
            }
        } label: {
            VStack {
                getImageTabe(tab: tab)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundStyle(
                        viewModel.currentTab == tab ?
                        AnyShapeStyle(
                            Color.softGreen
                        ) :
                            AnyShapeStyle(Color.eerieBlack.opacity(0.5))
                    )
                    .frame(maxWidth: .infinity)
                Text(tab.rawValue)
                    .font(.caption)
                    .foregroundStyle(viewModel.currentTab == tab ? Color.softGreen : Color.eerieBlack.opacity(0.5))
            }
        }
    }
    
    func getImageTabe(tab: DashboardTabType) -> Image {
        switch tab {
        case .Plant:
            return Image(systemName: "tree")
        case .Rooms:
            return Image(systemName: "bed.double")
        case .Scan:
            return Image(systemName: "dot.viewfinder")
        case .Calendar:
            return Image(systemName: "calendar")
        case .Expert:
            return Image(systemName: "message.badge")
        }
    }
}

#Preview {
    BaseView()
}
