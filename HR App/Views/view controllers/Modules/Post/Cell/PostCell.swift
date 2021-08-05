//
//  PostCell.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-08-05.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    @IBOutlet var userProfilePicImageView: UIImageView!
    @IBOutlet var userProfileName: UILabel!
    @IBOutlet var postUploadedDate: UILabel!
    @IBOutlet var postDescription: UILabel!
    @IBOutlet var postImageView: UIImageView!
    
    override func layoutSubviews() {
        userProfilePicImageView.layer.cornerRadius = userProfilePicImageView.bounds.width / 2
    }
}
