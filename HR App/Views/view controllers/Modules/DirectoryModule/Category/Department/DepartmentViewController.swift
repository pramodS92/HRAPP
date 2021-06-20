//
//
// DepartmentViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/24/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit

class DepartmentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var departmentName: UILabel!
    @IBOutlet var departmentInfoTitles: [UILabel]!
    @IBOutlet var departmentInfoDetails: [UILabel]!
    @IBOutlet weak var departmentDetailsContainerView: UIView!
    @IBOutlet weak var departmentDetailsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var categoryNo: Int?
    var departmemtId: String?
    var specialLocationId: String?
    let labelFontSize: CGFloat = 10.0
    var infoTitle = [String]()
    var departmentEmployeeList: [BranchEmployeeData] = []
    var serviceManager: DepartmentDetailsServiceManager = DepartmentDetailsServiceManager()
    var specialLocationServiceManager: SpecialLocationDetailsServiceManager = SpecialLocationDetailsServiceManager()
    var employeeDetailsVc = BranchEmployeeDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUiProps()
        
        self.getCorrectDetails(categoryNo: categoryNo!)
    }
    
    func getCorrectDetails(categoryNo: Int) {
        if (categoryNo == 5) {
            
        } else if (categoryNo == 7) {
            self.getSpecialLocationDetails()
        } else {
            self.getDepartmentDetails()
        }
        
    }
    
    func setupUiProps(){
        self.departmentDetailsContainerView.layer.cornerRadius = 8
        self.departmentDetailsContainerView.layer.borderWidth = 1
        self.departmentDetailsContainerView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        let nib = UINib(nibName: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL, bundle: nil)
        departmentDetailsTableView.register(nib, forCellReuseIdentifier: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL)
        
        employeeDetailsVc = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.BRANCH_EMPLOYEE_DETAILS_VC) as! BranchEmployeeDetailsViewController
        
        departmentDetailsTableView.delegate = self
        departmentDetailsTableView.dataSource = self
        self.activityIndicator.isHidden = true
        self.departmentInfoTitles.enumerated().forEach { (index, element) in
            element.font = UIFont.boldSystemFont(ofSize: labelFontSize)
            element.text = infoTitle[index]
        }
    }
    
    func getDepartmentDetails(){
        setActivityIndicatorVisibility(show: true)
        self.getDepartmentDetails(departmentId: departmemtId!)
    }
    
    func getSpecialLocationDetails() {
        setActivityIndicatorVisibility(show: true)
        self.getSpecialLocationDetails(locationId: specialLocationId!)
    }
    
    func setDepartmentName(deptName: String){
        departmentName.text = deptName
    }
    
    func setDepartmentDetails(data: [String]){
        self.departmentInfoDetails.enumerated().forEach { (index, element) in
            element.font = element.font.withSize(labelFontSize)
            element.text = data[index]
        }
    }
    
    func setDepartmentEmployeeList(employeeList: [BranchEmployeeData]){
        departmentEmployeeList = employeeList
        setActivityIndicatorVisibility(show: false)
    }
    
    func setActivityIndicatorVisibility(show: Bool) {
        self.activityIndicator.isHidden = !show
        if show {
            self.activityIndicator.startAnimating()
        }else {
            self.departmentDetailsTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentEmployeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = departmentDetailsTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL, for: indexPath) as! BranchEmployeeTableViewCell
        cell.selectionStyle = .none
        cell.branchEmployeeDesignation.text = self.departmentEmployeeList[indexPath.row].designation
        cell.branchEmployeeName.text = self.departmentEmployeeList[indexPath.row].name!.condensed  + " (" + self.departmentEmployeeList[indexPath.row].knownName!.uppercased() + ")"
        cell.branchEmployeeImageView.image = UIImage(named: self.departmentEmployeeList[indexPath.row].gender == "M" ? "ic_person": "ic_women")
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeDetailsVc.modalPresentationStyle = .fullScreen
        employeeDetailsVc.employeeDetails = self.departmentEmployeeList[indexPath.row]
        self.present(employeeDetailsVc, animated: true, completion: nil)
    }
    
}


extension DepartmentViewController: OnSuccessDepartmentDetails {
    
    internal func getDepartmentDetails(departmentId: String){
        serviceManager.getDepartmentDetailsById(departmentId: departmentId, self)
    }
    
    func getDepartmentInfo(departmentName: String, departmentInfo: [String], departmentEmployeeList: [BranchEmployeeData]) {
        setDepartmentName(deptName: departmentName)
        setDepartmentDetails(data: departmentInfo)
        setDepartmentEmployeeList(employeeList: departmentEmployeeList)
    }
    
    func OnFailier() {
        setActivityIndicatorVisibility(show: false)
    }
    
}

extension DepartmentViewController: OnSuccessSpecialLocationDetails {
    
    internal func getSpecialLocationDetails(locationId: String) {
        specialLocationServiceManager.getSpecialLocationDetailsById(specialLocationId: locationId, self)
    }
    
    func getSpecialLocationInfo(specialLocationName: String, specialLocationInfo: [String]) {
        setDepartmentName(deptName: specialLocationName)
        setDepartmentDetails(data: specialLocationInfo)
        setDepartmentEmployeeList(employeeList: [])
    }
    
}
