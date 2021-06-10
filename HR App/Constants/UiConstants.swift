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
    }
    
    struct ViewCellId {
        static let USER_INFO_CELL = "UserInfoTableViewCell"
        static let USER_JOB_INFO_CELL = "UserJobInfoTableViewCell"
        static let DIRECTORY_ITEM_CELL = "DirectoryTableViewCell"
        static let BRANCH_EMPLOYEE_DETAIL_CELL = "BranchEmployeeTableViewCell"
        static let EMPLOYEE_ITEM_CELL = "EmployeeTableViewCell"
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
        static let OTP_CODE_DIGIT = "Enter 4-digit code"
    }
    
    struct AlertConst {
        static let ALERT_TITLE_ALERT = "Alert"
        //Password validation
        static let PASSWORD_LEAST_CHAR_COUNT = "Password must contain at least 8 characters"
        static let PASSWORD_LEAST_CHAR_UPPER = "Password must contain at least one Uppercase character"
        static let PASSWORD_LEAST_NUM_VALUE = "Password must contain at least one numeric value"
        static let PASSWORD_LEAST_CHAR_SPECIAL = "Password must contain at least one special character"
        //Login
        static let INVALID_USER_CREDENTIALS = "Invalid user credentials"
    }
    
    struct UserInfo {
        static let UserInfoTitles = ["Initials",
                                       "Surname",
                                       "Known name",
                                       "Full name",
                                       "Middle name",
                                       "Employee ID"]
    }
    
}

struct KeyCostants {
    
    struct DirectoryCategory {
        static let DIRECTORY_CATEGORY_BRANCH = "Branches"
        static let DIRECTORY_CATEGORY_DEPARTMENT = "Departments"
        static let DIRECTORY_CATEGORY_COP_MANAGEMENT = "Coporate Management"
        static let DIRECTORY_CATEGORY_EX_OFFICE = "Exchange Offices"
        static let DIRECTORY_CATEGORY_REG_OFFICE = "Regional Offices"
        static let DIRECTORY_CATEGORY_SERANDIB = "Serendib Finance Ltd"
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
    
    struct BranchEmployeeDetails {
        static let TEXT_UNAVAILABLE = "Unavailabe"
        static let BRANCH_EMPLOYEE_DETAILS_TITLES = [
            "Name",
            "Known Name",
            "Designation",
            "Branch Name",
            "Telephone",
            "Intercom",
            "Email"]
    }
    
    struct DepartmentDetails {
        static let DEPARTMENT_DETAILS_TITLES = [
            "Department Head's Name",
            "Department Head's Known Name",
            "Department Head's Telephone",
            "Department Head's ID",
            "Department ID",
            "Branch Name",
            "Head Text",
            "Fax number",
            "Address"
        ]
    }
}





