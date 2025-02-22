import Foundation
import XCTest

@testable import WaniKani
import WaniKaniTestResources

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension User {
    init() {
        self.init(
            id: UUID(),
            level: 1,
            preferences: Preferences(
                autoplayLessonsAudio: false,
                autoplayReviewsAudio: false,
                defaultVoiceActorID: 0,
                displayReviewsSRSIndicator: true,
                lessonsBatchSize: 10,
                lessonsPresentationOrder: .ascendingLevelThenSubject
            ),
            profileURL: URL(),
            started: .testing,
            subscription: Subscription(
                isActive: true,
                maxLevelGranted: 60,
                periodEnds: nil,
                type: .lifetime
            ),
            username: "haruko",
            url: URL()
        )
    }
}

class UsersTests: XCTestCase {
    func testUserMe() async throws {
        let expected = User()
        let context = try MockContext(content: expected)

        let response = try await context.client.send(.me)
        XCTAssertEqual(response.data, expected)
    }

    func testUserUpdate() async throws {
        let expected = User()
        let context = try MockContext(content: expected)

        let response = try await context.client.send(
            .updateUser(
                defaultVoiceActorID: 0,
                lessonsAutoplayAudio: false,
                lessonsBatchSize: 5,
                lessonsPresentationOrder: .ascendingLevelThenShuffled,
                reviewsAutoplayAudio: false,
                reviewsDisplaySRSIndicator: true
            )
        )
        XCTAssertEqual(response.data, expected)
    }
}
