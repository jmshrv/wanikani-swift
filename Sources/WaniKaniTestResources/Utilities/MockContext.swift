import Foundation

import WaniKani

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct MockContext {
    public var client: WaniKani
    var resources = MockResources()

    public init<Content: Codable>(
        content: Content...
    ) throws {
        let configuration = WaniKani.Configuration.default
        try self.init(
            configuration: configuration,
            responses: content.map {
                try MockData.mockingSuccess(with: $0, url: configuration.version.baseURL)
            }
        )
    }

    private init(
        configuration: WaniKani.Configuration,
        responses: [(Data, URLResponse)]
    ) {
        let transport = MockTransport(responses: responses)
        client = WaniKani(
            configuration: configuration,
            transport: transport
        )
    }
}

public extension ModelCollection {
    init(
        data: [Model]
    ) {
        self.init(
            url: URL(),
            totalCount: data.count,
            page: Page(
                perPageCount: data.count,
                nextURL: nil,
                previousURL: nil
            ),
            elements: data
        )
    }
}
