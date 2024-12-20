import UIKit
import Combine

class ViewController: UIViewController, UITextFieldDelegate {
    // TextField outlets
    @IBOutlet weak var emailfeald: UITextField!
    @IBOutlet weak var passwordfeald: UITextField!
    
    // Feedback Labels
    @IBOutlet weak var passwordFeedbackLabel: UILabel!
    @IBOutlet weak var emailFeedbackLabel: UILabel!
    
    // ViewModel and Combine Subscription
    private var viewModel: SigninViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordfeald.delegate = self
        emailfeald.delegate = self
        
        passwordfeald.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        emailfeald.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
        
        let userRepository = UserRepository() // Initialize UserRepository
        viewModel = SigninViewModel(userRepository: userRepository)
        
        // Observe UI state changes
        viewModel.$loginUiState
            .sink { [weak self] state in
                self?.handleLoginUiState(state)
            }
            .store(in: &cancellables)
    }
    
    // Validation for password
    @objc func validatePassword() {
        if let passwordText = passwordfeald.text {
            let isValid = passwordText.count >= 6
            passwordfeald.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor
            passwordFeedbackLabel.text = isValid ? "Strong password" : "Password must be at least 6 characters"
            passwordFeedbackLabel.textColor = isValid ? .green : .red
        } else {
            passwordFeedbackLabel.text = "Password cannot be empty"
            passwordFeedbackLabel.textColor = .red
        }
    }
    
    // Validation for email
    @objc func validateEmail() {
        if let emailText = emailfeald.text, !emailText.isEmpty {
            let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let isValid = emailText.range(of: emailPattern, options: .regularExpression) != nil
            emailfeald.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor
            emailFeedbackLabel.text = isValid ? "Valid email" : "Invalid email format"
            emailFeedbackLabel.textColor = isValid ? .green : .red
        } else {
            emailfeald.layer.borderColor = UIColor.red.cgColor
            emailFeedbackLabel.text = "Email cannot be empty"
            emailFeedbackLabel.textColor = .red
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        guard let email = emailfeald.text, let password = passwordfeald.text else { return }
        viewModel.loginUser(email: email, password: password)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    private func handleLoginUiState(_ state: LoginUiState) {
        if state.isLoggedIn {
            print("User logged in successfully with token: \(state.token ?? "")")
            // Navigate to another screen or perform an action
        } else if let errorMessage = state.errorMessage {
            showError(errorMessage)
            print(errorMessage)
        }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
