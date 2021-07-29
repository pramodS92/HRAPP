//
//  BiometricPinConfigureViewController.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-09.
//

import UIKit
import LocalAuthentication

class BiometricPinConfigureViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var configurePintf: UITextField!
    @IBOutlet weak var configureBtn: UIButton!
    @IBOutlet weak var biometricSwitch: UISwitch!
    
    var isUserLoggedIn: Bool?
    
    let imgViewPinText = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let imgViewPinHideText = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let eyeImage = UIImage(named: "pineye.png")
    let eyeHideImage = UIImage(named: "pineyehide.png")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func viewBiometricsUserDefaultsBtnClicked(_ sender: Any) {
        print("LocalPin: \(UserDefaults.standard.string(forKey: UserDefaultConstants.BiometricsPinConstants.LocalPin)!)")
        print("isLocalPinEnabled: \(UserDefaults.standard.bool(forKey: UserDefaultConstants.BiometricsPinConstants.isLocalPinEnabled))")
        print("isBiometricsEnabled: \(UserDefaults.standard.bool(forKey: UserDefaultConstants.BiometricsPinConstants.isBiometricsEnabled))")
    }
    
    func setupUI() {
        configureHidePinText()
        biometricSwitch.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        configureBtn.layer.cornerRadius = 10.0
    }
    
    private func devicePasscodeSet() -> Bool {
        print("passcode enabled")
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    @objc func switchValueDidChange(sender: UISwitch!) {
        if (self.biometricSwitch.isOn) {
            if devicePasscodeSet() {
                UserDefaults.standard.set(sender.isOn, forKey: UserDefaultConstants.BiometricsPinConstants.isBiometricsEnabled)
            }
            else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Error", message: "Authentication not found", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            UserDefaults.standard.set(false, forKey: UserDefaultConstants.BiometricsPinConstants.isBiometricsEnabled)
        }
        print("switch value : \(sender.isOn)")
    }
    
    func configureHidePinText() {
        
        configurePintf.delegate = self
        
        imgViewPinHideText.image = eyeHideImage
        let tapGestureHide = UITapGestureRecognizer(target: self, action: #selector(eyeImageHideAction))
        imgViewPinHideText.addGestureRecognizer(tapGestureHide)
        imgViewPinHideText.isUserInteractionEnabled = true
        
        imgViewPinText.image = eyeImage
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(eyeImageAction))
        imgViewPinText.addGestureRecognizer(tapGesture)
        imgViewPinText.isUserInteractionEnabled = true
        
        configurePintf.rightView = imgViewPinText
        configurePintf.rightView = imgViewPinHideText
        configurePintf.rightViewMode = UITextField.ViewMode.always
        configurePintf.rightViewMode = .always
        configurePintf.keyboardType = UIKeyboardType.numberPad
        configurePintf.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    //toggle for show/hide password
    @objc func eyeImageAction(){
        configurePintf.isSecureTextEntry.toggle()
        self.configurePintf.rightView = self.imgViewPinHideText
    }
    
    //toggle for show/hide password
    @objc func eyeImageHideAction(){
        configurePintf.isSecureTextEntry.toggle()
        self.configurePintf.rightView = self.imgViewPinText
    }
    
    
    
    @objc func textFieldDidChange() {
        if configurePintf.text?.count == 4 {
            configureBtn.isEnabled = true
            biometricSwitch.isEnabled = true
        } else {
            configureBtn.isEnabled = false
            biometricSwitch.isEnabled = false
        }
    }
    
    @IBAction func configureBtnClicked(_ sender: Any) {
        configureBtn.isEnabled = false
        navigateToBiometricAuthScreen()
        
        UserDefaults.standard.set(configurePintf.text!, forKey: UserDefaultConstants.BiometricsPinConstants.LocalPin)
        UserDefaults.standard.set(true, forKey: UserDefaultConstants.BiometricsPinConstants.isLocalPinEnabled)
        
        print("LocalPin: \(UserDefaults.standard.string(forKey: UserDefaultConstants.BiometricsPinConstants.LocalPin)!)")
        print("isLocalPinEnabled: \(UserDefaults.standard.bool(forKey: UserDefaultConstants.BiometricsPinConstants.isLocalPinEnabled))")
        print("isBiometricsEnabled: \(UserDefaults.standard.bool(forKey: UserDefaultConstants.BiometricsPinConstants.isBiometricsEnabled))")
        configurePintf.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        
        switch textField {
        case configurePintf:
            return updateText.count <= 4
        default:
            return true
        }
    }
    
    func navigateToBiometricAuthScreen() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.BIOMETRIC_AUTH_VC) as! BiometricAuthViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
