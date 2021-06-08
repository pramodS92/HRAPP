//
//Created by Pramod Ranasinghe

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var loginScrollContainerView: UIScrollView!
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var loginButtonView: UIView!
    @IBOutlet weak var userNameViewHolder: UIView!
    @IBOutlet weak var passwordViewHolder: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var loginViewTitel: UILabel!
    
    let TEXT_FIELD_CONER_RADIUS = 22.0
    let TEXT_FIELD_BORDER_WIDTH = 1.0
    
    let animation = BaseAnimation()
    let networkClient = NetworkClient()
    let uiUtils = UiUtils()
    let serviceManager = AccessTokenServiceManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUiProps()
        setTapGuestures()
    }
    
    func setupUiProps(){
        setViewDecorator(view: loginButtonView)
        setViewHolderDecorator(view : userNameViewHolder)
        setViewHolderDecorator(view : passwordViewHolder)
        self.userNameTextField.placeholder = UiConstants.PlaceHolders.USER_NAME
        self.passwordTextField.placeholder = UiConstants.PlaceHolders.PASSWORD
        spinnerView.isHidden = true
    }
    
    
    /*Set all the views tap gustures*/
    func setTapGuestures(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.actionLogin(sender:)))
        self.loginButtonView.addGestureRecognizer(gesture)
        
        uiUtils.keyboardManager(view: self.view,scrollView: loginScrollContainerView)
        self.hideLoginKeyboardWhenTappedAround()
    }
    
    
    func setViewHolderDecorator(view: UIView){
        view.layer.cornerRadius = CGFloat(TEXT_FIELD_CONER_RADIUS)
    }
    
    func setViewDecorator(view:UIView){
        view.layer.cornerRadius = CGFloat(TEXT_FIELD_CONER_RADIUS)
    }
    
    
    @IBAction func userNameEditChange(_ sender: Any) {
        self.resetViewHolderBoderColor()
    }
    
    @IBAction func passwordEditChange(_ sender: Any) {
        self.resetViewHolderBoderColor()
    }
    
    
    func resetViewHolderBoderColor() {
        userNameViewHolder.layer.borderWidth = 0
        passwordViewHolder.layer.borderWidth = 0 
    }
    
    func onSuccessAccessToken() {
        self.animation.animateLoginButton(parentView: self.view,defaultView : self.defaultView,buttonView:self.loginButtonView,spinnerView:self.spinnerView,txtLable:self.loginViewTitel)
        self.navigateToOTPValidation()
    }
    
    func showInvalidUserCredentialsAlert() {
        self.uiUtils.showAlertView(title: UiConstants.AlertConst.ALERT_TITLE_ALERT, messege: UiConstants.AlertConst.INVALID_USER_CREDENTIALS,view: self)
    }
    
    @objc func actionLogin(sender : UITapGestureRecognizer){
        // && self.validatePassword()
        if(validateCredentialFields()){
            view.endEditing(true)
            self.getAccessToken()
        }else{
            return
        }
    }
    
    
    func navigateToOTPValidation(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.OTP_VALIDATION_VC) as! OTPValidationViewController
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    /*
     Validate credential inputs
     *Not allow empty
     *Not allow spaces
     */
    func validateCredentialFields()->Bool{
        var isUserNamevalidate = true
        var isPasswordValidate = true
        
        guard let text = userNameTextField.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else {
            userNameViewHolder.layer.borderWidth = CGFloat(TEXT_FIELD_BORDER_WIDTH)
            animation.animateValidationError(view: userNameViewHolder)
            isUserNamevalidate = false
            return isUserNamevalidate
        }
        
        guard let _text = passwordTextField.text?.trimmingCharacters(in: .whitespaces), !_text.isEmpty else {
            passwordViewHolder.layer.borderWidth = CGFloat(TEXT_FIELD_BORDER_WIDTH)
            animation.animateValidationError(view: passwordViewHolder)
            isPasswordValidate = false
            return isPasswordValidate
        }
        
        return isUserNamevalidate && isPasswordValidate
    }
    
    
    /*
     Password validation
     * Password must not contain part of user name,login name.
     * Password must contain at least 8 characters.
     * Password must contain at least one Uppercase character.
     * Password must contain at least one special character.
     * Password must contain at least one numeric(0-9) character.
     */
    func validatePassword()->Bool{
        var isPasswordValidate = true
        var validationError: String!
        var capitalresult = true,numberresult = true,specialresult = true
        let passwordText = self.passwordTextField .text!
        
        if passwordText.count <= 7 || self.passwordTextField.text!.lowercased().contains(self.userNameTextField.text!.lowercased()){
            isPasswordValidate = false
            validationError = UiConstants.AlertConst.PASSWORD_LEAST_CHAR_COUNT
            
        }else{
            // let text = self.passwordTextField.text
            let capitalLetterRegEx  = ".*[A-Z]+.*"
            
            let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
            capitalresult =  texttest.evaluate(with: passwordText)
            if capitalresult{
                validationError =  UiConstants.AlertConst.PASSWORD_LEAST_CHAR_UPPER
            }
            
            let numberRegEx  = ".*[0-9]+.*"
            let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
            numberresult = texttest1.evaluate(with: passwordText)
            if numberresult{
                validationError =  UiConstants.AlertConst.PASSWORD_LEAST_NUM_VALUE
            }
            
            
            let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
            let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
            
            specialresult = texttest2.evaluate(with: passwordText)
            if specialresult{
                validationError =  UiConstants.AlertConst.PASSWORD_LEAST_CHAR_SPECIAL
            }
            
            
        }
        print(validationError)
        return isPasswordValidate && capitalresult && numberresult && specialresult
    }
    
}


extension LoginViewController: URLSessionDelegate{
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.host == "122.255.63.41" {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

extension UIViewController {
    func hideLoginKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissLoginKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: OnSuccessAccessToken {
    
    internal func getAccessToken(){
        serviceManager.getAccessToken(userName: userNameTextField.text!, password: passwordTextField.text!, self)
    }
    
    func OnSuccessAccessToken() {
        onSuccessAccessToken()
    }
    
    func OnFailierAccessToken() {
        showInvalidUserCredentialsAlert()
    }
}


