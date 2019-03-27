//
//  ProfileViewController.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

//Using PAUser Model
//unwind from bio view?

import UIKit

class ProfileViewController: UIViewController {

  @IBOutlet weak var profileTableView: UITableView!
  let cellId = "ProfileCell"
  
    public lazy var profileHeaderView: ProfileHeaderView = {
        let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300))
        return headerView
    }()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
      
    }


}
