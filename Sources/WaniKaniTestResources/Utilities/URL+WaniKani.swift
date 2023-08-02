import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public extension URL {
    init() {
        self.init(string: "https://www.wanikani.com")!
    }
}
