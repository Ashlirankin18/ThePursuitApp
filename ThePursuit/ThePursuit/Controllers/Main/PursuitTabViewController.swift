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
    searchController.tabBarItem.image = #imageLiteral(resourceName: "icons8-create-25.png")
    let profileController = UIStoryboard(name: "ProfileStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController

    profileController.title = "Profile"
    profileController.tabBarItem.image = #imageLiteral(resourceName: "user_male.png")
    
    let classroomViewController = UnitsViewController()
    classroomViewController.tabBarItem = UITabBarItem(title: "Classroom", image: UIImage(named: "graduation_cap"), tag: 1)
    let addNoteController = UINavigationController(rootViewController: AddNoteController())
    addNoteController.view.backgroundColor = .white
    addNoteController.title = "Note"
    
    let navigationController = UINavigationController(rootViewController: classroomViewController)
    
    navigationController.navigationBar.prefersLargeTitles = true
  classroomViewController.navigationItem.title = "Classroom"
    
 viewControllers = [generalController, navigationController,searchController,profileController]
    
    }
}
