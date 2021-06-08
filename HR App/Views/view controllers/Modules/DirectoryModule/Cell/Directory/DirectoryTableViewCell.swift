//
//
// DirectoryTableViewCell.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/23/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit

class DirectoryTableViewCell: UITableViewCell {

    @IBOutlet weak var direcaryItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
