//
//  HomeViewController.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-06-21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func viewDirectoryAction(_ sender: Any) {
//        let directoryVC = self.storyboard?.instantiateViewController(withIdentifier:  UiConstants.StrotyBoardId.DIRECTORY_VC) as! DirectoryViewController
//        self.navigationController?.pushViewController(directoryVC, animated: true)
//        directoryVC.modalPresentationStyle = .overCurrentContext
//        self.present(directoryVC, animated: true, completion: nil)
    }
    
    @IBAction func viewUserProfileAction(_ sender: Any) {
//        let userProfileVC = self.storyboard?.instantiateViewController(withIdentifier:  UiConstants.StrotyBoardId.USER_PROFILE_VC) as! UserProfileViewController
//        self.navigationController?.pushViewController(userProfileVC, animated: true)
//        userProfileVC.modalPresentationStyle = .overCurrentContext
//        self.present(userProfileVC, animated: true, completion: nil)
    }
    
    
    @IBAction func viewPostAction(_ sender: Any) {
    }
    
    
    
    @IBAction func viewNotificationsAction(_ sender: Any) {
    }
    
    
    @IBAction func viewProductRefGuideAction(_ sender: Any) {
    }
}
