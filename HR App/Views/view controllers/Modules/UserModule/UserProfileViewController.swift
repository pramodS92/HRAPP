//
//
// UserProfileViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/18/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import UIKit
import Alamofire

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var contentViewHolder: UIView!
    @IBOutlet weak var userJobInfoViewContainer: UIView!
    @IBOutlet weak var userInfoViewContainer: UIView!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var userInfoTitles: [UILabel]!
    
    var employeeDetails: BranchEmployeeData!

    var userInfo: [String]?
    var userTabelData: [String]?
    var userJobTableData: [EmployeeSalaryDetailsData]?
    var isLoggedInUser: Bool?
    var employeeId: String?
    var loggedInEmployeeId: String?
    var serviceManager: UserProfileServiceManager = UserProfileServiceManager()
    var employeeSalaryDetailsServiceManager: EmployeeSalaryDetailsServiceManager = EmployeeSalaryDetailsServiceManager()
    
    var isLoggedIn: Bool = false {
        didSet {
            self.performSegue(withIdentifier: UiConstants.SegueIdentifiers.USER_INFO_SEGUE, sender: self)
            self.performSegue(withIdentifier: UiConstants.SegueIdentifiers.USER_JOB_INFO_SEGUE, sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDefaultSegment()
        isLoggedInUser ?? true ? self.getUserDetails() : self.getEmployeeDetailsById()
        self.getEmployeeSalaryDetailsById()
        self.backButton.isHidden = isLoggedInUser ?? true
    }
    
    func setDefaultSegment() {
        self.userJobInfoViewContainer.alpha = 0
        self.userInfoViewContainer.alpha = 1
    }
    
    func setUiProps(userInfo: [String],userTabelData: [String]) {
        self.userTabelData = userTabelData
        
        self.userInfoTitles.enumerated().forEach { (index, element) in
            element.text = userInfo[index]
        }
        
        self.isLoggedIn = true
        self.spinnerView.stopAnimating()
        self.spinnerView.isHidden = true
        
    }
    
    func setUserJobInfo(userJobTableData: [EmployeeSalaryDetailsData]) {
        print("jobs")
        self.userJobTableData = userJobTableData
        print(self.userJobTableData!)
        
    }
    
    func setActivityIndicatorVisibility(show: Bool) {
        self.spinnerView.isHidden = !show
        if show {
            self.spinnerView.startAnimating()
        }else {
            self.spinnerView.stopAnimating()
        }
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.userJobInfoViewContainer.alpha = 0
            self.userInfoViewContainer.alpha = 1
            
        }else if sender.selectedSegmentIndex == 1 {
            self.userInfoViewContainer.alpha = 0
            self.userJobInfoViewContainer.alpha = 1
            
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getUserDetails() {
        self.spinnerView.startAnimating()
        getUserProfile()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isLoggedIn
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UiConstants.SegueIdentifiers.USER_INFO_SEGUE {
            let destination = segue.destination as! UserInfoViewController
            destination.userTabelData =  self.userTabelData
        }
    }
}


extension UserProfileViewController: OnSuccessUserProfile {
    
    internal func getUserProfile() {
        serviceManager.getUserProfileInfo(self)
    }
    
    internal func getEmployeeDetailsById(){
        serviceManager.getEmployeeDetailsById(employeeId: self.employeeId!, self)
    }
    
    func OnSuccessUserProfile(userInfo: [String],userTabelData: [String]) {
        setUiProps(userInfo: userInfo, userTabelData: userTabelData)
    }
    
    func getUserData(userData: BranchEmployeeData) {
        
    }
    
}

extension UserProfileViewController: OnSuccessEmployeeSalaryDetails {
    
    internal func getEmployeeSalaryDetailsById() {
        print("helloworld")
        isLoggedInUser ?? true ? employeeSalaryDetailsServiceManager.getEmployeeSalaryDetailsById(employeeId: "02713", self) : employeeSalaryDetailsServiceManager.getEmployeeSalaryDetailsById(employeeId: self.employeeId!, self)
    }
    
    func getEmployeeSalaryInfo(employeeSalaries: [EmployeeSalaryDetailsData]) {
        setUserJobInfo(userJobTableData: employeeSalaries)
    }
    
    func onFailier() {
        setActivityIndicatorVisibility(show: false)
    }
    
}



