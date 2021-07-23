//
//  HomeViewController.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-25.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet var directoryBtn: UIButton!
    @IBOutlet var userProfileBtn: UIButton!
    @IBOutlet var postBtn: UIButton!
    @IBOutlet var notificationsBtn: UIButton!
    @IBOutlet var productRefGuideBtn: UIButton!
    @IBOutlet var eLeaveBtn: UIButton!
    @IBOutlet var settingsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        directoryBtn.layer.cornerRadius = 10.0
        userProfileBtn.layer.cornerRadius = 10.0
        postBtn.layer.cornerRadius = 10.0
        notificationsBtn.layer.cornerRadius = 10.0
        productRefGuideBtn.layer.cornerRadius = 10.0
        eLeaveBtn.layer.cornerRadius = 10.0
        settingsBtn.layer.cornerRadius = 10.0
    }
    
    
}
