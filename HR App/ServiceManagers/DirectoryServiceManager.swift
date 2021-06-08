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
    func onSuccessDepartmentNameList(response: [String])
    func onSuccessEmployeeNameList(response: [BranchEmployeeData])
    func onFailier()
}

class DirectoryServiceManager {
    
    var tableData: [String] = []
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
                if let responseBody = try? JSONDecoder().decode(DepaetmentNameListModel.self, from: response! as! Data){
                    self.tableData.removeAll()
                    if let data = responseBody.data{
                        for item in data{
                            self.tableData.append(item.departmentName!)
                        }
                        self.delegate?.onSuccessDepartmentNameList(response: self.tableData)
                    }
                }
            }else{
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
