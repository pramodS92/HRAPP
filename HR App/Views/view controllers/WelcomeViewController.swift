//
//Created by Pramod Ranasinghe

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var welcomeTextView: UIView!
    
    let animation = BaseAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.welcomeTextView.isHidden = true
        
        self.animation.welcomeTextAnimation(view: self.welcomeTextView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.viewNavigator()
        }
        
    }
    
    func viewNavigator() {
        self.checkAccessTokenValidity()
    }
    
    func checkAccessTokenValidity(){
        UserDetailsService.shared.getUserDetails { (response, error, statusCode) in

            switch statusCode! {
            case 200...299:
                if let responseBody = try? JSONDecoder().decode(UserDetailsModel.self, from: response! as! Data){
                    UserDefaults.standard.set(responseBody.user?.givenName, forKey: UserDefaultConstants.KeyConstants.UserName)
                }
                self.navigateToBiometricAuthScreen()
            case 401:
                UserDefaults.standard.set(nil, forKey: UserDefaultConstants.KeyConstants.UserName)
                self.navigateToLoginScreen()
            default:
                self.navigateToLoginScreen()
            }
        }
        
    }
    
    
    func navigateToLoginScreen(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.LOGIN_VC) as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func navigateToBiometricAuthScreen() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.BIOMETRIC_AUTH_VC) as! BiometricAuthViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

