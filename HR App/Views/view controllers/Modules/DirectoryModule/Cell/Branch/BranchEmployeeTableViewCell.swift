//
//
// BranchEmployeeTableViewCell.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/26/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit

class BranchEmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var branchEmployeeImageView: UIImageView!
    @IBOutlet weak var branchEmployeeDesignation: UILabel!
    @IBOutlet weak var branchEmployeeName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
