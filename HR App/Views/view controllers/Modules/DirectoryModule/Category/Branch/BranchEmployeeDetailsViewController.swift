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
//    @IBOutlet var secretaryEmployeeDetailsTitle: [UILabel]!
    @IBOutlet var secretarydetailsTitleLabel: UILabel!
    @IBOutlet var viewSecretaryDetailsLabel: UILabel!
    @IBOutlet var secretaryDetailsView: UIView!
    
    var employeeData = [String]()
    let labelFontSize: CGFloat = 12.0
    var employeeDetails: BranchEmployeeData!
    var corporatManagementDetails: BranchEmployeeData!
    var coporateManagerSecretaryID: String?
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
            } else{
                element.text = KeyCostants.BranchEmployeeDetails.TEXT_UNAVAILABLE
                element.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
        }
        
        if employeeType == 1 {
            self.secretaryDetailsView.isHidden = false
//            self.secretaryEmployeeDetailsTitle.enumerated().forEach { (index, element) in
//                element.font = element.font.withSize(labelFontSize)
//                element.text = KeyCostants.BranchEmployeeDetails.SECRETARY_AVAILABLE[index]
//            }
            let gesture = UITapGestureRecognizer.init(target: self, action: #selector(actionViewSecretaryDetails(sender:)))
            self.viewSecretaryDetailsLabel.addGestureRecognizer(gesture)
            
            secretarydetailsTitleLabel.font = secretarydetailsTitleLabel.font.withSize(labelFontSize)
            secretarydetailsTitleLabel.text = KeyCostants.BranchEmployeeDetails.SECRETARY_AVAILABLE[0]
            viewSecretaryDetailsLabel.font = secretarydetailsTitleLabel.font.withSize(labelFontSize)
            viewSecretaryDetailsLabel.text = KeyCostants.BranchEmployeeDetails.SECRETARY_AVAILABLE[1]
        } else {
            self.secretaryDetailsView.isHidden = true
        }
    }
    
    @objc func actionViewSecretaryDetails(sender: UITapGestureRecognizer) {
        let userProfileVC = self.storyboard?.instantiateViewController(withIdentifier: UiConstants.StrotyBoardId.USER_PROFILE_VC) as! UserProfileViewController
        self.navigationController?.pushViewController(userProfileVC, animated: true)
        userProfileVC.isLoggedInUser = false
        userProfileVC.employeeId = self.coporateManagerSecretaryID
        userProfileVC.modalPresentationStyle = .fullScreen
        self.present(userProfileVC, animated: true, completion: nil)
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
        self.employeeData.append(employeeDetails.department!)
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
