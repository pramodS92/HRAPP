//
//Created by Aruni Amarasinghe

import UIKit

class OTPValidationViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var otpViewHolder: UIView!
    @IBOutlet weak var otpTextView: UITextField!
    @IBOutlet weak var submitButtonOTP: UIButton!
    @IBOutlet weak var resendButtonOTP: UIButton!
    
    let OTP_TEXT_FIELD_CONER_RADIUS = 5.0
    let OTP_TEXT_FIELD_BORDER_WIDTH = 1.0
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUiProps()
        self.otpCodeValidation()
        self.hideKeyboardWhenTappedAround()
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
        if (otpTextView.text?.count)! > 3 {
            self.otpViewHolder.isUserInteractionEnabled = false
            self.otpViewHolder.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    @IBAction func onActionSubmit(_ sender: Any) {
        self.navigateToBiometricScreen()
    }
    
    func navigateToBiometricScreen(){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.BIOMETRIC_AUTH_VC) as! BiometricAuthViewController
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
        self.otpViewHolder.layer.borderColor = count > 3 ?  UIColor.lightGray.cgColor :UIColor.black.cgColor
        return count <= 4
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

