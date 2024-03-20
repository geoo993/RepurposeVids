import UIKit
import SwiftUI
import FacebookLogin

struct FacebookButton: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let loginButton = FBLoginButton()
        loginButton.permissions = ["public_profile", "email"]
        return loginButton
    }
    
    func updateUIView(_ uiViewController: UIView, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

struct FacebookLoginView: View {
    @State var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("Facebook")
            if viewModel.isTokenExpired {
                FacebookButton()
                    .frame(height: 45)
                    .padding()
            }
        }
        .onChange(of: viewModel.token) { _, token in
            print("token expired:", viewModel.isTokenExpired, ", token", token)
        }
        .onAppear {
            viewModel.getToken()
        }
    }
}

extension FacebookLoginView {
    final class ViewModel: ObservableObject {
        @Published var isTokenExpired: Bool = true
        private(set) var token: String?
        
        func getToken() {
            let accessToken = AccessToken.current
            token = accessToken?.tokenString
            isTokenExpired = accessToken?.isExpired ?? true
        }
    }
}
