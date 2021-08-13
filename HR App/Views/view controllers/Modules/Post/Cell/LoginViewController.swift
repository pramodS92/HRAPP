//
//  LoginViewController.swift
//  ComBe
//
//  Created by Lakith Jayalath on 2021-08-05.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var userNameViewHolder: UIView!
    @IBOutlet var passwordViewHolder: UIView!
    @IBOutlet var loginButtonView: UIView!
    @IBOutlet var defaultView: UIView!
    @IBOutlet var loginContainerView: UIView!
    @IBOutlet var loginScrollContainerView: UIScrollView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var spinnerView: UIActivityIndicatorView!
    
    let TEXT_FIELD_CONER_RADIUS = 22.0
    let TEXT_FIELD_BORDER_WIDTH = 1.0
    
    let animation = AnimationUtils()
    let uiUtils = UiUtils()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupUiProps() {
        setViewDecorator(view: loginButtonView)
        setViewHolderDecorator(view : userNameViewHolder)
        setViewHolderDecorator(view : passwordViewHolder)
        spinnerView.isHidden = true
    }
    
    func setTapGestures() {
        
        uiUtils.keyboardManager(view: self.view, scrollView: loginScrollContainerView)
        self.hideLoginKeyboardWhenTappedAround()
    }
    
    func setViewHolderDecorator(view: UIView){
        view.layer.cornerRadius = CGFloat(TEXT_FIELD_CONER_RADIUS)
    }
    
    func setViewDecorator(view:UIView){
        view.layer.cornerRadius = CGFloat(TEXT_FIELD_CONER_RADIUS)
    }
    
    @IBAction func userNameEditChange(_ sender: Any) {
        resetViewHolderBoderColor()
    }
    
    @IBAction func passwordEditChange(_ sender: Any) {
        resetViewHolderBoderColor()
    }
    
    func resetViewHolderBoderColor() {
        userNameViewHolder.layer.borderWidth = 0
        passwordViewHolder.layer.borderWidth = 0
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

extension UIViewController {
    func hideLoginKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissLoginKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissLoginKeyboard() {
        view.endEditing(true)
    }
}
