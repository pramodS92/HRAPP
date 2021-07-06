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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: UiConstants.ViewCellId.USER_JOB_INFO_CELL, bundle: nil)
        userJobInfoTableView.register(nib, forCellReuseIdentifier: UiConstants.ViewCellId.USER_JOB_INFO_CELL)
        userJobInfoTableView.delegate = self
        userJobInfoTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UiConstants.UserInfo.UserJobInfoTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userJobInfoTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.USER_JOB_INFO_CELL, for: indexPath) as! UserJobInfoTableViewCell
        cell.selectionStyle = .none
        cell.userJobInfoTitle.text = UiConstants.UserInfo.UserJobInfoTitles[indexPath.row]
        return cell
    }
    
}
