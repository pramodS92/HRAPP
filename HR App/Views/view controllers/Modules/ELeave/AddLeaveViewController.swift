//
//  AddLeaveViewController.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-13.
//

import UIKit

class AddLeaveViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var leaveTypesStackView: UIStackView!
    @IBOutlet var annualLeaveProgressView: CircularProgressView!
    @IBOutlet var medicalLeaveProgressView: CircularProgressView!
    @IBOutlet var casualLeaveProgressView: CircularProgressView!
    @IBOutlet var sickNoteProgressView: CircularProgressView!
    @IBOutlet var accumulatedAnnualProgressView: CircularProgressView!
    @IBOutlet var accumulatedMedicalProgressView: CircularProgressView!
    @IBOutlet var leaveDetailsContainerView: UIView!
    @IBOutlet var leaveApplicationContainerView: UIView!
    @IBOutlet var leaveDetailsTitles: [UILabel]!
    @IBOutlet var leaveDetailsLabels: [UILabel]!
    @IBOutlet var leaveDetailsWarningMessages: [UILabel]!
    @IBOutlet var leaveApplicationTitles: [UILabel]!
    @IBOutlet var leaveTypes: [UIButton]!
    @IBOutlet var selectLeaveTypeBtn: UIButton!
    @IBOutlet var fromDatePicker: UIDatePicker!
    @IBOutlet var toDatePicker: UIDatePicker!
    @IBOutlet var reasonForDutyLeaveTextView: UITextView!
    @IBOutlet var contactAddressTextView: UITextView!
    var leaveDetails: [Double] = [30.0, 80.0, 50.0, 14.5, 100.0, 10.0]
    var selectLeaveType: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCircularProgressViews()
        initUiProp()
    }
    
    func setupCircularProgressViews() {
        setupAnnualLeaveProgress()
        setupMedicalLeaveProgress()
        setupCasualLeaveProgress()
        setupSickNoteProgress()
        setupAccumulatedAnnualProgress()
        setupAccumulatedMedicalProgress()
        
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
    
    func initUiProp() {
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .white
//        navigationController?.navigationBar.barTintColor = UIColor.clear
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.view.bringSubviewToFront(leaveTypesStackView)
        
        leaveDetailsContainerView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        leaveDetailsContainerView.layer.borderWidth = 1
        leaveDetailsContainerView.layer.cornerRadius = 6
        
        leaveApplicationContainerView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        leaveApplicationContainerView.layer.borderWidth = 1
        leaveApplicationContainerView.layer.cornerRadius = 6
        
        leaveTypesStackView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        leaveTypesStackView.layer.borderWidth = 1
        
        reasonForDutyLeaveTextView.delegate = self
        
        setupLeaveDetailsTitles()
        setupLeaveApplicationTitles()
        setupLeaveDetails()
        setupLeaveDetailsWarningMessages()
        
        setupDatePickers()
    }
    
    func setupDatePickers() {
        fromDatePicker.locale = .current
        fromDatePicker.date = Date()
        
        toDatePicker.locale = .current
        toDatePicker.date = Date()
        
    }
    
    @IBAction func handleLeaveTypeSelection(_ sender: Any) {
        self.setLeaveTypeItemsVisibility()
    }
    
    func setLeaveTypeItemsVisibility() {
        leaveTypes.forEach { (button) in
            UIView.animate(withDuration: 0.3) {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updateText = currentText.replacingCharacters(in: stringRange, with: text)
        
        return updateText.count <= 60
    }
    
    @IBAction func leaveTypeItemTapped(_ sender: UIButton) {
        guard let leaveType = sender.currentTitle, let leaveType = LeaveTypes(rawValue: leaveType) else {
            return
        }
        self.selectLeaveTypeBtn.setTitle(leaveType.rawValue, for: .normal)
        self.selectLeaveType = leaveType.rawValue
        
        setLeaveTypeItemsVisibility()
    }
    
    func setupLeaveDetailsTitles() {
        leaveDetailsTitles.enumerated().forEach { (index, element) in
            element.text = KeyCostants.LeaveDetails.LEAVE_DETAILS_TITLES[index]
        }
    }
    
    func setupLeaveDetails() {
        leaveDetailsLabels.enumerated().forEach { (index, element) in
            element.text = String(format: "%.1f", leaveDetails[index])
        }
    }
    
    func setupLeaveDetailsWarningMessages() {
        leaveDetailsWarningMessages.enumerated().forEach { (index, element) in
            element.text = KeyCostants.LeaveDetails.LEAVE_DETAILS_WARNING_MESSAGES[index]
        }
    }
    
    func setupLeaveApplicationTitles() {
        leaveApplicationTitles.enumerated().forEach { (index, element) in
            element.text = KeyCostants.LeaveDetails.LEAVE_APPLICATION_TITLES[index]
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
    
    func setupSickNoteProgress() {
        sickNoteProgressView.trackColor = #colorLiteral(red: 0.8957770467, green: 0.8904522061, blue: 0.8998700976, alpha: 1)
        sickNoteProgressView.progressColor = UIColor.orange
    }
    
    func setupAccumulatedAnnualProgress() {
        accumulatedAnnualProgressView.trackColor = #colorLiteral(red: 0.8957770467, green: 0.8904522061, blue: 0.8998700976, alpha: 1)
        accumulatedAnnualProgressView.progressColor = UIColor.yellow
    }
    
    func setupAccumulatedMedicalProgress() {
        accumulatedMedicalProgressView.trackColor = #colorLiteral(red: 0.8957770467, green: 0.8904522061, blue: 0.8998700976, alpha: 1)
        accumulatedMedicalProgressView.progressColor = UIColor.blue
    }
    
    @objc func animateProgress() {
        annualLeaveProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveDetails[0])/100)
        medicalLeaveProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveDetails[1])/100)
        casualLeaveProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveDetails[2])/100)
        sickNoteProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveDetails[3])/100)
        accumulatedAnnualProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveDetails[4])/100)
        accumulatedMedicalProgressView.setProgressWithAnimation(duration: 1.0, value: Float(leaveDetails[5])/100)
    }

}
