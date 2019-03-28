//
//  PostDetailViewController.swift
//  ThePursuit
//
//  Created by Jeffrey Almonte on 3/28/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Firebase

class PostDetailViewController: UIViewController {
    var post: Post!
    lazy var postView: PostView = {
    let pv = PostView()
        pv.favoriteButton.addTarget(self, action: #selector(addFav), for: .touchUpInside)
    return pv
    }()
    private let authservice = AppDelegate.authService
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(postView)
postView.frame = self.view.bounds
       
    }
    
    @objc func addFav() {
        
    }
   

}
