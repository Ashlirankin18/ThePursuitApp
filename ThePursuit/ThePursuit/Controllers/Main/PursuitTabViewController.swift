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

    let profileController = ProfileViewController()
    profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user_male"), tag: 1)

    generalController.title = "General"
    generalController.tabBarItem.image = #imageLiteral(resourceName: "home.png")

    viewControllers = [generalController,profileController]
   
  }

}
