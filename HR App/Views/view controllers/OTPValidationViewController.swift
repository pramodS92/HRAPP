//
//Created by Aruni Amarasinghe

import UIKit
import SVProgressHUD

class OTPValidationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var otpViewHolder: UIView!
    @IBOutlet weak var otpTextView: UITextField!
    @IBOutlet weak var submitButtonOTP: UIButton!
    @IBOutlet weak var resendButtonOTP: UIButton!
    @IBOutlet weak var otpCodeLabel: UILabel!
    
    var serviceManager: OTPServiceManager = OTPServiceManager()
    var otpCode: String?
    var isOTPValid: Bool?
    var userId: String? = "HRMAPI"
    var transactionId: String? = "123456789"
    var otpCount: Int = 0
    
    let OTP_TEXT_FIELD_CONER_RADIUS = 5.0
    let OTP_TEXT_FIELD_BORDER_WIDTH = 1.0
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUiProps()
        self.otpCodeValidation()
        self.hideKeyboardWhenTappedAround()
        self.generateOTP(userId: self.userId!, transactionId: self.transactionId!)
    }
    
    func setUiProps(){
        otpViewHolder.layer.cornerRadius = CGFloat(OTP_TEXT_FIELD_CONER_RADIUS)
        otpViewHolder.layer.borderWidth = CGFloat(OTP_TEXT_FIELD_BORDER_WIDTH)
        otpTextView.placeholder = UiConstants.PlaceHolders.OTP_CODE_DIGIT
        
        resendButtonOTP.layer.cornerRadius = CGFloat(OTP_TEXT_FIELD_CONER_RADIUS)
        submitButtonOTP.layer.cornerRadius = CGFloat(OTP_TEXT_FIELD_CONER_RADIUS)

        resendButtonOTP.layer.borderColor = UIColor.systemBlue.cgColor
        resendButtonOTP.layer.borderWidth =  CGFloat(OTP_TEXT_FIELD_BORDER_WIDTH)
    }
    
    
    
    func otpCodeValidation(){
        self.otpTextView.delegate = self
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (otpTextView.text?.count)! > 5 {
            self.otpViewHolder.isUserInteractionEnabled = false
            self.otpViewHolder.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    @IBAction func onActionSubmit(_ sender: Any) {
        handleSubmit()
    }
    
    func handleSubmit() {
        let userOTPCode = otpTextView.text
        self.validateOTP(userId: self.userId!, transactionId: self.transactionId!, otp: userOTPCode!)
            if (self.isOTPValid == true) {
                self.navigateToConfigureBiometricPinScreen()
            } else if (self.otpTextView.text == "") {
                self.emptyOTPCodeField()
            } else {
                self.authenticateOTPCode()
            }
        self.otpTextView.text = ""
    }
    
    func authenticateOTPCode() {
        self.otpCount += 1
        if (self.otpCount > 5) {
            navigateToLoggingPage()
        }
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Invalid OTP", message: "You have entered an invalid PIN \(self.otpCount) times. Please try again", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func emptyOTPCodeField() {
        let alertController = UIAlertController(title: "Text field cannot be empty!", message: "Please enter OTP", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onActionResend(_ sender: Any) {
        self.generateOTP(userId: self.userId!, transactionId: self.transactionId!)
        
    }
    
    func setOtpCodeToLabel() {
        self.otpCodeLabel.text = self.otpCode
    }
    
    func navigateToBiometricScreen(){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.BIOMETRIC_AUTH_VC) as! BiometricAuthViewController
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true, completion: nil)
    }
    
    func navigateToConfigureBiometricPinScreen() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.CONFIGURE_BIOMETRIC_PIN_VC) as! BiometricPinConfigureViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = otpTextView.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
            return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        self.otpViewHolder.layer.borderColor = count > 4 ?  UIColor.lightGray.cgColor :UIColor.black.cgColor
        return count <= 6
    }
    
    func navigateToLoggingPage() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.LOGIN_VC) as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func setOTPCode(otp: String) {
        self.otpCodeLabel.text = KeyCostants.OTPDetails.WAIT_FOR_OTP_CODE
        self.otpCode = otp
        DispatchQueue.main.async {
            self.otpCodeLabel.text = self.otpCode
        }
        print("yololo", otpCode!)
    }
    
    func setOTPValid(status: Bool) {
        self.isOTPValid = status
        DispatchQueue.main.async {
            print(self.isOTPValid!)
        }
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension OTPValidationViewController: OnSuccessOTP {
    
    internal func generateOTP(userId: String, transactionId: String) {
        serviceManager.generateOTP(userId: userId, transactionId: transactionId, self)
    }
    
    internal func validateOTP(userId: String, transactionId: String, otp: String) {
        serviceManager.validateOTP(userId: userId, transactionId: transactionId, otp: otp, self)
    }
    
    func onSuccessGenerateOTP(phoneNo: String, status: String, otp: String) {
        self.setOTPCode(otp: otp)
    }
    
    func onSuccessValidateOTP(status: String) {
        let statusAsString = status
        let otpCodeValid = (statusAsString == "true")
        self.setOTPValid(status: otpCodeValid)
    }
    
    func OnFailier() {
        
    }
    
    
    
}

