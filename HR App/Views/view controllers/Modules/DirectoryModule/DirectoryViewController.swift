//
//
// DirectoryViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/22/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit

class DirectoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var categoryItems: [UIButton]!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var derectoryTableView: UITableView!
    @IBOutlet weak var selectcategoryBtn: UIButton!
    @IBOutlet weak var searchTextFiled: UITextField!
    @IBOutlet weak var serchBarContainerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //var sections : [(index: Int, length :Int, title: String)] = Array()
    
    
    let TEXT_FIELD_CONER_RADIUS = 10.0
    let TEXT_FIELD_BORDER_WIDTH = 1.0
    var tableData: [String] = []

    
    var _tableData: [Any] = []
    var _serendibFinanceTableData: [Any] = []
    
    var requestHandler: ((_ text: String)->())?
    
    var categoryNo: Int = 0
    var branchName: String?
    var regionalOfficeName: String?
    var exchangeOfficeName: String?
    var departmemtId: String?
    var specialLocationId: String?
    var regionalOfficeId: String?
    var exchangeOfficeId: String?
    var coporateManagementEmployeeId: String?
    var selectedCategory: String?
    var isTyping: Bool = false
    var infoTitles = [String]()
    
    var employeeDetailsVc = BranchEmployeeDetailsViewController()
    var serviceManager: DirectoryServiceManager = DirectoryServiceManager()
    var coporateManagementServiceManager: CoporateManagementDetailsService = CoporateManagementDetailsService()
    
    let viewSecretaryInfobutton: UIButton = {
            let btn = UIButton()
            btn.setTitle("Secretary Info", for: .normal)
            btn.backgroundColor = .systemPink
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            return btn
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUiProps()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func initUiProps() {
        
        self.setUiProps()
        
        let nib = UINib(nibName: UiConstants.ViewCellId.DIRECTORY_ITEM_CELL, bundle: nil)
        derectoryTableView.register(nib, forCellReuseIdentifier: UiConstants.ViewCellId.DIRECTORY_ITEM_CELL)
        
        let employeeNib = UINib(nibName: UiConstants.ViewCellId.EMPLOYEE_ITEM_CELL, bundle: nil)
        derectoryTableView.register(employeeNib, forCellReuseIdentifier: UiConstants.ViewCellId.EMPLOYEE_ITEM_CELL)
        
        self.requestHandler = self.getBranchNameList
        self.requestHandler!("")
        
        employeeDetailsVc = self.storyboard?.instantiateViewController(withIdentifier:  UiConstants.StrotyBoardId.BRANCH_EMPLOYEE_DETAILS_VC) as! BranchEmployeeDetailsViewController
        selectedCategory = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_BRANCH
    }
    
    
    func setUiProps() {
        derectoryTableView.delegate = self
        derectoryTableView.dataSource = self
        
        self.view.bringSubviewToFront(categoryStackView)
        self.view.sendSubviewToBack(derectoryTableView)
        self.hideLoginKeyboardWhenTappedAround()
        self.activityIndicator.isHidden = true
        
        self.serchBarContainerView.layer.borderWidth = CGFloat(TEXT_FIELD_BORDER_WIDTH)
        self.serchBarContainerView.layer.cornerRadius = CGFloat(TEXT_FIELD_CONER_RADIUS)
        self.searchTextFiled.placeholder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_BRANCH
        
        self.selectcategoryBtn.setTitle(KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_BRANCH, for: .normal)
        
    }
    
    
    @IBAction func handleCategorySelection(_ sender: UIButton) {
        self.setCategoryitemsVisibility ()
    }
    
    
    func setCategoryitemsVisibility () {
        categoryItems.forEach { (button) in
            UIView.animate(withDuration: 0.3) {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @IBAction func searchTextEdited(_ sender: UITextField) {
        
        self.requestHandler!(sender.text!)
        
        if sender.text! == ""{
            self.isTyping = false
            self._tableData.removeAll()
           // self.employeeList.removeAll()
        }
        self.isTyping = true
        self.derectoryTableView.reloadData()
    }
    
    
    
    @IBAction func categoryItemTapped(_ sender: UIButton) {
        var placeHolder: String?
        guard let category = sender.currentTitle, let categoryType = Category(rawValue: category)  else {
            return
        }
        self.selectcategoryBtn.setTitle(categoryType.rawValue,for: .normal)
        self.selectedCategory = categoryType.rawValue
        
        
        //Default Branch
        switch categoryType {
        case .branch:
            requestHandler = getBranchNameList
            self.requestHandler!("")
            searchTextFiled.isEnabled = true
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_BRANCH
        case .department:
            requestHandler = getDepartmentNameList
            self.requestHandler!("")
            searchTextFiled.isEnabled = true
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_DEPARTMENT
        case .co_management:
            requestHandler = getCoporateManagementNameList
            self.requestHandler!("")
            searchTextFiled.isEnabled = false
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_COP_MANAGEMENT
        case .ex_office:
            requestHandler = getExchangeOfficeNameList
            self.requestHandler!("")
            searchTextFiled.isEnabled = true
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_EX_OFFICE
        case .reg_office:
            requestHandler = getRegionalOfficeNameList
            self.requestHandler!("")
            searchTextFiled.isEnabled = false
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_REG_OFFICE
        case .serandib:
            requestHandler = getSerendibFinanceNameList
            self.requestHandler!("")
            searchTextFiled.isEnabled = false
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_SPECIAL_LOCATIONS
        case .special_office:
            requestHandler = getSpecialOfficeNameList
            self.requestHandler!("")
            searchTextFiled.isEnabled = true
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_SPECIAL_LOCATIONS
        case .employee:
            requestHandler = getEmployeeList
            searchTextFiled.isEnabled = true
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_EMPLOYEE_PLACEHOLDER
        default:
            requestHandler = getBranchNameList
            searchTextFiled.isEnabled = true
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_BRANCH
        }
        
        self.searchTextFiled.text = ""
        self.searchTextFiled.placeholder = placeHolder
        self.setCategoryitemsVisibility ()
        self._tableData.removeAll()
        self._serendibFinanceTableData.removeAll()
        self.derectoryTableView.reloadData()
    }
    
    func setActivityIndicatorVisibility(show: Bool) {
        self.activityIndicator.isHidden = !show
        if show {
            self.activityIndicator.startAnimating()
        }else {
            self.derectoryTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self._tableData.count == nil ? 1: self._tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Category(rawValue: selectedCategory!){
        case .branch:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.DIRECTORY_ITEM_CELL, for: indexPath) as! DirectoryTableViewCell
            cell.direcaryItemLabel.text = _tableData[indexPath.row] as? String
            cell.selectionStyle = .none
            return cell
            
        case .department:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.DIRECTORY_ITEM_CELL, for: indexPath) as! DirectoryTableViewCell
            if let departmantData = _tableData[indexPath.row] as? DepartmentData{
                cell.direcaryItemLabel.text = departmantData.departmentName
            }
            cell.selectionStyle = .none
            return cell
            
        case .special_office:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.DIRECTORY_ITEM_CELL, for: indexPath) as! DirectoryTableViewCell
            if let specicalOfficeData = _tableData[indexPath.row] as? SpecialLocationData{
                cell.direcaryItemLabel.text = specicalOfficeData.locationName
            }
            cell.selectionStyle = .none
            return cell
            
        case .co_management:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.EMPLOYEE_ITEM_CELL, for: indexPath) as! EmployeeTableViewCell
            if let employeeData = _tableData[indexPath.row] as? CoporateManagementData {
                cell.employeeName.text = employeeData.name!.condensed + " (" + employeeData.knownName! + ") "
                cell.employeeDesignation.text = employeeData.designation
                cell.employeeBranch.text = " "
                cell.selectionStyle = .none
            }
            return cell
            
        case .ex_office:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.DIRECTORY_ITEM_CELL, for: indexPath) as! DirectoryTableViewCell
            if let exchangeOfficeData = _tableData[indexPath.row] as? ExchangeOfficeData {
                cell.direcaryItemLabel.text = exchangeOfficeData.departmentName
            }
            cell.selectionStyle = .none
            return cell
            
        case .reg_office:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.DIRECTORY_ITEM_CELL, for: indexPath) as! DirectoryTableViewCell
            if let regionalOfficeData = _tableData[indexPath.row] as? RegionalOfficeData{
                cell.direcaryItemLabel.text = regionalOfficeData.regionalOffice
            }
            cell.selectionStyle = .none
            return cell
            
        case .serandib:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.DIRECTORY_ITEM_CELL, for: indexPath) as! DirectoryTableViewCell
            if let serandibFinanceData = _tableData[indexPath.row] as? SerendibFinanceDataClass {
                cell.direcaryItemLabel.text = serandibFinanceData.departmentName
            }
            cell.selectionStyle = .none
            return cell
            
        case .employee:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.EMPLOYEE_ITEM_CELL, for: indexPath) as! EmployeeTableViewCell
            if let employeeData = _tableData[indexPath.row] as? BranchEmployeeData {
                cell.employeeName.text = employeeData.name!.condensed + " (" + employeeData.knownName! + ") "
                cell.employeeDesignation.text = employeeData.designation
                cell.employeeBranch.text = employeeData.branch
                cell.employeeImage.image = UIImage(named: employeeData.gender == "M" ? "ic_person": "ic_women")
                cell.selectionStyle = .none
            }
            return cell
            
        default:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.DIRECTORY_ITEM_CELL, for: indexPath) as! DirectoryTableViewCell
            cell.direcaryItemLabel.text = _tableData[indexPath.row] as? String
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Category(rawValue: selectedCategory!)  {
        case .branch:
            self.branchName = _tableData[indexPath.row] as? String
            performSegue(withIdentifier: UiConstants.SegueIdentifiers.DIRECTORY_BRANCH_SEGUE, sender: self)
        case .department:
            let depInfo = _tableData[indexPath.row] as! DepartmentData
            self.departmemtId = depInfo.departmentID
            self.infoTitles = KeyCostants.DepartmentDetails.DEPARTMENT_DETAILS_TITLES
            performSegue(withIdentifier: UiConstants.SegueIdentifiers.DIRECTORY_DEPARTMENT_SEGUE, sender: self)
        case .co_management:
            let coporateManagementInfo = _tableData[indexPath.row] as! CoporateManagementData
            self.coporateManagementEmployeeId = coporateManagementInfo.agmid
            self.getCoporateManagementDetails()
        case .ex_office:
            let exchangeOfficeInfo = _tableData[indexPath.row] as! ExchangeOfficeData
            self.exchangeOfficeName = exchangeOfficeInfo.departmentName
            self.departmemtId = exchangeOfficeInfo.departmentID
            self.infoTitles = KeyCostants.DepartmentDetails.DEPARTMENT_DETAILS_TITLES
            performSegue(withIdentifier: UiConstants.SegueIdentifiers.DIRECTORY_DEPARTMENT_SEGUE, sender: self)
        case .reg_office:
            let regOfficeInfo = _tableData[indexPath.row] as! RegionalOfficeData
            self.regionalOfficeName = regOfficeInfo.regionalOffice
            self.regionalOfficeId = regOfficeInfo.regionalOfficeIDs
            self.infoTitles = KeyCostants.RegionalOfficeDetails.REGIONAL_OFFICE_DETAILS_TITLES
            self.categoryNo = 5
            performSegue(withIdentifier: UiConstants.SegueIdentifiers.DIRECTORY_DEPARTMENT_SEGUE, sender: self)
        case .serandib:
            let serendibInfo = _tableData[indexPath.row] as! SerendibFinanceDataClass
            self.departmemtId = serendibInfo.departmentID
            self.infoTitles = KeyCostants.DepartmentDetails.DEPARTMENT_DETAILS_TITLES
            performSegue(withIdentifier: UiConstants.SegueIdentifiers.DIRECTORY_DEPARTMENT_SEGUE, sender: self)
        case .special_office:
            let specialLocationInfo = _tableData[indexPath.row] as? SpecialLocationData
            self.specialLocationId = specialLocationInfo?.locationID
            self.categoryNo = 7
            self.infoTitles = KeyCostants.SpecialOfficeDetails.SPECIAL_OFFICE_DETAILS_TITLES
            performSegue(withIdentifier: UiConstants.SegueIdentifiers.DIRECTORY_DEPARTMENT_SEGUE, sender: self)
        case .employee:
            self.getEmployeeInfo(info: _tableData[indexPath.row] as! BranchEmployeeData)
        default:
            performSegue(withIdentifier: UiConstants.SegueIdentifiers.DIRECTORY_BRANCH_SEGUE, sender: self)
        }
    }
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return sections.count
    //    }
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return sections[section].title
    //    }
    //    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //        return sections.map { $0.title }
    //    }
    //    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
    //        return index
    //    }
    
    func getEmployeeInfo(info: BranchEmployeeData){
        employeeDetailsVc.modalPresentationStyle = .overCurrentContext
        employeeDetailsVc.employeeDetails = info
        self.present(employeeDetailsVc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case UiConstants.SegueIdentifiers.DIRECTORY_BRANCH_SEGUE:
            let destination = segue.destination as! BranchDetailsViewController
            destination.branchName =  self.branchName
        case UiConstants.SegueIdentifiers.DIRECTORY_DEPARTMENT_SEGUE:
            let destination = segue.destination as! DepartmentViewController
            destination.departmemtId = self.departmemtId
            destination.specialLocationId = self.specialLocationId
            destination.regionalOfficeId = self.regionalOfficeId
            destination.infoTitle = self.infoTitles
            destination.categoryNo = self.categoryNo
        default:
            let destination1 = segue.destination as! BranchDetailsViewController
        }
    }
    
    func setTableData(data: [Any]) {
        _tableData.removeAll()
        self.setActivityIndicatorVisibility(show: false)
        _tableData = data
        
        //        if !self.isTyping {
        //            tableData.sort { $0 < $1 }
        //            sections.removeAll()
        //            var index = 0;
        //            for (i, element) in tableData.enumerated() {
        //                let commonPrefix = element.shared_prefix(with:tableData[index])
        //
        //                if (commonPrefix.count == 0) {
        //                    let string = tableData[index].uppercased()
        //                    let firstCharacter = string[string.startIndex]
        //                    let title = "\(firstCharacter)"
        //                    let newSection = (index: index, length: i - index, title: title)
        //                    sections.append(newSection)
        //                    index = i;
        //                }
        //            }
        //        }
        self.derectoryTableView.reloadData()
    }
    
    func setDepartmentTableData(data: [DepartmentData]){
        _tableData.removeAll()
        self.setActivityIndicatorVisibility(show: false)
        _tableData = data
        self.derectoryTableView.reloadData()
    }
    
    func setEmployeeTableData(data: [BranchEmployeeData]) {
        _tableData.removeAll()
        self.setActivityIndicatorVisibility(show: false)
        _tableData = data
        self.derectoryTableView.reloadData()
    }
    
    func getBranchNameList(text: String) {
        self.setActivityIndicatorVisibility(show: true)
        self.getBranchNames(text: text)
    }
    
    func getDepartmentNameList(text: String) {
        self.setActivityIndicatorVisibility(show: true)
        self.getDepartmentNames(text: text)
    }
    
    func getCoporateManagementNameList(text: String) {
        self.setActivityIndicatorVisibility(show: true)
        self.getCoporateManagementNames(text: text)
    }
    
    func getExchangeOfficeNameList(text: String) {
        self.setActivityIndicatorVisibility(show: true)
        self.getExchangeOfficeNames(text: text)
    }
    
    func getRegionalOfficeNameList(text: String) {
        self.setActivityIndicatorVisibility(show: true)
        self.getRegionalOfficeNames(text: text)
    }
    
    func getSerendibFinanceNameList(text: String) {
        self.setActivityIndicatorVisibility(show: true)
        self.getSerendibOfficeNames(text: text)
    }
    
    func getSpecialOfficeNameList(text: String) {
        self.setActivityIndicatorVisibility(show: true)
        self.getSpecialOfficeNames(text: text)
    }
    
    func getEmployeeList(text: String) {
        self.setActivityIndicatorVisibility(show: true)
        self.getEmployeeNames(text: text)
    }
    
    func getCoporateManagementDetails() {
        self.getCoporateManagementDetails(employeeId: coporateManagementEmployeeId!)
    }
    
}

