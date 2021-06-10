//
//
// BiometricAuthViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/16/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit
import LocalAuthentication

class BiometricAuthViewController: UIViewController, UITextFieldDelegate {
    
    let animation = BaseAnimation()
    let uiUtils = UiUtils()
    let imgViewPinText = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let imgViewPinHideText = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let eyeImage = UIImage(named: "pineye.png")
    let eyeHideImage = UIImage(named: "pineyehide.png")
    
    var pinCount:Int = 0
    var pinTextField: UITextField!
    var okAction: UIAlertAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let userName = UserDefaults.standard.string(forKey:  UserDefaultConstants.KeyConstants.UserName) {
                let welcomeText = UiConstants.Animation.ANIM_TXT_WELCOME + " " + userName.uppercased()
                self.animation.animateLetter(view :self.view,welcomeText: welcomeText)
                
            } else {
                return
            }
        }
       
    }
    
    private func isBioIdSecured() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultConstants.BiometricsPinConstants.isBiometricsEnabled)
    }
    
    private func isPinSecured() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultConstants.BiometricsPinConstants.isLocalPinEnabled)
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify Yourself!"
            
            context.localizedFallbackTitle = ""
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticateError in
                DispatchQueue.main.async {
                    if success {
                        self.navigateToLandingPage()
                    } else {
                        self.authenticateWithPin()
                    }
                }
            }
            
        } else {
            self.authenticateWithPin()
        }
        
        
    }
    
    func authenticateWithPin() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Enter PIN number", message: "Please enter your PIN number here", preferredStyle: .alert)
            
            self.imgViewPinHideText.image = self.eyeHideImage
            let tapGestureHide = UITapGestureRecognizer(target: self, action: #selector(self.eyeImageHideAction))
            self.imgViewPinHideText.addGestureRecognizer(tapGestureHide)
            self.imgViewPinHideText.isUserInteractionEnabled = true
            
            self.imgViewPinText.image = self.eyeImage
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.eyeImageAction))
            self.imgViewPinText.addGestureRecognizer(tapGesture)
            self.imgViewPinText.isUserInteractionEnabled = true
            
            alertController.addTextField { (textField: UITextField!) in
                self.pinTextField = textField
                self.pinTextField.delegate = self
                self.pinTextField.placeholder = "Enter PIN"
                self.pinTextField.isSecureTextEntry = true
                self.pinTextField.rightView = self.imgViewPinText
                self.pinTextField.rightView = self.imgViewPinHideText
                self.pinTextField.rightViewMode = UITextField.ViewMode.always
                self.pinTextField.rightViewMode = .always
                self.pinTextField.keyboardType = UIKeyboardType.numberPad
                self.pinTextField.addTarget(self, action: #selector(self.alertTextFieldDidChange), for: UIControl.Event.editingChanged)
            }
            
            self.okAction = UIAlertAction(title: "Login", style: .default, handler: { (UIAlertAction) in
                let textField = alertController.textFields?.first
                
                if ((textField?.text?.count)! == 4 && (self.pinTextField.text == UserDefaults.standard.string(forKey: UserDefaultConstants.BiometricsPinConstants.LocalPin))) {
                    self.navigateToLandingPage()
                } else {
                    self.pinCount += 1
                    self.okAction.isEnabled = false
                    if self.pinCount <= 3 {
                        textField?.text = ""
                        let label = UILabel(frame: CGRect(x: 10, y: 60, width: 250, height: 20))
                        label.text = "You have entered an invalid PIN \(self.pinCount) times. Please try again"
                        label.textColor = UIColor.red
                        label.font = UIFont.systemFont(ofSize: 9)
                        alertController.view.addSubview(label)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        self.navigateToLoggingPage()
                        UserDefaults.standard.set(false, forKey: UserDefaultConstants.BiometricsPinConstants.isLocalPinEnabled)
                        UserDefaults.standard.set(false, forKey: UserDefaultConstants.BiometricsPinConstants.isBiometricsEnabled)
                        self.pinCount = 0
                    }
                }
            })
            
            self.okAction.isEnabled = false
            alertController.addAction(self.okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func alertTextFieldDidChange() {
        let alertController: UIAlertController = self.presentedViewController as! UIAlertController;
        let pinTextField: UITextField = alertController.textFields![0];
        let okAction: UIAlertAction = alertController.actions[0];
        if pinTextField.text?.count == 4 {
            okAction.isEnabled = true
        } else {
            okAction.isEnabled = false
        }
    }
    
    //toggle for show/hide password
    @objc func eyeImageAction() {
        pinTextField.isSecureTextEntry.toggle()
        self.pinTextField.rightView = self.imgViewPinHideText
    }
    
    //toggle for show/hide password
    @objc func eyeImageHideAction() {
        pinTextField.isSecureTextEntry.toggle()
        self.pinTextField.rightView = self.imgViewPinText
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        
        switch textField {
        case pinTextField:
            return updateText.count <= 4
        default:
            return true
        }
    }
    
    func enableBioMetrics() {
        let contex = LAContext()
        var error: NSError? = nil
        
        if contex.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Please authorized with touch id!"
            contex.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        self!.uiUtils.showAlertView(title: "Failed to Authenticate", messege: "Please try again.", view: self!)
                        return
                    }
                    self!.navigateToLandingPage()
                }
            }
            
        }else{
            uiUtils.showAlertView(title: "Unavailable", messege: "You can't use this feature", view: self)
        }
        
        
    }
    
    func finishAndNavigate() {
            if isBioIdSecured() {
                authenticateUser()
            } else {
                authenticateWithPin()
            }
    }
    
    @IBAction func proceedButton(_ sender: Any) {
        self.finishAndNavigate()
    }
    
    
    func navigateToLandingPage() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.LANDING_VC) as! LandingViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func navigateToLoggingPage() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.LOGIN_VC) as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
