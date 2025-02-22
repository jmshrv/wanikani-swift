import Foundation
import XCTest

@testable import WaniKani
import WaniKaniTestResources

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension LevelProgression {
    init() {
        self.init(
            abandoned: nil,
            completed: nil,
            created: .testing,
            id: 0,
            level: 0,
            passed: nil,
            started: nil,
            unlocked: nil,
            url: URL()
        )
    }
}

class LevelProgressionsTests: XCTestCase {
    func testLevelProgressionList() async throws {
        let expected = ModelCollection(data: [LevelProgression()])
        let context = try MockContext(content: expected)

        let response = try await context.client.send(.levelProgressions(ids: [0, 1], updatedAfter: .testing))
        XCTAssertEqual(response.data, expected)
    }

    func testLevelProgressionGet() async throws {
        let expected = LevelProgression()
        let context = try MockContext(content: expected)

        let response = try await context.client.send(.levelProgression(0))
        XCTAssertEqual(response.data, expected)
    }
}
