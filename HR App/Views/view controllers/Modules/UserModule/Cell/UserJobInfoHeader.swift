//
//  UserJobInfoHeader.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-12.
//

import UIKit

class UserJobInfoHeader: UITableViewHeaderFooterView {

    static let header = "UserJobInfoHeader"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Previous Salary Details"
        return label
    }()
    
    private let titleOne: UILabel = {
        let label = UILabel()
        label.text = "Effective Date"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    private let titleTwo: UILabel = {
        let label = UILabel()
        label.text = "Basic"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    private let titleThree: UILabel = {
        let label = UILabel()
        label.text = "Salary Grade"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(button)
        contentView.addSubview(titleOne)
        contentView.addSubview(titleTwo)
        contentView.addSubview(titleThree)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleExpandClose() {
        // close the section by deleting the rows
        UserJobInfoViewController().handleExpandClose(isOpened: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        button.sizeToFit()
        titleOne.sizeToFit()
        titleTwo.sizeToFit()
        titleThree.sizeToFit()
        label.frame = CGRect(x: contentView.frame.size.width * 0.05,
                             y: contentView.frame.size.height * 0.25,
                             width: label.frame.size.width,
                             height: label.frame.size.height)
        button.frame = CGRect(x: contentView.frame.size.width * 0.85,
                              y: contentView.frame.size.height * 0.2,
                             width: button.frame.size.width,
                             height: button.frame.size.height)
        titleOne.frame = CGRect(x: contentView.frame.size.width * 0.05,
                                y: contentView.frame.size.height * 0.6,
                               width: button.frame.size.width,
                               height: button.frame.size.height)
        titleTwo.frame = CGRect(x: contentView.frame.size.width * 0.5,
                                y: contentView.frame.size.height * 0.6,
                               width: button.frame.size.width,
                               height: button.frame.size.height)
        titleThree.frame = CGRect(x: contentView.frame.size.width * 0.85,
                                  y: contentView.frame.size.height * 0.6,
                                 width: button.frame.size.width,
                                 height: button.frame.size.height)
//        labelTwo.frame = CGRect(x: 25,
//                                y: contentView.frame.midY,
//                             width: labelTwo.frame.size.width,
//                             height: labelTwo.frame.size.height)
    }
    
}
