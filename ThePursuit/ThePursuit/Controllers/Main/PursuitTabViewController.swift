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
    searchController.title = "Notes"
    viewControllers = [generalController,searchController]
    generalController.title = "General"
    generalController.tabBarItem.image = #imageLiteral(resourceName: "home.png")
    
  }

}
