//
//  InjectedValues.swift
//  AiCare
//
//  Created by Alfan on 23/04/25.
//

import Foundation

public protocol InjectedKey {
    associatedtype Value
    static var currentValue: Value { get set }
}

public struct InjectedValues {
    private static var current = InjectedValues()
    
    static subscript<K: InjectedKey>(_ key: K.Type) -> K.Value {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}
