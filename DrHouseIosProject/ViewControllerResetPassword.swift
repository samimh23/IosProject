import UIKit

class ViewControllerResetPassword: UIViewController, UITextFieldDelegate {

    // Field text
    @IBOutlet weak var PasswordFealdText: UITextField!
    @IBOutlet weak var RePasswordFealdText: UITextField!
    
    // Labels for displaying validation feedback
    @IBOutlet weak var PassFeedbackLabel: UILabel!
    @IBOutlet weak var RePassFeedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the text field delegates
        PasswordFealdText.delegate = self
        RePasswordFealdText.delegate = self
        
        // Add target for real-time validation
        PasswordFealdText.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        RePasswordFealdText.addTarget(self, action: #selector(validateRePass), for: .editingChanged)
    }
    
    // Validation function for password field (minimum 6 characters)
    @objc func validatePassword() {
        if let passwordText = PasswordFealdText.text {
            let isValid = passwordText.count >= 6
            PasswordFealdText.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor
            PassFeedbackLabel.text = isValid ? "Strong password" : "Password must be at least 6 characters"
            PassFeedbackLabel.textColor = isValid ? .green : .red
        } else {
            PassFeedbackLabel.text = "Password cannot be empty"
            PassFeedbackLabel.textColor = .red
        }
        
        // Update the re-enter password field validation
        validateRePass()
    }
    
    // Validation function for re-enter password field (should match password)
    @objc func validateRePass() {
        if let passwordText = PasswordFealdText.text, let rePasswordText = RePasswordFealdText.text {
            let isMatching = rePasswordText == passwordText
            RePasswordFealdText.layer.borderColor = isMatching ? UIColor.green.cgColor : UIColor.red.cgColor
            RePassFeedbackLabel.text = isMatching ? "Passwords match" : "Passwords do not match"
            RePassFeedbackLabel.textColor = isMatching ? .green : .red
        } else {
            RePassFeedbackLabel.text = "Please re-enter password"
            RePassFeedbackLabel.textColor = .red
        }
    }
    
    // Optional: UITextFieldDelegate method to limit characters or other constraints
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
