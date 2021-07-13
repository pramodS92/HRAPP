//
//  PreviousSalaryTitlesTableViewCell.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-11.
//

import UIKit

class PreviousSalaryTitlesTableViewCell: UITableViewCell {

    @IBOutlet var effectiveDataLabel: UILabel!
    @IBOutlet var basicSalaryLabel: UILabel!
    @IBOutlet var otLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