extension Collection where Element: Equatable {
    func shared_prefix( with other: Self ) -> SubSequence {
        var a = dropLast(0), b = other.dropLast(0)
        while !(a.isEmpty || b.isEmpty)
                && (a.first == b.first) {
            ( a, b ) = ( a.dropFirst(), b.dropFirst() )
        }
        return dropLast( a.count )
    }
}

extension DirectoryViewController: OnSuccessUserDirectory {
    
    internal func getBranchNames(text: String){
        serviceManager.getBranchNameList(text: text, self)
    }
    
    internal func getDepartmentNames(text: String){
        serviceManager.getDepartmentNameList(text: text, self)
    }
    
    internal func getCoporateManagementNames(text: String) {
        serviceManager.getCoporateManagementList(text: text, self)
    }
    
    internal func getExchangeOfficeNames(text: String) {
        serviceManager.getExchangeOfficeNameList(text: text, self)
    }
    
    internal func getRegionalOfficeNames(text: String) {
        serviceManager.getRegionalOfficeNameList(text: text, self)
    }
    
    internal func getSerendibOfficeNames(text: String) {
        serviceManager.getSerendibFinanceNameList(text: text, self)
    }
    
    internal func getEmployeeNames(text: String){
        serviceManager.getEmployeeNameList(text: text, self)
    }
    
