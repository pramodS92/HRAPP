//
//  PostViewController.swift
//  HR App
//
//  Created by Lakith Jayalath on 2021-07-31.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet var postCollectionView: UICollectionView!
    var serviceManager: PostServiceManager = PostServiceManager()
    var postData = [PostData]()
    var status: String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        self.getPostData(status: self.status)
    }
    
    func setPostData(postData: [PostData]) {
        self.postData = postData
        print(self.postData)
    }

}

extension PostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UiConstants.ViewCellId.POST_CELL, for: indexPath) as? PostCell else {
            fatalError("Cannot dequeue post cell")
        }
        cell.layer.borderWidth = 0.25
        return cell
    }
    
}

extension PostViewController:OnSuccessPost {
    
    internal func getPostData(status: String) {
        serviceManager.getPost(status: status, self)
    }
    
    func onSuccessGetPost(postData: [PostData]) {
        setPostData(postData: postData)
    }
    
    func onFailier() {
        
    }
    
}
