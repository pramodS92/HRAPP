//
//
// DirectoryServiceManager.swift
// HR App
//
//Created by Pramod Ranasinghe on 5/30/21
// Copyright © 2021 CBC Tech Solutions. All rights reserved.


import Foundation
import Alamofire

protocol OnSuccessUserDirectory {
    func onSuccessBranchNameList(response: [String])
    func onSuccessDepartmentNameList(response: [DepartmentData])
    func onSuccessCoporateManagementList(response: [CoporateManagementData])
    func onSuccessExchangeOfficeNameList(response: [ExchangeOfficeData])
    func onSuccessRegionalOfficeNameList(response: [RegionalOfficeData])
    func onSuccessSerendibFinanceNameList(response: SerendibFinanceDataClass)
    func onSuccessSpecialLocationNameList(response: [SpecialLocationData])
    func onSuccessEmployeeNameList(response: [BranchEmployeeData])
    func onFailier()
}

class DirectoryServiceManager {
    
    var tableData: [String] = []
    var departmentData: [DepartmentData] = []
    var regionalOfficeData: [RegionalOfficeData] = []
    var serendibFinanceData: String!
    var exchangeOfficeData: [ExchangeOfficeData] = []
    var delegate: OnSuccessUserDirectory?
    
    func getBranchNameList(text: String,_ callback : OnSuccessUserDirectory) {
        self.delegate = callback
        BranchInfoService.shared.getBranchNameList(searchBy: text.uppercased()){
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(BranchNameListModel.self, from: response! as! Data){
                    self.tableData.removeAll()
                    if let data = responseBody.data{
                        for item in data{
                            self.tableData.append(item.branchName!)
                        }
                        self.delegate?.onSuccessBranchNameList(response: self.tableData)
                    }
                }
            }else{
                self.delegate?.onFailier()
                return
            }
        }
    }
    
    func getDepartmentNameList(text: String,_ callback : OnSuccessUserDirectory){
        self.delegate = callback
        DepartmentInfoService.shared.getDepartmentNameList(searchBy: text.uppercased()){
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(DepartmentNameListModel.self, from: response! as! Data){
                    self.tableData.removeAll()
                    if let data = responseBody.data{
                        self.departmentData = data
                        self.delegate?.onSuccessDepartmentNameList(response: data)
                    }
                }
            }else{
                self.delegate?.onFailier()
                return
            }
        }
    }

    func getCoporateManagementList(text: String, _ callback: OnSuccessUserDirectory) {
        self.delegate = callback
        CoporateManagementInfoService.shared.getCoporateManagementNameList(searchBy: text.uppercased()) {
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(CoporateManagementNameListModel.self, from: response! as! Data) {
                    self.tableData.removeAll()
                    if let data = responseBody.data {
                        self.delegate?.onSuccessCoporateManagementList(response: data)
                    }
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
        
    }
    
    func getExchangeOfficeNameList(text: String,_ callback : OnSuccessUserDirectory) {
        self.delegate = callback
        ExchangeOfficeInfoService.shared.getExchangeOfficeNameList(searchBy: text.uppercased()) {
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(ExchangeOfficeNameListModel.self, from: response! as! Data) {
                    self.tableData.removeAll()
                    if let data = responseBody.data {
                        self.exchangeOfficeData = data
                        for item in data {
                            self.tableData.append(item.departmentName!)
                        }
                        self.delegate?.onSuccessExchangeOfficeNameList(response: data)
                    }
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
    }
    
    func getRegionalOfficeNameList(text: String,_ callback : OnSuccessUserDirectory) {
        self.delegate = callback
        RegionalOfficeInfoService.shared.getRegionalOfficeNameList(searchBy: text.uppercased()) {
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(RegionalOfficeNameListModel.self, from: response! as! Data) {
                    self.tableData.removeAll()
                    if let data = responseBody.data {
                        self.regionalOfficeData = data
                        for item in data {
                            self.tableData.append(item.regionalOffice!)
                        }
                        self.delegate?.onSuccessRegionalOfficeNameList(response: data)
                    }
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
    }
    
    func getSerendibFinanceNameList(text: String, _ callback: OnSuccessUserDirectory) {
        self.delegate = callback
        SerendibFinanceInfoService.shared.getSerendibFinanceNameList(searchBy: text.uppercased()) { (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(SerendibFinanceDetailsModel.self, from: response! as! Data) {
                    self.tableData.removeAll()
                    if let data = responseBody.data {
                        self.serendibFinanceData = data.departmentName
                        self.tableData.append(self.serendibFinanceData)
                        self.delegate?.onSuccessSerendibFinanceNameList(response: data)
                    }
                    
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
    }
    
    func getSpecialLocationNameList(text: String,_ callback: OnSuccessUserDirectory) {
        self.delegate = callback
        SpecialLocationInfoService.shared.getSpecialLocationNameList(searchBy: text.uppercased()) { (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(SpecialLocationNameListModel.self, from: response! as! Data) {
                    self.tableData.removeAll()
                    if let data = responseBody.data {
                        for item in data {
                            self.tableData.append(item.locationName!)
                        }
                        self.delegate?.onSuccessSpecialLocationNameList(response: data)
                    }
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
    }
    
    func getEmployeeNameList(text: String, _ callback: OnSuccessUserDirectory){
        self.delegate = callback
        
        if text.count > 4 {
            EmployeeInfoService.shared.getEmployeeByName(searchBy: text.uppercased()){
                (response, error, statusCode) in
                if response != nil {
                    if let responseBody = try? JSONDecoder().decode(EmployeeNameListModel.self, from: response! as! Data){
                        self.tableData.removeAll()
                        if let data = responseBody.data{
                            self.delegate?.onSuccessEmployeeNameList(response: data)
                        }
                    }
                }else{
                    self.delegate?.onFailier()
                    return
                }
            }
        }else{
            self.delegate?.onFailier()
        }
    }
    
}
