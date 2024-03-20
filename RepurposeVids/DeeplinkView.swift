import SwiftUI


public struct Deeplink: Hashable {
    public var pathComponents: [String]
    public var parameters: [URLQueryItem]

    init(pathComponents: [String], parameters: [URLQueryItem]) {
        self.pathComponents = pathComponents
        self.parameters = parameters
    }

    public init(from url: URL) {
        self.pathComponents = url.pathComponents.filter { $0 != "/" }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        self.parameters = urlComponents?.queryItems ?? []
    }

    public var firstComponent: String? {
        pathComponents.first
    }

    public func parameter(forKey key: String, caseSensitive: Bool) -> String? {
        parameters
            .first {
                let comparaison = caseSensitive ? $0.name.compare(key) : $0.name.caseInsensitiveCompare(key)
                return comparaison == .orderedSame
            }?
            .value
    }
}

struct DeeplinkView: View {
    
    var body: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            Text("Deeplink was triggered")
        }
    }
}

#Preview {
    DeeplinkView()
}
