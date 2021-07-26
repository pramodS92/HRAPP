//
//  UserTransferHistoryTableViewCell.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-26.
//

import UIKit

class UserTransferHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var branchName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
