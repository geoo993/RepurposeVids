import UIKit
import SwiftUI
import FacebookLogin

struct FaceBookLoginView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> FaceBookLoginViewController {
        let vc = FaceBookLoginViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: FaceBookLoginViewController, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }
}

class FaceBookLoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let token = AccessToken.current, token.isExpired else {
            print("Token expired")
            return
        }
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.permissions = ["public_profile", "email"]
        view.addSubview(loginButton)
    }
}
