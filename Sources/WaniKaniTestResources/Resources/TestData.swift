//
//  TestData.swift
//  
//
//  Created by James on 02/08/2023.
//

import Foundation
@testable import WaniKani

public struct TestData {
    public enum Case {
        case success
        case successPaginated
        case successHasBody
        case badResponse
        case unsuccessfulResponse
        case noData
    }

    var configuration: WaniKani.Configuration = .default
    public var client: WaniKani
    public var resources = MockResources()

    public init(
        testCase: Case = .success
    ) throws {
        let responses: [(Data, URLResponse)]

        switch testCase {
        case .success:
            responses = try [MockData.mockingSuccess(with: resources.content, url: configuration.version.baseURL)]
        case .successPaginated:
            responses = try [
                MockData.mockingSuccess(with: resources.paginatedContent, url: configuration.version.baseURL)
            ]
        case .successHasBody:
            responses = try [
                MockData.mockingSuccess(with: resources.bodyAndContent, url: configuration.version.baseURL)
            ]
        case .badResponse:
            responses = [MockData.mockingIncompatibleResponse(for: configuration.version.baseURL)]
        case .unsuccessfulResponse:
            responses = [MockData.mockingUnsuccessfulResponse(for: configuration.version.baseURL)]
        case .noData:
            responses = []
        }

        client = WaniKani(configuration: configuration, transport: MockTransport(responses: responses))
        client.token = "a valid token, i guess"
    }
}
