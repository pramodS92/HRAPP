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
    @IBOutlet weak var timerLabel: UILabel!
    
    var serviceManager: OTPServiceManager = OTPServiceManager()
    var otpCode: String?
    var isOTPValid: Bool?
    var userId: String? = "HRMAPI"
    var transactionId: String? = "123456789"
    var otpCount: Int = 0
    var timerCount: Int = 0
    var timer: Timer = Timer()
    
    
    let OTP_TEXT_FIELD_CONER_RADIUS = 5.0
    let OTP_TEXT_FIELD_BORDER_WIDTH = 1.0
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUiProps()
        self.hideKeyboardWhenTappedAround()
        self.generateOTPCode(userId: self.userId!, transactionId: self.transactionId!)
//        timer = Timer(timeInterval: 20, target: self, selector: #selector(resendOTP), userInfo: nil, repeats: true)
    }
    
    func setUiProps(){
        otpViewHolder.layer.cornerRadius = CGFloat(OTP_TEXT_FIELD_CONER_RADIUS)
        otpViewHolder.layer.borderWidth = CGFloat(OTP_TEXT_FIELD_BORDER_WIDTH)
        otpTextView.placeholder = UiConstants.PlaceHolders.OTP_CODE_DIGIT
        
        resendButtonOTP.layer.cornerRadius = CGFloat(OTP_TEXT_FIELD_CONER_RADIUS)
        submitButtonOTP.layer.cornerRadius = CGFloat(OTP_TEXT_FIELD_CONER_RADIUS)

        resendButtonOTP.layer.borderColor = UIColor.systemBlue.cgColor
        resendButtonOTP.layer.borderWidth =  CGFloat(OTP_TEXT_FIELD_BORDER_WIDTH)
        
        otpCodeLabel.text = KeyCostants.OTPDetails.WAIT_FOR_OTP_CODE
        
        self.otpTextView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
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
        
    }
    
//    @objc func resendOTP() {
//        self.generateOTPCode(userId: self.userId!, transactionId: self.transactionId!)
//    }
    
    func authenticateOTPCode() {
        self.otpCount += 1
        if (self.otpCount < 5) {
            alertFunc(title: UiConstants.AlertConst.INVALID_OTP_TITLE, message: "You have entered an invalid PIN  \(self.otpCount)  times. Please try again", alertActionTitle: UiConstants.AlertConst.DISMISS_ACTION_TITLE)
        } else if (self.otpCount == 5) {
            alertFunc(title: UiConstants.AlertConst.INVALID_OTP_TITLE, message: "You have entered an invalid PIN  \(self.otpCount)  times. Final Attempt. Please try again", alertActionTitle: UiConstants.AlertConst.DISMISS_ACTION_TITLE)
        }
        else {
        navigateToLoggingPage()
        }
            
    }
    
    func emptyOTPCodeField() {
        alertFunc(title: UiConstants.AlertConst.OTP_TEXT_FIELD_EMPTY, message: UiConstants.AlertConst.PLEASE_ENTER_OTP, alertActionTitle: UiConstants.AlertConst.DISMISS_ACTION_TITLE)
    }
    
    @IBAction func onActionResend(_ sender: Any) {
        self.generateOTPCode(userId: self.userId!, transactionId: self.transactionId!)
        
    }
    
    func setOtpCodeToLabel() {
        self.otpCodeLabel.text = self.otpCode
    }
    
    func alertFunc(title: String, message: String, alertActionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
    
    @objc func timerCounter() {
        timerCount = timerCount + 1
        let time = secondsToHoursMinutesSeconds(seconds: timerCount)
        var timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = KeyCostants.OTPDetails.OTP_EXPIRE_MESSAGE + ": " + timeString
        if (timeString == "01 : 00") {
            timeString = "00 : 00"
            print(timeString)
            timerCount = 0
        }
    }
    
    // seconds conversion
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 360), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    // convert time to string
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        //        timeString += String(format: "%02d", hours)
        //        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
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
            if (self.isOTPValid == true) {
                self.navigateToConfigureBiometricPinScreen()
            } else if (self.otpTextView.text == "") {
                self.emptyOTPCodeField()
            } else {
                self.authenticateOTPCode()
                
            }
            self.otpTextView.text = ""
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
    
    internal func generateOTPCode(userId: String, transactionId: String) {
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

