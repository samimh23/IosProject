import UIKit

class ViewControllerSignUP: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var namefeald: UITextField!
    @IBOutlet weak var passwordfeald: UITextField!
    @IBOutlet weak var emailfeald: UITextField!
    
    // Labels for displaying validation feedback
    
    @IBOutlet weak var nameFeedbackLabel: UILabel!
    @IBOutlet weak var emailFeedbackLabel: UILabel!
    @IBOutlet weak var passwordFeedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the text field delegates
        namefeald.delegate = self
        passwordfeald.delegate = self
        emailfeald.delegate = self
        
        // Add target for real-time validation
        namefeald.addTarget(self, action: #selector(validateName), for: .editingChanged)
        passwordfeald.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        emailfeald.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
    }
    
    // Validation function for name field (only letters)
    @objc func validateName() {
        if let nameText = namefeald.text, !nameText.isEmpty {
            let isValid = nameText.range(of: "^[a-zA-Z]+$", options: .regularExpression) != nil
            namefeald.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor
            nameFeedbackLabel.text = isValid ? "Valid name" : "Invalid name (only letters allowed)"
            nameFeedbackLabel.textColor = isValid ? .green : .red
        } else {
            namefeald.layer.borderColor = UIColor.red.cgColor
            nameFeedbackLabel.text = "Name cannot be empty"
            nameFeedbackLabel.textColor = .red
        }
    }
    
    // Validation function for password field (minimum 6 characters)
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
    
    // Validation function for email field (basic email format)
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
    
    // UITextFieldDelegate method to limit characters or other constraints (optional)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == namefeald {
            // Allow only letters in the name field
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
