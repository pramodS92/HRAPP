//
//  HomeViewController.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var directoryBtn: UIButton!
    @IBOutlet var userProfileBtn: UIButton!
    @IBOutlet var postBtn: UIButton!
    @IBOutlet var notificationBtn: UIButton!
    @IBOutlet var productRefGuideBtn: UIButton!
    @IBOutlet var moduleOneBtn: UIButton!
    @IBOutlet var moduleTwoBtn: UIButton!
    @IBOutlet var moduleThreeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        directoryBtn.layer.cornerRadius = 10.0
        userProfileBtn.layer.cornerRadius = 10.0
        postBtn.layer.cornerRadius = 10.0
        notificationBtn.layer.cornerRadius = 10.0
        productRefGuideBtn.layer.cornerRadius = 10.0
        moduleOneBtn.layer.cornerRadius = 10.0
        moduleTwoBtn.layer.cornerRadius = 10.0
        moduleThreeBtn.layer.cornerRadius = 10.0
        
    }

}
