//
//  Router.swift
//  AiCare
//
//  Created by Alfan on 25/04/25.
//

import Foundation
import SwiftUI
import Combine
import UIKit

public final class Router<T: Equatable>: ObservableObject {
    @Published private var _routes: [T] = []
    public var routes: [T] {
        return _routes
    }
    
    public var onMakeRoot: ((T, Bool) -> Void)?
    public var onPush: ((T, Bool) -> Void)?
    public var onPopLast: ((Int, Bool) -> Void)?
    public var onPopToRoot: ((Int?, Bool) -> Void)?
    
    public init(initial: T? = nil) {
        if let initial = initial {
            push(initial)
        }
    }
    
    public func makeRoot(_ route: T, animated: Bool = true) {
        _routes = [route]
        onMakeRoot?(route, animated)
    }
    
    public func push(_ route: T, animated: Bool = true) {
        _routes.append(route)
        onPush?(route, animated)
    }
    
    public func pop(animated: Bool = true) {
        guard !_routes.isEmpty else { return }
        print("ini jalan \(_routes)")
        _routes.removeLast()
        onPopLast?(1, animated)
    }
    
    public func popTo(_ route: T, inclusive: Bool = false, animated: Bool = true) {
        guard var found = _routes.lastIndex(where: { $0 == route }) else { return }
        
        if !inclusive {
            found += 1
        }
        
        let numToPop = (_routes.count - found)
        _routes.removeLast(numToPop)
        onPopLast?(numToPop, animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        guard _routes.count > 1 else { return }
        _routes.removeSubrange(1..._routes.count - 1)
        onPopToRoot?(nil, animated)
    }
    
    public func onSystemPop() {
        guard !_routes.isEmpty else { return }
        _routes.removeLast()
    }
}

