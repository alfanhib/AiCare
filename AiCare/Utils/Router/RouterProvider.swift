//
//  RouterProvider.swift
//  AiCare
//
//  Created by Alfan on 25/04/25.
//
import Foundation
import SwiftUI

struct RouteProvider<T: Equatable, Screen: View>: View {
    @ObservedObject private var router: Router<T>
    
    @ViewBuilder
    private let routeMap: (T) -> Screen
    
    init(_ router: Router<T>, @ViewBuilder _ routeMap: @escaping (T) -> Screen) {
        self.router = router
        self.routeMap = routeMap
    }
    
    var body: some View {
        NavigationControllerHost(
            router: router,
            routeMap: routeMap
        )
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct NavigationControllerHost<T: Equatable, Screen: View>: UIViewControllerRepresentable {
    let router: Router<T>
    
    @ViewBuilder
    var routeMap: (T) -> Screen
    
    func makeUIViewController(context _: Context) -> UINavigationController {
        let navigation = PopAwareUINavigationController()
        navigation.navigationBar.isHidden = true
        
        navigation.popHandler = {
            router.onSystemPop()
        }
        navigation.stackSizeProvider = {
            router.routes.count
        }
        
        router.onPush = { route, animated in
            navigation.pushViewController(
                UIHostingController(rootView: routeMap(route)), animated: animated
            )
        }
        
        router.onPopLast = { count, animated in
            let viewControllers = navigation.viewControllers
            guard count <= viewControllers.count else { return }
            
            let popTo = viewControllers[viewControllers.count - count - 1]
            navigation.popToViewController(popTo, animated: animated)
        }
        
        router.onMakeRoot = { route, animated in
            let vc = UIHostingController(rootView: routeMap(route))
            navigation.setViewControllers([vc], animated: animated)
        }
        
        for path in router.routes {
            navigation.pushViewController(
                UIHostingController(rootView: routeMap(path)), animated: false
            )
        }
        
        return navigation
    }
    
    func updateUIViewController(_ navigation: UINavigationController, context _: Context) {
        navigation.navigationBar.isHidden = true
    }
}

