//
//
// LandingViewController.swift
// HR App
//
//
//Created by Pramod Ranasinghe on 4/19/21
// Copyright © 2021 Other User. All rights reserved.
//


import UIKit

class LandingViewController: UITabBarController,UITabBarControllerDelegate {
    
//    var timer: Timer? 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 2
        setUpHomeBtn()

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        resetTimer()
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleControls))
//        view.addGestureRecognizer(tapGesture)
//    }
//
//    @objc func toggleControls() {
//        // toggle controls here
//        resetTimer()
//    }
//
//    func resetTimer() {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(hideControls), userInfo: nil, repeats: false)
//    }
//
//    @objc func hideControls() {
//            // Hide controls here
//        print("inactivity...")
//        UserDefaults.standard.setValue(false, forKey: UserDefaultConstants.BiometricsPinConstants.isScreenActive)
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpHomeBtn() {
        let homeBtn = UIButton(frame: CGRect(x: (self.view.center.x) - 30, y: (self.view.center.y) * 1.73, width: 60, height: 60))
        homeBtn.layer.cornerRadius = homeBtn.frame.size.height / 2
        homeBtn.backgroundColor = UIColor.darkGray
        homeBtn.setImage(UIImage(named: "ic_news_light"), for: .normal)
        homeBtn.layer.shadowColor = UIColor.black.cgColor
        homeBtn.layer.shadowOpacity = 0.1
        homeBtn.layer.shadowOffset = CGSize(width: 4, height: 4)
        homeBtn.clipsToBounds = true
        homeBtn.contentMode = UIView.ContentMode.center

        self.view.addSubview(homeBtn)
        
        homeBtn.addTarget(self, action: #selector(homeBtnAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    @objc func homeBtnAction(sender: UIButton) {
        self.selectedIndex = 2
    }


}
