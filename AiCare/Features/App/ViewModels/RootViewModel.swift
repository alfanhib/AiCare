//
//  RootViewModel.swift
//  AiCare
//
//  Created by Alfan on 25/04/25.
//

import Foundation

public final class RootViewModel: ObservableObject {
    @Published
    private(set) var state = State()
    
    @Injected(\.router)
    var router: Router<AppRoute>
    
    @MainActor
    func send(_ action: Action) {
        switch action {
        case .onCompleteLaunch:
            state.didFinishLaunch = true
        case .onLoad:
            state.didFinishLaunch = true
            state.viewState = .loaded
            router.push(.home(tab: .Plant))
        }
    }
    
    enum Action {
        case onLoad
        case onCompleteLaunch
    }
    
    enum ViewState: Equatable {
        case launchScreen
        case loaded
    }
    
    struct State: Equatable {
        var viewState = ViewState.launchScreen
        
        var didFinishLaunch = false
    }
}
