import UIKit

class ViewControllerForgetPassword: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailFeald: UITextField!
    @IBOutlet weak var emailFeedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the text field delegate
        emailFeald.delegate = self
        
        // Add target for real-time validation
        emailFeald.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
    }
    
    // Real-time validation for email field
    @objc func validateEmail() {
        if let emailText = emailFeald.text {
            let isValid = isValidEmail(emailText)
            emailFeald.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor
            emailFeedbackLabel.text = isValid ? "Valid email address" : "Please enter a valid email"
            emailFeedbackLabel.textColor = isValid ? .green : .red
        }
    }
    
    // Function to validate email using regex
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Optional: UITextFieldDelegate method to limit characters or other constraints
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
