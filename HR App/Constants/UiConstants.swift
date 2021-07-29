//
//
// UiConstants.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/13/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation

struct UiConstants {
    
    struct Animation {
        static let ANIM_TXT_WELCOME = "WELCOME"
    }
   
    
    struct StrotyBoardId {
        static let LOGIN_VC = "LoginViewController"
        static let OTP_VALIDATION_VC = "OTPValidationViewController"
        static let LANDING_VC = "LandingViewController"
        static let BIOMETRIC_AUTH_VC = "BiometricAuthViewController"
        static let BRANCH_EMPLOYEE_DETAILS_VC = "BranchEmployeeDetailsViewController"
        static let CONFIGURE_BIOMETRIC_PIN_VC = "BiometricPinConfigureViewController"
        static let HOME_VC = "HomeViewController"
        static let DIRECTORY_VC = "DirectoryViewController"
        static let USER_PROFILE_VC = "UserProfileViewController"
        static let LEAVE_INFO_VC = "LeaveInfoViewController"
        static let ADD_LEAVE_VC = "AddLeaveViewController"
    }
    
    struct ViewCellId {
        static let USER_INFO_CELL = "UserInfoTableViewCell"
        static let USER_JOB_INFO_CELL = "UserJobInfoTableViewCell"
        static let DIRECTORY_ITEM_CELL = "DirectoryTableViewCell"
        static let BRANCH_EMPLOYEE_DETAIL_CELL = "BranchEmployeeTableViewCell"
        static let EMPLOYEE_ITEM_CELL = "EmployeeTableViewCell"
        static let USER_TRANSFER_HISTORY_CELL = "UserTransferHistoryTableViewCell"
        static let PREVIOUS_SALARY_TITLE_CELL = "PreviousSalaryTitlesTableViewCell"
        static let USER_JOB_INFO_HEADER_CELL = "UserJobInfoHeader"
        static let USER_TRANSFER_HISTORY_HEADER_CELL = "UserTransferHistoryHeader"
    }
    
    struct SegueIdentifiers {
        static let USER_INFO_SEGUE = "UserInfoSegue"
        static let USER_JOB_INFO_SEGUE = "UserJobInfoSegue"
        static let DIRECTORY_BRANCH_SEGUE = "branchSegue"
        static let DIRECTORY_DEPARTMENT_SEGUE = "departmentSegue"
        static let DIRECTORY_EMPLOYEE_SEGUE = "employeeSegue"
        static let EMPLOYEE_DETAIL_SEGUE = "employeeDetailSegue"
    }
    
    struct PlaceHolders {
        static let USER_NAME = "User name"
        static let PASSWORD = "Password"
        static let OTP_CODE_DIGIT = "Enter 6-digit code"
    }
    
    struct AlertConst {
        static let ALERT_TITLE_ALERT = "Alert"
        static let DISMISS_ACTION_TITLE = "Dismiss"
        //Password validation
        static let PASSWORD_LEAST_CHAR_COUNT = "Password must contain at least 8 characters"
        static let PASSWORD_LEAST_CHAR_UPPER = "Password must contain at least one Uppercase character"
        static let PASSWORD_LEAST_NUM_VALUE = "Password must contain at least one numeric value"
        static let PASSWORD_LEAST_CHAR_SPECIAL = "Password must contain at least one special character"
        //Login
        static let INVALID_USER_CREDENTIALS = "Invalid user credentials"
        //Biometrics & Pin
        static let ENTER_PIN_TITLE = "Enter PIN number"
        static let ENTER_PIN_MESSAGE = "Please enter your PIN number here"
        static let PIN_FIELD_PLACEHOLDER = "Enter PIN"
        // OTP
        static let INVALID_OTP_TITLE = "Invalid OTP"
        static let INVALID_OTP_ENTERED_TIMES = "You have entered an invalid PIN "
        static let PLEASE_TRY_AGAIN = " times. Please try again"
        static let OTP_TEXT_FIELD_EMPTY = "OTP Text field cannot be empty!"
        static let PLEASE_ENTER_OTP = "Please enter OTP"
    }
    
    struct UserInfo {
        static let UserInfoTitles = ["Initials",
                                       "Surname",
                                       "Known name",
                                       "Full name",
                                       "Middle name",
                                       "Employee ID"]
        
        static let UserJobInfoTitles = ["Current Salary",
                                        "Previous Salary Details",
                                        "Transfer History"]
    }
    
}

struct KeyCostants {
    
    struct DirectoryCategory {
        static let DIRECTORY_CATEGORY_BRANCH = "Branches"
        static let DIRECTORY_CATEGORY_DEPARTMENT = "Departments"
        static let DIRECTORY_CATEGORY_COP_MANAGEMENT = "Coporate Management"
        static let DIRECTORY_CATEGORY_EX_OFFICE = "Exchange Offices"
        static let DIRECTORY_CATEGORY_REG_OFFICE = "Regional Offices"
        static let DIRECTORY_CATEGORY_CBC = "CBC Finance Ltd"
        static let DIRECTORY_CATEGORY_SPECIAL_LOCATIONS = "Special Locations"
        static let DIRECTORY_CATEGORY_EMPLOYEE = "Employee"
        static let DIRECTORY_CATEGORY_EMPLOYEE_PLACEHOLDER = "Search employee (ex: Kasun)"
    }
    
