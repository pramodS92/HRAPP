//
//  RegionalOfficeViewController.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-16.
//

import UIKit

class RegionalOfficeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var regionalOfficeDetailTitle: [UILabel]!
    @IBOutlet var regionalOfficeDetailsInfo: [UILabel]!
    @IBOutlet var regionalOfficeNameLabel: UILabel!
    @IBOutlet var regionalOfficeEmployeeTableView: UITableView!
    @IBOutlet var regionalOfficeDetailsContainerView: UIView!
    @IBOutlet var regionalOfficeDetailsStackView: UIStackView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var regionalOfficeId: String!
    var regionalOfficeName: String!
    var regionalOfficeData = [String]()
    
    let labelFontSize: CGFloat = 10.0
    var regionalOfficeEmployeeList = [BranchEmployeeData]()
    var serviceManager: RegionalOfficeDetailsServiceManager = RegionalOfficeDetailsServiceManager()
    var employeeDetailsVc = BranchEmployeeDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUiProps()
        self.getRegionalOfficeDetails()
    }
    
    func initUiProps() {
        self.activityIndicator.isHidden = true
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.3650507331, blue: 0.738835156, alpha: 1)
        self.regionalOfficeDetailsContainerView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        self.regionalOfficeDetailsContainerView.layer.borderWidth = 1
        self.regionalOfficeDetailsContainerView.layer.cornerRadius = 6
        
        let nib = UINib(nibName: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL, bundle: nil)
        regionalOfficeEmployeeTableView.register(nib, forCellReuseIdentifier: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL)
        
        regionalOfficeEmployeeTableView.delegate = self
        regionalOfficeEmployeeTableView.dataSource = self
        
        employeeDetailsVc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.BRANCH_EMPLOYEE_DETAILS_VC) as! BranchEmployeeDetailsViewController
        
        self.setUiPropTitles()
    }
    
    func setUiPropTitles() {
        self.regionalOfficeDetailTitle.enumerated().forEach { (index, element) in
            element.font = element.font.withSize(labelFontSize)
            element.text = KeyCostants.RegionalOfficeDetails.REGIONAL_OFFICE_DETAILS_TITLES[index]
        }
    }
    
    func getRegionalOfficeDetails() {
        setActivityIndicatorVisibility(show: true)
        self.getRegionalOfficeDetails(regionalOfficeId: regionalOfficeId!)
    }
    
    func setRegionalOfficeName(regionalOfficeName: String) {
        regionalOfficeNameLabel.text = regionalOfficeName
    }
    
    func setRegionalOfficeDetails(data: [String]) {
        self.regionalOfficeDetailsInfo.enumerated().forEach { (index, element) in
            element.font = element.font.withSize(labelFontSize)
            element.text = data[index]
        }
    }
    
    func setRegionalOfficeEmployeeList(employeeList: [BranchEmployeeData]) {
        regionalOfficeEmployeeList = employeeList
        setActivityIndicatorVisibility(show: false)
    }
    
    func setActivityIndicatorVisibility(show: Bool) {
        self.activityIndicator.isHidden = !show
        if show {
            self.activityIndicator.startAnimating()
        }else {
            self.regionalOfficeEmployeeTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionalOfficeEmployeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = regionalOfficeEmployeeTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL, for: indexPath) as! BranchEmployeeTableViewCell
        cell.selectionStyle = .none
        cell.branchEmployeeDesignation.text = self.regionalOfficeEmployeeList[indexPath.row].designation
        cell.branchEmployeeName.text = self.regionalOfficeEmployeeList[indexPath.row].name!.condensed  + " (" + self.regionalOfficeEmployeeList[indexPath.row].knownName!.uppercased() + ")"
        cell.branchEmployeeImageView.image = UIImage(named: self.regionalOfficeEmployeeList[indexPath.row].gender == "M" ? "ic_person": "ic_women")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeDetailsVc.modalPresentationStyle = .fullScreen
        employeeDetailsVc.employeeDetails = self.regionalOfficeEmployeeList[indexPath.row]
        self.present(employeeDetailsVc, animated: true, completion: nil)
    }

}


extension RegionalOfficeViewController: onSuccessRegionalOfficeDetails {
    
    internal func getRegionalOfficeDetails(regionalOfficeId: String) {
        serviceManager.getRegionalOfficeDetailsById(regionalOfficeId: regionalOfficeId, self)
    }
    
    func getRegionalOfficeInfo(regionalOffice: String, regionalOfficeInfo: [String], regionalOfficeEmployeeList: [BranchEmployeeData]) {
        setRegionalOfficeName(regionalOfficeName: regionalOffice)
        setRegionalOfficeDetails(data: regionalOfficeInfo)
        setRegionalOfficeEmployeeList(employeeList: regionalOfficeEmployeeList)
    }
    
    func OnFailier() {
        setActivityIndicatorVisibility(show: false)
    }
    
}
