import Foundation
import XCTest

@testable import WaniKani
import WaniKaniTestResources

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class TransportTests: XCTestCase {
    private func createSession(testCase: MockURLProtocol.Case = .success) -> URLSession {
        switch testCase {
        case .success:
            MockURLProtocol.requestHandler = MockData.mockingSuccess
        case .error:
            MockURLProtocol.requestHandler = MockData.mockingError
        }
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }

    private class MockURLProtocol: URLProtocol {
        enum Case {
            case success
            case error
        }

        typealias RequestHandler = (URLRequest) throws -> (Data, URLResponse)
        static var requestHandler: RequestHandler?

        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }

        override func startLoading() {
            guard let handler = MockURLProtocol.requestHandler else {
                return
            }
            do {
                let (data, response) = try handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
        }

        override func stopLoading() {}
    }

    // MARK: - Tests

    func testURLSessionSendRequest() async throws {
        let request = URLRequest(url: URL())
        _ = try await createSession().send(request: request)
    }

    func testURLSessionSendRequestFailure() async {
        let request = URLRequest(url: URL())
        do {
            _ = try await createSession(testCase: .error).send(request: request)
            XCTFail("Expected to have failed with an error, but task fulfilled normally")
        } catch {}
    }
}
