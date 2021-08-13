//
//  UiUtils.swift
//  ComBe
//
//  Created by Lakith Jayalath on 2021-08-06.
//

import Foundation
import UIKit

class UiUtils {
    
    var isExpaned: Bool = false
    var keyboardHeight: CGFloat?
    
    var view: UIView!
    var scrollView: UIScrollView!
    
    /*
     Cusmot alert popup
     */
    public func showAlertView(title: String, messege: String,view: UIViewController) {
        
        let alert = UIAlertController(title: title,message: messege,preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        view.present(alert, animated: true, completion: nil)

        
    }
    
    
    /*
     All the keyboard visibility related function.
     When keyboard appears, UI will auto scroll according to keyboard height.
     */
    public func keyboardManager(view: UIView,scrollView: UIScrollView) {
        self.view = view
        self.scrollView = scrollView
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            
        }
        
        if !isExpaned {
            self.scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height + keyboardHeight!/2)
            self.scrollView.setContentOffset(CGPoint(x: 0, y: keyboardHeight!/2), animated: true)
            isExpaned = true
        }
    }
    
    @objc private func keyboardDisappear() {
        if isExpaned {
            self.scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height - keyboardHeight!/2)
            isExpaned = false
        }
    }
    
}
