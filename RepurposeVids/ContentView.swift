import SwiftUI
import TikTokOpenAuthSDK

enum RoutePath: String {
    case home
    
    public init?(from deeplink: Deeplink) {
        guard let destination = deeplink.firstComponent else { return nil }
        self.init(rawValue: destination.lowercased())
    }
}

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        contentView
            .onOpenURL(perform: handleUrl)
    }
    
    @ViewBuilder
    var contentView: some View {
        VStack(spacing: 16) {
            Button("Start Facebook Login") {
                viewModel.isFacebookPresented = true
            }
            Button("Start Tiktok Login") {
                viewModel.tiktokRequest()
            }
            .sheet(isPresented: $viewModel.isFacebookPresented) {
                FacebookLoginView()
            }
            .sheet(isPresented: $viewModel.isTiktokPresented) {
                DeeplinkView()
            }
        }
        .padding()
    }
    
    private func handleUrl(_ url: URL) {
        let deeplink = Deeplink(from: url)
        guard let route = RoutePath(from: deeplink) else {
            print("Incorrect deeplink")
            return
        }
        print("Deeplink", deeplink.pathComponents, deeplink.parameters)
        switch route {
        case .home:
            viewModel.isDeeplink = true
        }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var isFacebookPresented = false
        @Published var isTiktokPresented = false
        @Published var isDeeplink = false
        
        func tiktokRequest() {
            let authRequest = TikTokAuthRequest(
                scopes: ["user.info.basic"],
                redirectURI: "repurposevidsapp://gqnmedia.com/home"
            )
            authRequest.send { response in
                DispatchQueue.main.async {
                    guard let response = response as? TikTokAuthResponse else { return }
                    if response.errorCode == .noError {
                        print("Auth code: \(response.authCode)")
                    } else {
                        print("Authorization Failed! Error: \(response.error ?? "") Error Description: \(response.errorDescription ?? "")")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
