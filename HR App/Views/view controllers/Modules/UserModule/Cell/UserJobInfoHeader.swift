//
//  UserJobInfoHeader.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-12.
//

import UIKit

class UserJobInfoHeader: UITableViewHeaderFooterView {

    static let header = "UserJobInfoHeader"
    
    private let titleOne: UILabel = {
        let label = UILabel()
        label.text = "Effective Date"
        return label
    }()
    
    private let titleTwo: UILabel = {
        let label = UILabel()
        label.text = "Basic"
        return label
    }()
    
    private let titleThree: UILabel = {
        let label = UILabel()
        label.text = "Salary Grade"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleOne)
        contentView.addSubview(titleTwo)
        contentView.addSubview(titleThree)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleOne.sizeToFit()
        titleTwo.sizeToFit()
        titleThree.sizeToFit()
        titleOne.frame = CGRect(x: contentView.frame.size.width * 0.05,
                                y: contentView.frame.size.height * 0.25,
                               width: titleOne.frame.size.width,
                               height: titleOne.frame.size.height)
        titleTwo.frame = CGRect(x: contentView.frame.size.width * 0.45,
                                y: contentView.frame.size.height * 0.25,
                               width: titleTwo.frame.size.width,
                               height: titleTwo.frame.size.height)
        titleThree.frame = CGRect(x: contentView.frame.size.width * 0.7,
                                  y: contentView.frame.size.height * 0.25,
                                 width: titleThree.frame.size.width,
                                 height: titleThree.frame.size.height)
    }
    
}
