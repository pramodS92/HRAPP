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
    @IBOutlet var userSegmentControl: UISegmentedControl!
    
    var employeeDetails: BranchEmployeeData!

    var helloWorld: [String] = ["Hello World", "10000"]
    var userInfo: [String]?
    var userTabelData: [String]?
    var userJobTableData: [String] = []
    var userSalaryTableData: [EmployeeSalaryDetailsData] = []
    var userJobInfoVc = UserJobInfoViewController()
    var userCurrentSalary: String?
    var isLoggedInUser: Bool?
    var showUserJobInfo: Bool?
    var employeeId: String?
    var loggedInEmployeeId: String?
    var serviceManager: UserProfileServiceManager = UserProfileServiceManager()
    var employeeSalaryDetailsServiceManager: EmployeeSalaryDetailsServiceManager = EmployeeSalaryDetailsServiceManager()
    
    var isLoggedIn: Bool = false {
        didSet {
            self.performSegue(withIdentifier: UiConstants.SegueIdentifiers.USER_INFO_SEGUE, sender: self)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDefaultSegment()
        isLoggedInUser ?? true ? self.getUserDetails() : self.getEmployeeDetailsById()
        self.getEmployeeSalaryDetailsById()
        self.backButton.isHidden = isLoggedInUser ?? true
        hideSegmentControl()
        
    }
    
    func hideSegmentControl() {
        if isLoggedInUser == false {
            userSegmentControl.isHidden = true
        } else {
            userSegmentControl.isHidden = false
        }
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
    
    func setUserSalaryInfo(userSalaryTableData: [EmployeeSalaryDetailsData]) {
        self.userSalaryTableData = userSalaryTableData
        self.userCurrentSalary = userSalaryTableData[0].basicSalary
        
        self.userJobTableData.append(userSalaryTableData[0].basicSalary)
        self.userJobTableData.append(" ")
        
//        self.isLoggedIn = true
//        self.spinnerView.stopAnimating()
//        self.spinnerView.isHidden = true
        
        userJobInfoVc.userJobTableData = self.userJobTableData
        userJobInfoVc.userSalaryTableData = self.userSalaryTableData
        
        print("row", self.userSalaryTableData)
        print(self.userCurrentSalary!)
        print("h2o", self.userJobTableData)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: UiConstants.SegueIdentifiers.USER_JOB_INFO_SEGUE, sender: self)
        }
        
    }
    
    func setActivityIndicatorVisibility(show: Bool) {
        self.spinnerView.isHidden = !show
        if show {
            self.spinnerView.startAnimating()
        } else {
            self.spinnerView.stopAnimating()
        }
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.userJobInfoViewContainer.alpha = 0
            self.userInfoViewContainer.alpha = 1
            
        } else if sender.selectedSegmentIndex == 1 {
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
        else if segue.identifier == UiConstants.SegueIdentifiers.USER_JOB_INFO_SEGUE {
            let destination = segue.destination as! UserJobInfoViewController
            destination.userJobTableData = self.userJobTableData
            destination.userSalaryTableData = self.userSalaryTableData
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
        isLoggedInUser ?? true ? employeeSalaryDetailsServiceManager.getEmployeeSalaryDetailsById(employeeId: "02713", self) : employeeSalaryDetailsServiceManager.getEmployeeSalaryDetailsById(employeeId: self.employeeId!, self)
    }
    
    func getEmployeeSalaryInfo(employeeSalaries: [EmployeeSalaryDetailsData]) {
        setUserSalaryInfo(userSalaryTableData: employeeSalaries)
    }
    
    func onFailier() {
        setActivityIndicatorVisibility(show: false)
    }
    
}


