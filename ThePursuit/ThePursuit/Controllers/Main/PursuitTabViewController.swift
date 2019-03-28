//
//  PursuitTabViewController.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class PursuitTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

      setupViewControllers()
    }
    

  func setupViewControllers(){
    let generalController = UIStoryboard(name: "General", bundle: nil).instantiateViewController(withIdentifier: "GeneralViewController") as!  GeneralViewController

    let searchController = UINavigationController(rootViewController: SearchController())
    
    let profileController = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController

    searchController.title = "Notes"
   
    generalController.title = "General"
    generalController.tabBarItem.image = #imageLiteral(resourceName: "home.png")

  
    
 viewControllers = [generalController,searchController,profileController]
   
    
  }

}
