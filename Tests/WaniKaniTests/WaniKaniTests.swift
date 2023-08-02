import Foundation
import XCTest

@testable import WaniKani
import WaniKaniTestResources

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class WaniKaniTests: XCTestCase {
    func testSendRequest() async throws {
        let testData = try TestData(testCase: .success)
        let response = try await testData.client.send(testData.resources.contentResource)
        XCTAssertEqual(testData.resources.content, response.data)
    }

    func testSendRequestWithPagination() async throws {
        let testData = try TestData(testCase: .successPaginated)
        let response = try await testData.client.send(
            testData.resources.paginatedContentResource,
            pageOptions: PageOptions(afterID: 10)
        )
        XCTAssertEqual(testData.resources.paginatedContent, response.data)
        //        XCTAssertNotNil(response.data.page)
    }

    func testSendRequestWithBody() async throws {
        let testData = try TestData(testCase: .successHasBody)
        let response = try await testData.client.send(testData.resources.bodyAndContentResource)
        XCTAssertEqual(testData.resources.bodyAndContent, response.data)
    }

    func testPaginateStreamRequest() async throws {}

    func testSendWithInvalidResponse() async throws {
        let testData = try TestData(testCase: .badResponse)
        do {
            _ = try await testData.client.send(testData.resources.contentResource)
            XCTFail("Expected to have thrown an error, but task fulfilled normally")
        } catch {}
    }

    func testSendWithUnsuccessfulResponse() async throws {
        let testData = try TestData(testCase: .unsuccessfulResponse)
        do {
            _ = try await testData.client.send(testData.resources.contentResource)
            XCTFail("Expected to have thrown an error, but task fulfilled normally")
        } catch {}
    }
}
