//
//  RouteView.swift
//  AiCare
//
//  Created by Alfan on 25/04/25.
//
import SwiftUI

struct RouteView: View {
    @Injected(\.router)
    var router: Router<AppRoute>
    
    var body: some View {
        RouteProvider(router.self) { route in
            switch route {
            case .home(let tab):
                BaseView(initalTab: tab)
            case .plantDetail(let id):
                PlantDetailView(plantId: id)
            case .plantIdentify:
                PlantIdentifierView()
            default:
                Text("Unknown Route")
            }
        }
    }
}
