//
//
// BiometricAuthViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/16/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit
import LocalAuthentication

class BiometricAuthViewController: UIViewController{
    
    let animation = BaseAnimation()
    let uiUtils = UiUtils()
    
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
    
    @IBAction func proceedButton(_ sender: Any) {
        self.enableBioMetrics()
    }
    
    
    func navigateToLandingPage() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.LANDING_VC) as! LandingViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
