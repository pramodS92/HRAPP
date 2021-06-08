//
//
// EmployeeTableViewCell.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/31/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var employeeDesignation: UILabel!
    @IBOutlet weak var employeeBranch: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
