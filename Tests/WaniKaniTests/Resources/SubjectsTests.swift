import Foundation
import SwiftData
import XCTest

@testable import WaniKani
import WaniKaniTestResources

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class SubjectsTests: XCTestCase {
//    Note: SwiftData seems to break equatable (probably a bug?), so we check
//    hash values instead
    var context: ModelContext?
    
    override func setUpWithError() throws {
        let schema = Schema([
            Radical.self,
            Kanji.self,
            Vocabulary.self,
            KanaVocabulary.self
        ])
        let config = ModelConfiguration(schema: schema, inMemory: true)
        guard let container: ModelContainer = try? ModelContainer(for: schema, configurations: [config]) else {
            XCTFail("Failed to set up model container")
            return
        }
        context = ModelContext(container)
    }
    
    func testSubjectList() async throws {
        let expected = ModelCollection(data: [
            Subject.radical(Radical()),
            Subject.kanji(Kanji()),
            Subject.vocabulary(Vocabulary()),
        ])
        let context = try MockContext(content: expected)
        
        let response = try await context.client.send(
            .subjects(
                ids: [0, 1],
                types: [.radical],
                slugs: ["ground"],
                levels: [1, 2],
                isHidden: false,
                updatedAfter: .testing
            )
        )
        XCTAssertEqual(response.data.hashValue, expected.hashValue)
    }
    
    func testSubjectGetRadical() async throws {
        let expected: Subject = .radical(Radical())
        let context = try MockContext(content: expected)
        
        let response = try await context.client.send(.subject(0))
        XCTAssertEqual(response.data.hashValue, expected.hashValue)
    }
    
    func testSubjectGetKanji() async throws {
        let expected: Subject = .kanji(Kanji())
        let context = try MockContext(content: expected)
        
        let response = try await context.client.send(.subject(0))
        XCTAssertEqual(response.data.hashValue, expected.hashValue)
    }
    
    func testSubjectGetVocabulary() async throws {
        let expected: Subject = .vocabulary(Vocabulary())
        let context = try MockContext(content: expected)
        
        let response = try await context.client.send(.subject(0))
        XCTAssertEqual(response.data.hashValue, expected.hashValue)
    }
    
    func testSubjectGetKanaVocabulary() async throws {
        let expected: Subject = .kanaVocabulary(KanaVocabulary())
        let context = try MockContext(content: expected)
        
        let response = try await context.client.send(.subject(0))
        XCTAssertEqual(response.data.hashValue, expected.hashValue)
    }
    
    func testStore() async throws {
        let data = Radical()
        
        context!.insert(data)
        
        let predicate = #Predicate<Radical> { radical in
            radical.id == data.id
        }
        
        let fetchDescriptor = FetchDescriptor<Radical>(predicate: predicate)
        
        let fetchedRadicals = try context!.fetch(fetchDescriptor)
        
        XCTAssertEqual(fetchedRadicals.count, 1)
        XCTAssertEqual(fetchedRadicals.first?.hashValue, data.hashValue)
    }
}
