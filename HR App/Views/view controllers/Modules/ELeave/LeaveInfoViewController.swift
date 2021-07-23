//
//  LeaveInfoViewController.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-13.
//

import UIKit

class LeaveInfoViewController: UIViewController {

    @IBOutlet var annualLeaveProgressView: CircularProgressView!
    @IBOutlet var medicalLeaveProgressView: CircularProgressView!
    @IBOutlet var casualLeaveProgressView: CircularProgressView!
    @IBOutlet var accumulatedAnnualProgressView: CircularProgressView!
    @IBOutlet var accumulatedMedicalProgressView: CircularProgressView!
    @IBOutlet var leaveBalanceContainerView: UIView!
    @IBOutlet var leaveStatusContainerView: UIView!
    @IBOutlet var annualLeaveRosterContainerView: UIView!
    @IBOutlet var leaveBalanceInfoLabels: [UILabel]!
    @IBOutlet var leaveBalanceInfoTitles: [UILabel]!
    @IBOutlet var leaveStatusInfoLabels: [UILabel]!
    @IBOutlet var leaveStatusInfoTitles: [UILabel]!
    @IBOutlet var annualLeaveRosterDetails: [UILabel]!
    @IBOutlet var annualLeaveRosterDetailsTitles: [UILabel]!
    @IBOutlet var addLeaveBtn: UIButton!
    @IBOutlet var leaveWarningMessage: UILabel!
    
    var leaveBalanceInfo: [Double]! = [30.0, 80.0, 50.0, 100.0, 10.0]
    var leaveStatusInfo: [String]! = ["6", "6.5", "0", "0"]
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCircularProgressViews()
        initUiProps()
    }

    func setupCircularProgressViews() {
        setupAnnualLeaveProgress()
        setupMedicalLeaveProgress()
        setupCasualLeaveProgress()
        setupAccumulatedAnnualProgress()
        setupAccumulatedMedicalProgress()
        setupAnnualLeaveRosterDetailsTitles()
        
        self.perform(#selector(animateProgress), with: nil, afterDelay: 1.0)
//        let circularProgressView = CircularProgressView(frame: CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0))
//        circularProgressView.trackColor = UIColor.red
//        circularProgressView.progressColor = UIColor.yellow
//        circularProgressView.tag = 101
//        circularProgressView.center = self.view.center
//        self.view.addSubview(circularProgressView)
//
//        self.perform(#selector(animateProgress), with: nil, afterDelay: 1.0)
    }
    
    func initUiProps() {
        leaveBalanceContainerView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        leaveBalanceContainerView.layer.borderWidth = 1
        leaveBalanceContainerView.layer.cornerRadius = 6
        
        leaveStatusContainerView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        leaveStatusContainerView.layer.borderWidth = 1
        leaveStatusContainerView.layer.cornerRadius = 6
        
        annualLeaveRosterContainerView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        annualLeaveRosterContainerView.layer.borderWidth = 1
        annualLeaveRosterContainerView.layer.cornerRadius = 6
        
        addLeaveBtn.layer.cornerRadius = 6
        
        leaveWarningMessage.text = KeyCostants.LeaveDetails.LEAVE_WARNING_MESSAGES
        
        setupLeaveBalanceInfo()
        setupLeaveBalanceInfoTitles()
        setupLeaveStatusInfo()
        setupLeaveStatusInfoTitles()
    }
    
    func setupLeaveBalanceInfo() {
        leaveBalanceInfoLabels.enumerated().forEach { (index, element) in
            element.text = String(format: "%.1f", leaveBalanceInfo[index])
        }
    }
    
    func setupLeaveBalanceInfoTitles() {
        leaveBalanceInfoTitles.enumerated().forEach { (index, element) in
            element.text = KeyCostants.LeaveDetails.LEAVE_BALANCE_TITLES[index]
        }
    }
    
    func setupLeaveStatusInfo() {
        leaveStatusInfoLabels.enumerated().forEach { (index, element) in
            element.text = leaveStatusInfo[index] + " Days"
        }
    }
    
    func setupLeaveStatusInfoTitles() {
        leaveStatusInfoTitles.enumerated().forEach { (index, element) in
            element.text = KeyCostants.LeaveDetails.LEAVE_STATUS_TITLES[index]
        }
    }
    
    func setupAnnualLeaveRosterDetailsTitles() {
        annualLeaveRosterDetailsTitles.enumerated().forEach { (index, element) in
            element.text = KeyCostants.LeaveDetails.ANNUAL_LEAVE_ROSTER_DETAILS_TITLES[index]
        }
    }
    
    func setupAnnualLeaveProgress() {
        annualLeaveProgressView.trackColor = #colorLiteral(red: 0.8957770467, green: 0.8904522061, blue: 0.8998700976, alpha: 1)
        annualLeaveProgressView.progressColor = UIColor.purple
    }
    
    func setupMedicalLeaveProgress() {
        medicalLeaveProgressView.trackColor = #colorLiteral(red: 0.8957770467, green: 0.8904522061, blue: 0.8998700976, alpha: 1)
        medicalLeaveProgressView.progressColor = UIColor.green
    }
    
    func setupCasualLeaveProgress() {
        casualLeaveProgressView.trackColor = #colorLiteral(red: 0.8957770467, green: 0.8904522061, blue: 0.8998700976, alpha: 1)
        casualLeaveProgressView.progressColor = UIColor.red
        
    }
    
    func setupAccumulatedAnnualProgress() {
        accumulatedAnnualProgressView.trackColor = #colorLiteral(red: 0.8957770467, green: 0.8904522061, blue: 0.8998700976, alpha: 1)
        accumulatedAnnualProgressView.progressColor = UIColor.systemPink
    }
    
    func setupAccumulatedMedicalProgress() {
        accumulatedMedicalProgressView.trackColor = #colorLiteral(red: 0.8957770467, green: 0.8904522061, blue: 0.8998700976, alpha: 1)
        accumulatedMedicalProgressView.progressColor = UIColor.blue
    }
    
    @objc func animateProgress() {
        annualLeaveProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveBalanceInfo[0])/100)
        medicalLeaveProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveBalanceInfo[1])/100)
        casualLeaveProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveBalanceInfo[2])/100)
        accumulatedAnnualProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveBalanceInfo[3])/100)
        accumulatedMedicalProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveBalanceInfo[4])/100)
    }
    
    
    @IBAction func addLeaveAction(_ sender: Any) {
    }
    
}
