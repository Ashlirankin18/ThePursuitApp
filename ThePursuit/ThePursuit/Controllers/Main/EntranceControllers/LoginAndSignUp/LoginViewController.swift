//
//  LoginViewController.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
  
  @IBOutlet var loginView: LoginInView!
  private let authService = AuthService()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loginView.delegate = self
    authService.authserviceExistingAccountDelegate = self
    loginView.createOptionButton.addTarget(self, action: #selector(createOptionsPressed), for: .touchUpInside)
  }
  func createNewUser(email:String,password:String){
    authService.signInExistingAccount(email: email, password: password)
  }
  
  @objc func createOptionsPressed(){
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let createViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController")
    createViewController.modalPresentationStyle = .overFullScreen
    createViewController.modalTransitionStyle = .coverVertical
    self.present(createViewController, animated: true, completion: nil)
  }
}

extension LoginViewController:LoginViewDelegate{
  func userDidSelectLoginButton(_ loginView: LoginInView, loginStatus: AccountLoginStatus) {
    if let email = loginView.userEmail.text,
      let password = loginView.userPassword.text {
      createNewUser(email: email, password: password)
    }
    
  }
  
  
}
extension LoginViewController:AuthServiceExistingAccountDelegate{
  func didRecieveErrorSigningToExistingAccount(_ authservice: AuthService, error: Error) {
    showAlert(title: "Error", message: "There was an error signing in try again", actionTitle: "ok")
  }
  
  func didSignInToExistingAccount(_ authservice: AuthService, user: User) {
    presentFellowBloggerTabbarController()
  }
  
  private func presentFellowBloggerTabbarController(){
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let tabBarController = storyBoard.instantiateViewController(withIdentifier: "PursuitTabViewController")
    tabBarController.modalTransitionStyle = .crossDissolve
    tabBarController.modalPresentationStyle = .overFullScreen
    self.present(tabBarController, animated: true, completion: nil)
  }
  
}
