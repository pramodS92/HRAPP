//
//
// UserInfoViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/20/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import UIKit

class UserJobInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userJobInfoTableView: UITableView!
    @IBOutlet weak var userTransferHistoryTableView: UITableView!
    @IBOutlet var userJobInfoTableTitles: [UILabel]!
    @IBOutlet weak var currentSalaryLabel: UILabel!
    @IBOutlet weak var previousSalaryHistoryView: UIView!
    @IBOutlet weak var currentSalaryView: UIView!
    
    var userJobTableData: [String]?
    var userSalaryTableData: [EmployeeSalaryDetailsData]!
    var userTransferHistoryTableData: [EmployeeTransferHistoryData]!
    var currentSalary: String?
    var isLoggedInUser: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: UiConstants.ViewCellId.USER_JOB_INFO_CELL, bundle: nil)
        userTransferHistoryTableView.register(nib, forCellReuseIdentifier: UiConstants.ViewCellId.USER_JOB_INFO_CELL)
        userTransferHistoryTableView.register(UserTransferHistoryHeader.self, forHeaderFooterViewReuseIdentifier: UiConstants.ViewCellId.USER_TRANSFER_HISTORY_HEADER_CELL)
        let previousSalaryNib = UINib(nibName: UiConstants.ViewCellId.PREVIOUS_SALARY_TITLE_CELL, bundle: nil)
        userJobInfoTableView.register(previousSalaryNib, forCellReuseIdentifier: UiConstants.ViewCellId.PREVIOUS_SALARY_TITLE_CELL)
        userJobInfoTableView.register(UserJobInfoHeader.self, forHeaderFooterViewReuseIdentifier: UiConstants.ViewCellId.USER_JOB_INFO_HEADER_CELL)
        let transferHistoryNib = UINib(nibName: UiConstants.ViewCellId.USER_TRANSFER_HISTORY_CELL, bundle: nil)
        userTransferHistoryTableView.register(transferHistoryNib, forCellReuseIdentifier: UiConstants.ViewCellId.USER_TRANSFER_HISTORY_CELL)
        userJobInfoTableView.delegate = self
        userJobInfoTableView.dataSource = self
        userTransferHistoryTableView.delegate = self
        userTransferHistoryTableView.dataSource = self
        
        print("yea", self.userJobTableData!)
        print("no", self.userSalaryTableData!)
        print("yep", self.userTransferHistoryTableData!)
        self.setupUi()
        self.hidePreviousSalaryHistoryView()
    }
    
    func setupUi() {
        setUserJobInfoTitles()
        currentSalaryLabel.text = self.currentSalary
    }
    
    func hidePreviousSalaryHistoryView() {
        
        if isLoggedInUser == false {
            previousSalaryHistoryView.isHidden = true
            currentSalaryView.isHidden = true
        } else {
            previousSalaryHistoryView.isHidden = false
            currentSalaryView.isHidden = false
        }
    }
    
    func setUserJobInfoTitles() {
        self.userJobInfoTableTitles.enumerated().forEach { (index, element) in
            element.text = UiConstants.UserInfo.UserJobInfoTitles[index]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableCount: Int?
        
        if tableView == self.userJobInfoTableView {
            tableCount = self.userSalaryTableData.count
        } else if tableView == self.userTransferHistoryTableView {
            tableCount = self.userTransferHistoryTableData.count
        }
        return tableCount!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView: UIView?
        
        let clearView: UIView = {
           let view = UIView()
            view.backgroundColor = UIColor.clear
            return view
        }()
        
        if tableView == self.userJobInfoTableView {
            let header = userJobInfoTableView.dequeueReusableHeaderFooterView(withIdentifier: UiConstants.ViewCellId.USER_JOB_INFO_HEADER_CELL)
            headerView = header
        } else if tableView == self.userTransferHistoryTableView {
            headerView = clearView
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var tableViewCell: UITableViewCell?
        
        if tableView == self.userJobInfoTableView {
            
            let startIndex = userSalaryTableData[indexPath.row].effectiveDate.index(userSalaryTableData[indexPath.row].effectiveDate.startIndex, offsetBy: 4)
            let endIndex = userSalaryTableData[indexPath.row].effectiveDate.index(userSalaryTableData[indexPath.row].effectiveDate.endIndex, offsetBy: -2)
            let range = startIndex..<endIndex
                
                
            let effectiveYear = userSalaryTableData[indexPath.row].effectiveDate.prefix(4)
            let month = userSalaryTableData[indexPath.row].effectiveDate[range]
            let day = userSalaryTableData[indexPath.row].effectiveDate.suffix(2)
            
            let cell = userJobInfoTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.PREVIOUS_SALARY_TITLE_CELL, for: indexPath) as! PreviousSalaryTitlesTableViewCell
            cell.selectionStyle = .none
            self.userTransferHistoryTableView.separatorStyle = .none
                
            cell.effectiveDataLabel.text =  String(day) + "/" + String(month) + "/" + String(effectiveYear)
            cell.basicSalaryLabel.text = userSalaryTableData[indexPath.row].basicSalary
            cell.otLabel.text = userSalaryTableData[indexPath.row].salaryGrade
            
            tableViewCell = cell
                
        } else if tableView == self.userTransferHistoryTableView {
            
            let startIndex = userTransferHistoryTableData[indexPath.row].effectedOn.index(userTransferHistoryTableData[indexPath.row].effectedOn.startIndex, offsetBy: 4)
            let endIndex = userTransferHistoryTableData[indexPath.row].effectedOn.index(userTransferHistoryTableData[indexPath.row].effectedOn.endIndex, offsetBy: -2)
            let range = startIndex..<endIndex
            
            let year = userTransferHistoryTableData[indexPath.row].effectedOn.prefix(4)
            let month = userTransferHistoryTableData[indexPath.row].effectedOn[range]
            let day = userTransferHistoryTableData[indexPath.row].effectedOn.suffix(2)
            
            let cell = userTransferHistoryTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.USER_TRANSFER_HISTORY_CELL, for: indexPath) as! UserTransferHistoryTableViewCell
            cell.selectionStyle = .none
            
            let date = String(day) + "/" + String(month) + "/" + String(year)
            
            cell.designation.text = userTransferHistoryTableData[indexPath.row].designation
            cell.date.text = date.condensed
            cell.branchName.text = userTransferHistoryTableData[indexPath.row].branchName
            
            tableViewCell = cell
            
        }
           
        return tableViewCell!
    }
    
}


