//
//
// DepartmentViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/24/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit

class DepartmentViewController: UIViewController {
    
    @IBOutlet weak var departmentName: UILabel!
    @IBOutlet var departmentInfoTitles: [UILabel]!
    @IBOutlet var departmentInfoDetails: [UILabel]!
    @IBOutlet weak var departmentDetailsContainerView: UIView!
    @IBOutlet weak var departmentDetailsTableView: UITableView!
    
    var departmemtId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUiProps()

       print("..... departmemtId :",departmemtId)
    }
    
    func setupUiProps(){
        self.departmentDetailsContainerView.layer.cornerRadius = 10
        self.departmentDetailsContainerView.layer.borderWidth = 1
        self.departmentDetailsContainerView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
    }
    


}
