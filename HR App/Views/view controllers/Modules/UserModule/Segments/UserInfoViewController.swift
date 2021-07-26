//
//
// UserJobInfoViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/20/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import UIKit

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   @IBOutlet weak var userInfoTableView: UITableView!
    
    var userTabelData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: UiConstants.ViewCellId.USER_INFO_CELL, bundle: nil)
        userInfoTableView.register(nib, forCellReuseIdentifier: UiConstants.ViewCellId.USER_INFO_CELL)
        userInfoTableView.delegate = self 
        userInfoTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UiConstants.UserInfo.UserInfoTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userInfoTableView.dequeueReusableCell(withIdentifier: UiConstants.ViewCellId.USER_INFO_CELL, for: indexPath) as! UserInfoTableViewCell
        cell.selectionStyle = .none
        cell.userInfoTitle.text = UiConstants.UserInfo.UserInfoTitles[indexPath.row]
        cell.userInfoDetails.text = self.userTabelData[indexPath.row]
        return cell
    }
    
}
