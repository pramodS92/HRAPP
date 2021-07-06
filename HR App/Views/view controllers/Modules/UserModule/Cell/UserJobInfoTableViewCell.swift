//
//
// UserJobInfoTableViewCell.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/21/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit

class UserJobInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userJobInfoTitle: UILabel!
    @IBOutlet weak var userJobInfoDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
