//
//  RootView.swift
//  AiCare
//
//  Created by Alfan on 25/04/25.
//
import SwiftUI

struct RootView: View {
    @StateObject
    var viewModel: RootViewModel
    
    public init() {
        _viewModel = StateObject(
            wrappedValue: RootViewModel()
        )
    }
    
    public var body: some View {
        
        switch viewModel.state.viewState {
            case .launchScreen:
            SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            viewModel.send(.onLoad)
                        }
                    }
            case .loaded:
                RouteView()
        }
    }
}
