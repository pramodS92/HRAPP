//
//Created by Pramod Ranasinghe

import Foundation
import UIKit


class BaseAnimation{
    
    var islengthy = false
    
    
    //Splash Screen -  Welcome text fade and float animation
    //*************************************************************/
    
    func welcomeTextAnimation(view : UIView){
        view.isHidden = false
        UIView.animate(withDuration: 1.2,
                       animations: {
                        view.alpha = 0
                        view.transform = CGAffineTransform(translationX:60, y: 0)
                        view.alpha = 1
                        
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            view.alpha = 1
                        }
                       })
    }
    
    
    
    //Login Screen -  Login button scale in and spinner visible animation
    //*************************************************************/
    
    func animateLoginButton(parentView: UIView,defaultView : UIView,buttonView:UIView,spinnerView:UIActivityIndicatorView,txtLable:UILabel){
        
        spinnerView.isHidden = false
        spinnerView.startAnimating()
        
        defaultView.transform = CGAffineTransform(scaleX: 0.1, y: 1.0)
        UIView.animate(withDuration:1.0,animations:{
            txtLable.alpha = 0
            buttonView.layer.cornerRadius = buttonView.frame.size.height/2
            txtLable.transform = CGAffineTransform(translationX: -CGFloat(buttonView.frame.size.width/2), y: 0)
            
            ///reduce width from view center
            buttonView.frame.size.width = buttonView.frame.size.height
            
            buttonView.frame = CGRect(x: buttonView.frame.origin.x, y: buttonView.frame.origin.y, width: buttonView.frame.size.width, height: buttonView.frame.size.height)
            
        },completion: {_ in
            txtLable.isHidden = true
            UIView.animate(withDuration:1.2,animations:{
                
                spinnerView.stopAnimating()
                spinnerView.isHidden = true
                buttonView.transform = CGAffineTransform(scaleX: 100, y: 100)
            },completion: {_ in
            })
        })
        buttonView.isUserInteractionEnabled = false
    }
    
    
    func scaleLgonView(){
        
    }
    
    
    //Login Screen - Floating letters animation with user name
    //*************************************************************/
    
    func animateLetter(view :UIView,welcomeText:String){
        var containerView:UIView = UIView()
        var position = 0
        containerView = UIView(frame: CGRect(x: 10, y: view.frame.height/3, width: view.frame.width, height:60))
        view.addSubview(containerView)
        
        let characters = Array(welcomeText)
        if characters.count > 16 {
            islengthy = true
        }
        
        for i in 0..<characters.count{
            ///left to right(-) | right to left(+)
            if islengthy && i == 8 {
                position = 0
            }
            position -= 8
            containerView.addSubview(self.generateLabel(character:characters[i],position:position,count:i))
        }
    }
    
    
    
    func generateLabel(character:Character,position:Int,count:Int)->UILabel{
        
        let label:UILabel
        label = UILabel(frame: CGRect(x: -CGFloat(position), y: islengthy && count > 7 ? 25 : 0, width: 15, height:25))
        
        ///animate left to right
        UIView.animate(withDuration: 2.2,
                       animations: {
                        label.isHidden = false
                        label.alpha = 0
                        label.transform = CGAffineTransform(translationX: -CGFloat(position), y: 0)
                        label.alpha = 1
                        label.textAlignment = .center
                        label.font = label.font.withSize(15)
                        label.text = String(character)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            label.alpha = 1
                        }
                       })
        return label
    }
    
    
    //Login Screen - Validation error animation for text filed
    //*************************************************************/
    
    func animateValidationError(view : UIView){
        let animation = CABasicAnimation(keyPath: "position")
        
        view.layer.borderColor = UIColor.red.cgColor
        
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5, y: view.center.y))
        
        view.layer.add(animation, forKey: "position")
    }
}


