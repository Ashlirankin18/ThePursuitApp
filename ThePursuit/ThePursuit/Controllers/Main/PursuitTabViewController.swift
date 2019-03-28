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
<<<<<<< HEAD
    let profileController = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
=======
    generalController.title = "General"
    generalController.tabBarItem.image = #imageLiteral(resourceName: "home.png")
>>>>>>> 84a64db31fa4fa17b2343e2b8b33a5ef407881a4
    viewControllers = [generalController]
    viewControllers = [profileController]
    
  }

}
