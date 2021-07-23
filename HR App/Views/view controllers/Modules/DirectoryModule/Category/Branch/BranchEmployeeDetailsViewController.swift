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
    @IBOutlet var viewMoreInfoBtn: UIButton!
    
    var employeeData = [String]()
    let labelFontSize: CGFloat = 12.0
    var employeeDetails: BranchEmployeeData!
    var specialLocationEmployeeDetails: SpecialLocationDataClass!
    var specialLocationEmployeeCount: Int? = 0
    var corporatManagementDetails: BranchEmployeeData!
    var coporateManagerSecretaryID: String?
    var employeeType: Int = 0
    var categoryNo: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupUiProps()
        if categoryNo != 7 {
            self.setEmployeeDetails()
            viewMoreInfoBtn.isHidden = false
        } else {
            self.setSpecialLocationEmployeeDetails()
            viewMoreInfoBtn.isHidden = true
        }
        
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
    
    func setSpecialLocationEmployeeDetails() {
        if specialLocationEmployeeCount == 1 {
            self.employeeData.append(specialLocationEmployeeDetails.nameOne!.condensed.uppercased())
            self.employeeData.append("")
            self.employeeData.append(specialLocationEmployeeDetails.designationOne!)
            self.employeeData.append("")
            self.employeeData.append("")
            self.employeeData.append(specialLocationEmployeeDetails.directNumberOne!)
            self.employeeData.append(specialLocationEmployeeDetails.interComeOne!)
            self.employeeData.append("")
        } else if specialLocationEmployeeCount == 2 {
            self.employeeData.append(specialLocationEmployeeDetails.nameTwo!.condensed.uppercased())
            self.employeeData.append("")
            self.employeeData.append(specialLocationEmployeeDetails.designationTwo!)
            self.employeeData.append("")
            self.employeeData.append("")
            self.employeeData.append(specialLocationEmployeeDetails.directNumberTwo!)
            self.employeeData.append(specialLocationEmployeeDetails.interComeTwo!)
            self.employeeData.append("")
        }
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
