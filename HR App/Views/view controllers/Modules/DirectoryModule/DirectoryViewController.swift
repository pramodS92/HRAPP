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
    var departmentData: [DepartmentData] = []
    var employeeList: [BranchEmployeeData] = []
    
    var _tableData: [Any] = []
    
    
    var requestHandler: ((_ text: String)->())?
    
    var branchName: String?
    var departmemtId: String?
    var selectedCategory: String?
    var isTyping: Bool = false
    
    var employeeDetailsVc = BranchEmployeeDetailsViewController()
    var serviceManager: DirectoryServiceManager = DirectoryServiceManager()
    
    
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
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_BRANCH
        case .department:
            requestHandler = getDepartmentNameList
            self.requestHandler!("")
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_DEPARTMENT
        case .employee:
            requestHandler = getEmployeeList
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_EMPLOYEE_PLACEHOLDER
        default:
            requestHandler = getBranchNameList
            placeHolder = KeyCostants.DirectoryCategory.DIRECTORY_CATEGORY_BRANCH
        }
        
        self.searchTextFiled.text = ""
        self.searchTextFiled.placeholder = placeHolder
        self.setCategoryitemsVisibility ()
        self._tableData.removeAll()
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
                cell.selectionStyle = .none
            }
            return cell
            
        case .employee:
            let cell = derectoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.EMPLOYEE_ITEM_CELL, for: indexPath) as! EmployeeTableViewCell
            
            if let employeeData = _tableData[indexPath.row] as? BranchEmployeeData {
                cell.employeeName.text = employeeData.name!.condensed + " (" + employeeData.knownName! + ") "
                cell.employeeDesignation.text = employeeData.designation
                cell.employeeBranch.text = employeeData.branch
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
    
    func getEmployeeList(text: String) {
        self.setActivityIndicatorVisibility(show: true)
        self.getEmployeeNames(text: text)
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
    
    internal func getEmployeeNames(text: String){
        serviceManager.getEmployeeNameList(text: text, self)
    }
    
    func onSuccessBranchNameList(response: [String]) {
        setTableData(data: response)
    }
    
    func onSuccessDepartmentNameList(response: [DepartmentData]) {
        setTableData(data: response)
    }
    
    func onSuccessEmployeeNameList(response: [BranchEmployeeData]) {
        setTableData(data: response)
    }
    
    func onFailier() {
        self.setActivityIndicatorVisibility(show: false)
    }
    
}
