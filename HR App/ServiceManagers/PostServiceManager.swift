//
//  PostServiceManager.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-08-05.
//

import Foundation

protocol OnSuccessPost {
    func onSuccessGetPost(postData: [PostData])
    func onFailier()
}

class PostServiceManager {
    
    var postData = [PostData]()
    var delegate: OnSuccessPost?
    
    func getPost(status: String,_ callback: OnSuccessPost) {
        
        self.delegate = callback
        
        print("post data1")
        PostInfoService.shared.getPost(searchBy: status) { (response, error, statusCode) in
            print("post data2")
            if response != nil {
                if let responseBody = try? JSONDecoder().decode(PostModel.self, from: response! as! Data) {
                    print("post data3", responseBody.data!)
                    self.delegate?.onSuccessGetPost(postData: responseBody.data!)
                }
            } else {
                self.delegate?.onFailier()
                return
            }
        }
        
    }
    
}
