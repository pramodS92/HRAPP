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
    
    var userJobTableData: [String]?
    var userSalaryTableData: [EmployeeSalaryDetailsData]!
    var currentSalary: String?
    var isOpened: Bool = false
    
//    var effectiveYear: String?
//    var effectiveMonth: String?
//    var effectiveDay: String?
//
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: UiConstants.ViewCellId.USER_JOB_INFO_CELL, bundle: nil)
        userJobInfoTableView.register(nib, forCellReuseIdentifier: UiConstants.ViewCellId.USER_JOB_INFO_CELL)
        let previousSalaryNib = UINib(nibName: UiConstants.ViewCellId.PREVIOUS_SALARY_TITLE_CELL, bundle: nil)
        userJobInfoTableView.register(previousSalaryNib, forCellReuseIdentifier: UiConstants.ViewCellId.PREVIOUS_SALARY_TITLE_CELL)
        userJobInfoTableView.register(UserJobInfoHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        userJobInfoTableView.delegate = self
        userJobInfoTableView.dataSource = self
        print("hell yea", self.userJobTableData!)
        print("hell no", self.userSalaryTableData!)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return userSalaryTableData.count
                return userSalaryTableData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = "Previous Salary Details"
//        label.backgroundColor = UIColor.lightGray
//        return label
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func handleExpandClose(isOpened: Bool) {
        print("Trying to expand and close section...")
        
        self.isOpened = isOpened
        print(self.isOpened)
//        var indexPaths = [IndexPath]()
//
//        for cell in userJobInfoTableView.visibleCells {
//            let indexPath: IndexPath = userJobInfoTableView.indexPath(for: cell)!
//
//            if indexPath.section == 0 {
//                indexPaths.append(indexPath)
//            }
//        }
//
//        userJobInfoTableView.deleteRows(at: indexPaths, with: .fade)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if (indexPath.row == 0) {
//            let cell = userJobInfoTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.USER_JOB_INFO_CELL, for: indexPath) as! UserJobInfoTableViewCell
//            cell.selectionStyle = .none
//            cell.userJobInfoTitle.text = UiConstants.UserInfo.UserJobInfoTitles[0]
//            cell.userJobInfoDetails.text = userJobTableData?[0]
//            return cell
//        } else if (indexPath.row == 1) {
//            let cell = userJobInfoTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.USER_JOB_INFO_CELL, for: indexPath) as! UserJobInfoTableViewCell
//            cell.selectionStyle = .none
//            cell.userJobInfoTitle.text = UiConstants.UserInfo.UserJobInfoTitles[1]
//            cell.userJobInfoDetails.text = userJobTableData?[1]
//            return cell
//        }
//        else if (indexPath.row == 2) {
//            let cell = userJobInfoTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.PREVIOUS_SALARY_TITLE_CELL, for: indexPath) as! PreviousSalaryTitlesTableViewCell
//            return cell
//        }
        let cell = userJobInfoTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.PREVIOUS_SALARY_TITLE_CELL, for: indexPath) as! PreviousSalaryTitlesTableViewCell
        cell.selectionStyle = .none
        if let employeeSalaryDetails = userSalaryTableData[indexPath.row] as? EmployeeSalaryDetailsData {
            
            let startIndex = employeeSalaryDetails.effectiveDate.index(employeeSalaryDetails.effectiveDate.startIndex, offsetBy: 4)
            let endIndex = employeeSalaryDetails.effectiveDate.index(employeeSalaryDetails.effectiveDate.endIndex, offsetBy: -2)
            let range = startIndex..<endIndex
            
            
            let effectiveYear = employeeSalaryDetails.effectiveDate.prefix(4)
            let month = employeeSalaryDetails.effectiveDate[range]
            let day = employeeSalaryDetails.effectiveDate.suffix(2)
            
            cell.effectiveDataLabel.text =  String(day) + "/" + String(month) + "/" + String(effectiveYear)
            cell.basicSalaryLabel.text = employeeSalaryDetails.basicSalary
            cell.otLabel.text = employeeSalaryDetails.salaryGrade
            
        }
        
        return cell
           
    }
    
}


