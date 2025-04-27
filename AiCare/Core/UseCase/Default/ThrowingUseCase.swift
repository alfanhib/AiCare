//
//  ThrowingUseCase.swift
//  AiCare
//
//  Created by Alfan on 26/04/25.
//

import Foundation

import Foundation

public protocol UseCase {
    associatedtype ParameterType
    associatedtype ResultType

    func execute(with parameters: ParameterType) async -> ResultType
}

extension UseCase where ParameterType == Void {
    func execute() async -> ResultType {
        await execute(with: ())
    }
}

struct AnyUseCase<R, P>: UseCase {
    private let execution: (P) async -> R

    init<WrappedUseCase: UseCase>(
        _ wrappedUseCase: WrappedUseCase
    ) where WrappedUseCase.ResultType == R, WrappedUseCase.ParameterType == P {
        execution = wrappedUseCase.execute
    }

    func execute(with parameters: P) async -> R {
        await execution(parameters)
    }
}

public protocol ThrowingUseCase {
    associatedtype ParameterType
    associatedtype ResultType

    func execute(with parameters: ParameterType) async throws -> ResultType
}

extension ThrowingUseCase where ParameterType == Void {
    func execute() async throws -> ResultType {
        try await execute(with: ())
    }
}

public struct AnyThrowingUseCase<R, P>: ThrowingUseCase {
    private let execution: (P) async throws -> R

    public init<WrappedUseCase: ThrowingUseCase>(
        _ wrappedUseCase: WrappedUseCase
    ) where WrappedUseCase.ResultType == R, WrappedUseCase.ParameterType == P {
        execution = wrappedUseCase.execute
    }

    public func execute(with parameters: P) async throws -> R {
        try await execution(parameters)
    }
}

extension UseCase {
    var erased: AnyUseCase<ResultType, ParameterType> {
        AnyUseCase(self)
    }
}
