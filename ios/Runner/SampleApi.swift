//
//  Sample.swift
//  Runner
//
//  Created by 野瀬田 裕樹 on 2024/04/23.
//

import Foundation

extension FlutterError: Error, @unchecked Sendable {}

@available(iOS 13, *)
@MainActor
final class SampleApiImpl: SampleApi {
    let fetcher = SampleDataFetcher()
    let callFromNative: CallFromNative
    
    init(callFromNative: CallFromNative) {
        self.callFromNative = callFromNative
    }
    
    func fetchSampleAsync(parameter: SampleParameter) async -> Result<Sample, any Error> {
        let sample = await fetcher.fetchSampleAsync()
        let result = await callFromNative.fetchSample(parameter: .init(text: sample.text, id: sample.id))
        switch result {
        case .success(let newSample):
            return .success(newSample)
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    func fetchSampleSync(parameter: SampleParameter) throws -> Sample {
        let sample = fetcher.fetchSampleSync()
        print("fetchSampleSync test")
        return sample
    }
    
    func objectSampleAsync(parameter: Any?) async -> Result<Any?, any Error> {
        let testResult = await ObjectSampleTest.testAsync(parameter: parameter)
        return .success(parameter)
    }
    
    func objectSampleSync(parameter: Any?) throws -> Any? {
        parameter
    }
}

enum ObjectSampleTest {
    nonisolated static func testAsync(parameter: Any?) async -> Any? {
        parameter
    }
}

@available(iOS, obsoleted: 13.0)
final class SampleApiLegacyImpl: SampleApiLegacy {
    let callFromNative: CallFromNativeLegacy
    
    init(callFromNative: CallFromNativeLegacy) {
        self.callFromNative = callFromNative
    }
    
    func fetchSampleAsync(parameter: SampleParameter, completion: @escaping (Result<Sample, any Error>) -> Void) {
        let sample = Sample(text: "test", id: 1)
        callFromNative.fetchSample(
            parameter: .init(text: sample.text, id: sample.id)) { result in
                switch result {
                case .success(let newSample):
                    completion(.success(newSample))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
    }
    
    func fetchSampleSync(parameter: SampleParameter) throws -> Sample {
        return Sample(text: "test3", id: 3)
    }
    
    func objectSampleAsync(parameter: Any?, completion: @escaping (Result<Any?, any Error>) -> Void) {
        completion(.success(parameter))
    }
    
    func objectSampleSync(parameter: Any?) throws -> Any? {
        parameter
    }
}

@MainActor
final class SampleDataFetcher {
    nonisolated func fetchSampleAsync() async -> Sample {
        Sample(text: "test", id: 1)
    }
    
    func fetchSampleSync() -> Sample {
        Sample(text: "test2", id: 2)
    }
}