    internal func getSpecialOfficeNames(text: String) {
        serviceManager.getSpecialLocationNameList(text: text, self)
    }
    
    func onSuccessBranchNameList(response: [String]) {
        setTableData(data: response)
    }
    
    func onSuccessDepartmentNameList(response: [DepartmentData]) {
        setTableData(data: response)
    }
    
    func onSuccessCoporateManagementList(response: [CoporateManagementData]) {
        setTableData(data: response)
    }
    
    func onSuccessExchangeOfficeNameList(response: [ExchangeOfficeData]) {
        setTableData(data: response)
    }
    
    func onSuccessRegionalOfficeNameList(response: [RegionalOfficeData]) {
        setTableData(data: response)
    }
    
    func onSuccessSerendibFinanceNameList(response: SerendibFinanceDataClass) {
        _serendibFinanceTableData.append(response)
        setTableData(data: _serendibFinanceTableData)
    }
    
    func onSuccessSpecialLocationNameList(response: [SpecialLocationData]) {
        setTableData(data: response)
    }
    
    func onSuccessEmployeeNameList(response: [BranchEmployeeData]) {
        setTableData(data: response)
    }
    
    func onFailier() {
        self.setActivityIndicatorVisibility(show: false)
    }
    
}

extension DirectoryViewController: onSuccessCoporateManagementDetails {
    
    internal func getCoporateManagementDetails(employeeId: String) {
        coporateManagementServiceManager.getCoporateManagementDetailsById(employeeId: employeeId, self)
    }
    
    func getCoporateManagementInfo(coporateManagementEmployeeName: String, coporateManagementInfo: [String], coporateManagemenData: BranchEmployeeData) {
        getEmployeeInfo(info: coporateManagemenData)
    }
    
}
