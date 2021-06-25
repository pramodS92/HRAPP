//
//
// BranchEmployeeDetailsViewController.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/27/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import UIKit

class BranchEmployeeDetailsViewController: UIViewController {

    @IBOutlet var branchEmployeeDetailsTitle: [UILabel]!
    @IBOutlet var branchEmployeeDetailsInfo: [UILabel]!
    
    var employeeData = [String]()
    let labelFontSize: CGFloat = 12.0
    var employeeDetails: BranchEmployeeData!
    var employeeType: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupUiProps()
        self.setEmployeeDetails()
    }
    
    func setupUiProps(){
        self.branchEmployeeDetailsTitle?.enumerated().forEach { (index, element) in
            element.font = element.font.withSize(labelFontSize)
            element.text = KeyCostants.BranchEmployeeDetails.BRANCH_EMPLOYEE_DETAILS_TITLES[index]
        }
        
        
    }
    
    func initUiProps() {
        self.branchEmployeeDetailsInfo?.enumerated().forEach { (index, element) in
            element.font = element.font.withSize(labelFontSize)
            if employeeData[index] != "" {
                element.text = employeeData[index]
            }else{
                element.text = KeyCostants.BranchEmployeeDetails.TEXT_UNAVAILABLE
                element.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UiConstants.SegueIdentifiers.EMPLOYEE_DETAIL_SEGUE {
            let destination = segue.destination as! UserProfileViewController
            destination.isLoggedInUser =  false
            destination.employeeId = employeeDetails?.employeeID
        }
    }
    
    
    func setEmployeeDetails() {
        self.employeeData.append(employeeDetails.name!.condensed.uppercased())
        self.employeeData.append(employeeDetails.knownName!)
        self.employeeData.append(employeeDetails.designation!)
        self.employeeData.append(employeeDetails.branch!)
        self.employeeData.append(employeeDetails.telephone!)
        self.employeeData.append(employeeDetails.interCOM!)
        self.employeeData.append(employeeDetails.email!)
        self.initUiProps()
    }
    
    @IBAction func actionDismissPopup(_ sender: Any) {
        employeeData.removeAll()
        employeeDetails = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionViewMoreDetails(_ sender: Any) {
        
    }
    

}
