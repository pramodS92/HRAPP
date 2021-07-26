//
//  UserTransferHistoryHeader.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-24.
//

import UIKit

class UserTransferHistoryHeader: UITableViewHeaderFooterView {

    static let header = "UserTransferHistoryHeader"
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.text = "Date"
        return label
    }()
    
    private let designationLabel: UILabel = {
        let label = UILabel()
        label.text = "Designation"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(dateLabel)
        contentView.addSubview(designationLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateLabel.sizeToFit()
        designationLabel.sizeToFit()
        dateLabel.frame = CGRect(x: contentView.frame.size.width * 0.11,
                                 y: contentView.frame.size.height * 0.25,
                                 width: dateLabel.frame.size.width,
                                 height: dateLabel.frame.size.height)
        designationLabel.frame = CGRect(x: contentView.frame.size.width * 0.65,
                                        y: contentView.frame.size.height * 0.25,
                                        width: designationLabel.frame.size.width,
                                        height: designationLabel.frame.size.height)
    }
    
}