    struct BranchDetails {
        static let BRANCH_DETAILS_MANAGER_NAME = "Manager's Name/Known Name"
        static let BRANCH_DETAILS_MANAGER_TEL_NUMBER = "Manager's Telephone No"
        static let BRANCH_DETAILS_ADDRESS = "Address"
        static let BRANCH_DETAILS_TELEPHONE_NUMBER = "Branch Telephone Number"
        static let BRANCH_DETAILS_FAX_NUMBER = "Branch Fax No"
        static let BRANCH_DETAILS_CODE = "Branch Code"
        static let BRANCH_DETAILS_REGIONAL_MANAGER = "Regional Manager"
        static let BRANCH_DETAILS_REGIONAL_OFFICE = "Regional Office"
        static let BRANCH_DETAILS_AGM_DGM_DETAILS = "AGM/DGM Details"
        static let BRANCH_DETAILS_TITLES = [
            "Manager's Name",
            "Manager's Known Name",
            "Manager's Telephone No",
            "Address",
            "Branch Telephone Number",
            "Branch Fax No",
            "Branch Code",
            "Regional Manager",
            "Regional Office",
            "AGM/DGM Details",
            "AGM/DGM Designation"]
    }
    
    struct RegionalOfficeDetails {
        static let REGIONAL_OFFICE_DETAILS_MANAGER_NAME = "Manager's Name/Known Name"
        static let REGIONAL_OFFICE_DETAILS_MANAGER_TEL_NUMBER = "Manager's Telephone No"
        static let REGIONAL_OFFICE_DETAILS_ADDRESS = "Address"
        static let REGIONAL_OFFICE_DETAILS_FAX_NUMBER = "Regional Office Fax No"
        static let REGIONAL_OFFICE_DETAILS_CODE = "Regional Office Code"
        static let REGIONAL_OFFICE_DETAILS_REGION_CODE = "Region Code"
        static let REGIONAL_OFFICE_DETAILS_ATTACHED_BRANCH = "Attached Branch"
        static let REGIONAL_OFFICE_DETAILS_AGM_DGM_DETAILS = "AGM/DGM Details"
        static let REGIONAL_OFFICE_DETAILS_AGM_DGM_DESIGNATION = "AGM/DGM Designation"
        static let REGIONAL_OFFICE_DETAILS_SUBDIVISION = "Subdivision"
        static let REGIONAL_OFFICE_DETAILS_TITLES = [
            "AGM",
            "Regional Office Manager's Name",
            "Regional Office Manager's Known Name",
            "Regional Office Manager's Telephone No",
            "Regional Office Manager's Ext",
            "Attached Branch",
            "Fax",
            "Address"]
    }
    
    struct BranchEmployeeDetails {
        static let TEXT_UNAVAILABLE = "Unavailabe"
        static let BRANCH_EMPLOYEE_DETAILS_TITLES = [
            "Name",
            "Known Name",
            "Designation",
            "Branch Name",
            "Department",
            "Telephone",
            "Intercom",
            "Email"]
        static let SECRETARY_UNAVAILABLE = [
            "",
            ""
        ]
        static let SECRETARY_AVAILABLE = [
            "Secretary Details",
            "click here to view details"
        ]
    }
    
    struct DepartmentDetails {
        static let DEPARTMENT_DETAILS_TITLES = [
            "Department Head's Name",
            "Department Head's Known Name",
            "Department Head's Telephone",
            "AGM/DGM Details",
            "Branch Name",
            "Head Ext",
            "Fax Number",
            "Address"
        ]
    }
    
    struct SpecialOfficeDetails {
        static let SPECIAL_OFFICE_DETAILS_TITLES = [
            "Attached Branch",
            "Fax",
            "",
            "",
            "",
            "",
            "",
            ""
        ]
    }
    
    struct OTPDetails {
        static let WAIT_FOR_OTP_CODE = "Waiting for code..."
    
    }
    
    struct LeaveDetails {
        static let LEAVE_TYPE_ANNUAL = "Annual Leave"
        static let LEAVE_TYPE_CASUAL = "Casual Leave"
        static let LEAVE_TYPE_MEDICAL = "Medical Leave"
        static let LEAVE_TYPE_DUTY = "Duty Leave"
        static let LEAVE_BALANCE_TITLES = [
            "Annual",
            "Medical",
            "Casual",
            "Accumulated Annual",
            "Accumulated Medical"
        ]
        static let LEAVE_STATUS_TITLES = [
            "Pending Leave",
            "Approved Leave",
            "Recommended Leave",
            "Rejected Leave"
        ]
        static let LEAVE_WARNING_MESSAGES = "Please check your reporting line, prior to applying leave. For any changes contact Compensation & Benefits Unit."
        static let LEAVE_DETAILS_TITLES = [
            "Annual",
            "Medical",
            "Casual",
            "Sick Note(taken)",
            "Accumulated Annual",
            "Accumulated Medical"
        ]
        static let LEAVE_DETAILS_WARNING_MESSAGES = [
            "Since there could be a difference with the Branch/Department, leave records during this transition period,"
            + " please check the above leave balances prior to applying leave.",
            "\"Pending Leave requests have not been excluded from the above leave balance\""
        ]
        static let ANNUAL_LEAVE_ROSTER_DETAILS_TITLES = [
            "Month",
            "Number of days"
        ]
        static let LEAVE_APPLICATION_TITLES = [
            "Leave Type",
            "From Date",
            "To Date",
            "Reason of Duty Leave (Max 60 Charachters)",
            "Contact Address",
            "Email (private)",
            "Contact No."
        ]
        
        
    }
}





