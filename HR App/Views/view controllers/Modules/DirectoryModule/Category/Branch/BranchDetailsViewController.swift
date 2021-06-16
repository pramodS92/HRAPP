//
//
// BranchDetailsViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/24/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit

class BranchDetailsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var branchDetailsTitles: [UILabel]!
    
    @IBOutlet var branchDetailInfo: [UILabel]!
    
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var branchEmployeeTableView: UITableView!
    @IBOutlet weak var branchDetailsContainerView: UIView!
    @IBOutlet weak var branchDetailsStackView: UIStackView!
    
    var branchName: String!
    var brachData = [String]()
    var employeeData = [String]()
    var employeeDataList = [BranchEmployeeData]()
    
    let labelFontSize: CGFloat = 12.0
    var employeeDetailsVc = BranchEmployeeDetailsViewController()
    var serviceManager: BranchInfoServiceManager = BranchInfoServiceManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUiProps()
        self.getBranchDetails()
    }
    
    func initUiProps() {
        self.activityIndicator.isHidden = true
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.3650507331, blue: 0.738835156, alpha: 1)
        self.branchDetailsContainerView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.branchDetailsContainerView.layer.borderWidth = 1
        self.branchDetailsContainerView.layer.cornerRadius = 6
        
        let nib = UINib(nibName: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL, bundle: nil)
        branchEmployeeTableView.register(nib, forCellReuseIdentifier: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL)
        branchEmployeeTableView.delegate = self
        branchEmployeeTableView.dataSource = self
        
        employeeDetailsVc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.BRANCH_EMPLOYEE_DETAILS_VC) as! BranchEmployeeDetailsViewController
        
        self.setUiPropTitles()
    }
    
    func setUiPropTitles() {
        self.branchDetailsTitles.enumerated().forEach { (index, element) in
            element.font = element.font.withSize(labelFontSize)
            element.text = KeyCostants.BranchDetails.BRANCH_DETAILS_TITLES[index]
        }
    }
    
    
    func setUiPropInfo(info: [String],branchName: String,employeeList:  [BranchEmployeeData]) {
        self.branchEmployeeTableView.reloadData()
        branchNameLabel.text = branchName
        self.employeeDataList = employeeList
        self.branchDetailInfo.enumerated().forEach { (index, element) in
            element.font = element.font.withSize(labelFontSize)
            element.text = info[index]
        }
        setActivityIndicatorVisibility(show: false)
    }
    
    
    func getBranchDetails() {
        setActivityIndicatorVisibility(show: true)
        self.getBranchDetailInfo(text: branchName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }
    
    func setActivityIndicatorVisibility(show: Bool) {
        self.activityIndicator.isHidden = !show
        if show {
            self.activityIndicator.startAnimating()
        }else {
            self.branchEmployeeTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeDetailsVc.modalPresentationStyle = .overCurrentContext
        employeeDetailsVc.employeeDetails = self.employeeDataList[indexPath.row]
        self.present(employeeDetailsVc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeDataList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = branchEmployeeTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL, for: indexPath) as! BranchEmployeeTableViewCell
        cell.selectionStyle = .none
        cell.branchEmployeeDesignation.text = self.employeeDataList[indexPath.row].designation
        cell.branchEmployeeName.text = self.employeeDataList[indexPath.row].name!.condensed  + " (" + self.employeeDataList[indexPath.row].knownName!.uppercased() + ")"
        cell.branchEmployeeImageView.image = UIImage(named: self.employeeDataList[indexPath.row].gender == "M" ? "ic_person": "ic_women")
        return cell
    }
    
}

extension String {
    var condensed: String {
        return replacingOccurrences(of: "[\\s\n]+", with: "  ", options: .regularExpression, range: nil)
    }
    
}

extension BranchDetailsViewController: OnSuccessBranchInfo {
    
    internal func getBranchDetailInfo(text: String){
        serviceManager.getBranchInfo(branchName: text, self)
    }
    
    func getBranchInfo(response: [String], branchName: String,employeeList:  [BranchEmployeeData]) {
        self.setUiPropInfo(info: response, branchName: branchName, employeeList: employeeList)
    }
    
    func OnFailier() {
        setActivityIndicatorVisibility(show: false)
    }
    
}
