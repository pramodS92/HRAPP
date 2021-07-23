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
    var regionalOfficeId: String?
    let labelFontSize: CGFloat = 10.0
    var specialLocationEmployeeCount: Int? = 0
    var infoTitle = [String]()
    var departmentEmployeeList: [BranchEmployeeData] = []
    var specialLocationEmployeeList: [BranchEmployeeData]? = []
    var specialLocationData: SpecialLocationDataClass?
    var specialLocationEmployeeIdList: [String] = []
    var serviceManager: DepartmentDetailsServiceManager = DepartmentDetailsServiceManager()
    var specialLocationServiceManager: SpecialLocationDetailsServiceManager = SpecialLocationDetailsServiceManager()
    var regionalOfficeServiceManager: RegionalOfficeDetailsServiceManager = RegionalOfficeDetailsServiceManager()
    var userProfileServiceManager: UserProfileServiceManager = UserProfileServiceManager()
    var employeeDetailsVc = BranchEmployeeDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUiProps()
        
        self.getCorrectDetails(categoryNo: categoryNo!)
    }
    
    func getCorrectDetails(categoryNo: Int) {
        if (categoryNo == 5) {
            self.getRegionalOfficeDetails()
        } else if (categoryNo == 7) {
            self.getSpecialLocationDetails()
        } else if (categoryNo == 0){
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
    
    func getRegionalOfficeDetails() {
        setActivityIndicatorVisibility(show: true)
        self.getRegionalOfficeDetails(regionalOfficeId: regionalOfficeId!)
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
    
    func setSpecialLocationDetails(specialLocationData: SpecialLocationDataClass) {
        self.specialLocationData = specialLocationData
        if (specialLocationData.designationOne != "" && specialLocationData.designationTwo != "") {
            specialLocationEmployeeCount = 2
        } else if (specialLocationData.designationOne != "" && specialLocationData.designationTwo == "") {
            specialLocationEmployeeCount = 1
        } else if (specialLocationData.designationOne == "") {
            specialLocationEmployeeCount = 0
        }
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
        if categoryNo != 7 {
            return departmentEmployeeList.count
        }
        return specialLocationEmployeeCount!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = departmentDetailsTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.BRANCH_EMPLOYEE_DETAIL_CELL, for: indexPath) as! BranchEmployeeTableViewCell
        cell.selectionStyle = .none
        
        if (categoryNo == 0 || categoryNo == 5) {
            cell.branchEmployeeDesignation.text = self.departmentEmployeeList[indexPath.row].designation
            cell.branchEmployeeName.text = self.departmentEmployeeList[indexPath.row].name!.condensed  + " (" + self.departmentEmployeeList[indexPath.row].knownName!.uppercased() + ")"
            cell.branchEmployeeImageView.image = UIImage(named: self.departmentEmployeeList[indexPath.row].gender == "M" ? "ic_person": "ic_women")
        } else if (categoryNo == 7) {
            if indexPath.row == 0 {
                cell.branchEmployeeDesignation.text = self.specialLocationData?.designationOne
                cell.branchEmployeeName.text = (self.specialLocationData?.nameOne!.condensed)!
                cell.branchEmployeeImageView.image = UIImage(named: self.specialLocationData?.nameOne?.prefix(3) == "Mrs" ? "ic_women": "ic_person")
            } else if (indexPath.row == 1) {
                cell.branchEmployeeDesignation.text = self.specialLocationData?.designationTwo
                cell.branchEmployeeName.text = (self.specialLocationData?.nameTwo!.condensed)!
                cell.branchEmployeeImageView.image = UIImage(named: self.specialLocationData?.nameTwo?.prefix(3) == "Mrs" ? "ic_women": "ic_person")
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (categoryNo == 0 || categoryNo == 5) {
            employeeDetailsVc.modalPresentationStyle = .fullScreen
            employeeDetailsVc.employeeDetails = self.departmentEmployeeList[indexPath.row]
            employeeDetailsVc.categoryNo = self.categoryNo!
            self.present(employeeDetailsVc, animated: true, completion: nil)
        } else if (categoryNo == 7) {
            employeeDetailsVc.modalPresentationStyle = .fullScreen
            employeeDetailsVc.specialLocationEmployeeDetails = specialLocationData
            employeeDetailsVc.specialLocationEmployeeCount = self.specialLocationEmployeeCount
            employeeDetailsVc.categoryNo = self.categoryNo!
            self.present(employeeDetailsVc, animated: true, completion: nil)
            print("special Location Employee")
        }
        
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
    
    func getSpecialLocationInfo(specialLocationName: String, specialLocationInfo: [String], specialLocationData: SpecialLocationDataClass) {
        setDepartmentName(deptName: specialLocationName)
        setDepartmentDetails(data: specialLocationInfo)
        setSpecialLocationDetails(specialLocationData: specialLocationData)
//        setDepartmentEmployeeList(employeeList: specialLocationEmployeeList!)
    }
    
}

extension DepartmentViewController: onSuccessRegionalOfficeDetails {
    
    internal func getRegionalOfficeDetails(regionalOfficeId: String) {
        regionalOfficeServiceManager.getRegionalOfficeDetailsById(regionalOfficeId: regionalOfficeId, self)
    }
    
    func getRegionalOfficeInfo(regionalOffice: String, regionalOfficeInfo: [String], regionalOfficeEmployeeList: [BranchEmployeeData]) {
        setDepartmentName(deptName: regionalOffice)
        setDepartmentDetails(data: regionalOfficeInfo)
        setDepartmentEmployeeList(employeeList: regionalOfficeEmployeeList)
    }
    
}

extension DepartmentViewController: OnSuccessUserProfile {
    func getUserData(userData: BranchEmployeeData) {
        specialLocationEmployeeList?.append(userData)
        setDepartmentEmployeeList(employeeList: specialLocationEmployeeList!)
//        addSpecialLocationEmployees(employee: userData)
    }
    
    
    internal func getEmployeeById(employeeId: String) {
        userProfileServiceManager.getEmployeeDetailsById(employeeId: employeeId, self)
    }

    func OnSuccessUserProfile(userInfo: [String], userTabelData: [String]) {
        
    }
    
}
