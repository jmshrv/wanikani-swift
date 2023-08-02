import Foundation

@testable import WaniKani

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct MockResources {
    public struct Body: Codable, Hashable {
        var name: String
        var age: Int
    }

    public struct Content: Codable, Hashable {
        var name: String
        var age: Int
    }

    public struct HasContent: Resource {
        public typealias Content = MockResources.Content
        public let path = "mock"
    }

    public var contentResource = HasContent()
    public var content = HasContent.Content(name: "Jeff", age: 35)

    public struct HasPaginatedContent: Resource {
        public typealias Content = [MockResources.Content]
        public let path = "mock"
    }

    public var paginatedContentResource = HasPaginatedContent()
    public var paginatedContent: HasPaginatedContent.Content = [.init(name: "Jeff", age: 35), .init(name: "Jeff", age: 35)]

    public struct HasBodyAndContent: Resource {
        public typealias Content = MockResources.Content

        public var body: MockResources.Body
        public let path = "mock"
    }

    public var bodyAndContentResource = HasBodyAndContent(body: HasBodyAndContent.Body(name: "Jeff", age: 35))
    public var bodyAndContent = HasBodyAndContent.Content(name: "Jeff", age: 35)
}

public enum MockData {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom(Formatters.encodeISO8601)
        return encoder
    }()
}

extension MockData {
    public static func mockingSuccess<Content: Codable>(with content: Content, url: URL) throws -> (Data, URLResponse) {
        let data = try encoder.encode(content)
        return (data, urlResponse(for: url, status: .ok))
    }

    public static func mockingSuccess(for request: URLRequest) throws -> (Data, URLResponse) {
        guard let url = request.url else {
            fatalError("No URL was present on the request")
        }
        let content = MockResources.HasBodyAndContent.Body(name: "Jeff", age: 35)
        return try mockingSuccess(with: content, url: url)
    }

    public static func mockingIncompatibleResponse(for url: URL) -> (Data, URLResponse) {
        return (Data(), urlResponse(for: url, rawStatus: -128))
    }

    public static func mockingUnsuccessfulResponse(for url: URL) -> (Data, URLResponse) {
        let json = #"{"message":"not found","code": 400}"#
        guard let data = json.data(using: .utf8) else {
            fatalError("Could not encode json as data")
        }
        return (data, urlResponse(for: url, status: .notFound))
    }

    public static func mockingError(for request: URLRequest) throws -> (Data, URLResponse) {
        throw URLError(.notConnectedToInternet)
    }

    public static func mockingError(_ error: Error) throws -> (Data, URLResponse) {
        throw error
    }

    private static func urlResponse(for url: URL, status: StatusCode) -> URLResponse {
        urlResponse(for: url, rawStatus: status.rawValue)
    }

    private static func urlResponse(for url: URL, rawStatus status: Int) -> URLResponse {
        HTTPURLResponse(
            url: url,
            statusCode: status,
            httpVersion: "HTTP/1.1",
            headerFields: [:]
        )!
    }
}
