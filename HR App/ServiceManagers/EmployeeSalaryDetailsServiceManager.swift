//
//  EmployeeSalaryDetailsServiceManager.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-05.
//

import Foundation
import Alamofire

protocol OnSuccessEmployeeSalaryDetails {
    func getEmployeeSalaryInfo(employeeSalaries: [EmployeeSalaryDetailsData])
    func onFailier()
}

class EmployeeSalaryDetailsServiceManager {
    
    var delegate: OnSuccessEmployeeSalaryDetails?
    var userJobTableData: [EmployeeSalaryDetailsData] = []
    
    static  let isoFormatter : ISO8601DateFormatter = {
        let formatter =  ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate,]
        return formatter
       }()
    
    func getEmployeeSalaryDetailsById(employeeId: String, _ callback: OnSuccessEmployeeSalaryDetails) {
        self.delegate = callback
        
        EmployeeInfoService.shared.getEmployeeSalaryDetailsById(employeeId: employeeId) {
            (response, error, statusCode) in
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(EmployeeSalaryDetailsModel.self, from: response! as! Data) {
                    print("helloworld2")
                    self.delegate?.getEmployeeSalaryInfo(employeeSalaries: self.getEmployeeSalaryTableData(response: responseBody.data))
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
    }
    
    //Get select employee salary details in UserJobInfo Tab - User Profile Module
    func getEmployeeSalaryTableData(response: [EmployeeSalaryDetailsData]) -> [EmployeeSalaryDetailsData] {
        self.userJobTableData.removeAll()
        
        for i in 0...(response.count - 1) {
            
            var dateFromString: Date {
                return EmployeeSalaryDetailsServiceManager.isoFormatter.date(from: response[i].effectiveDate)!
            }
            
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd-MM-yyyy"
//
//            self.userJobTableData = response.sorted( by: { (dictionary1, dictionary2) -> Bool in
//
//                let date1 = response[i].effectiveDate
//                let date2 = response[i+1].effectiveDate
//
//                let d1 = dateFormatter.date(from: date1)!
//                let d2 = dateFormatter.date(from: date2)!
//
//                return d1 < d2
//
//            })
            
        }
        
        let sortedSalaries = response.sorted {$0.effectiveDate > $1.effectiveDate}
        self.userJobTableData = sortedSalaries
        
//        for i in 1...response.count {
//
//            let effectiveData = response[i].effectiveDate
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//            dateFormatter.dateFormat = "dd-MM-yyyy"
//            let date = dateFormatter.date(from: effectiveData)
//
//            if let date = date {
//                self.userJobTableData.append(response[i].effectiveDate)
//                self.effectiveDates.append(date)
//            }
//
//        }
        
        print("job4")
        print(userJobTableData)
        
        return userJobTableData
    }
    
}
