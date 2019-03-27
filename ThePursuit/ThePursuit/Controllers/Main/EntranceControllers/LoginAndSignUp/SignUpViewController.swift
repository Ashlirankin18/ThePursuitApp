//
//  SignUpViewController.swift
//  FellowBlogger
//
//  Created by Ashli Rankin on 3/14/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

  @IBOutlet var signUpView: SignUpView!
  let authService = AuthService()
    override func viewDidLoad() {
        super.viewDidLoad()

      signUpView.delegate = self
      authService.authserviceCreateNewAccountDelegate = self
      signUpView.createButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
      signUpView.loginOptionPressed.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
 
  @objc func createButtonPressed(){
    presentTabbarController()
  }
 @objc func loginButtonPressed(){
   let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let loginController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") 
    loginController.modalTransitionStyle = .coverVertical
    loginController.modalPresentationStyle = .overFullScreen
    self.present(loginController, animated: true, completion: nil)
  
  }

}

extension SignUpViewController:AuthServiceCreateNewAccountDelegate{
  func didRecieveErrorCreatingAccount(_ authservice: AuthService, error: Error) {
    showAlert(title: "Error", message: "There was an error Creating an account", actionTitle: "Ok")
  }
  
  func didCreateNewAccount(_ authservice: AuthService, user: PAUser) {
    presentTabbarController()
  }
  
  func presentTabbarController(){
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let tabbarController = storyBoard.instantiateViewController(withIdentifier: "PursuitTabViewController")
    tabbarController.modalPresentationStyle = .overFullScreen
    tabbarController.modalTransitionStyle = .crossDissolve
    self.present(tabbarController, animated: true, completion: nil)
  }
  
}

  

extension SignUpViewController:SignUpViewDelegate{
  func didCreateNewAccount(_ signUpView: SignUpView) {
    if let userName = signUpView.userNameTextfield.text,
      let email = signUpView.emailTextField.text,
      let password = signUpView.passwordTextfield.text{
     authService.createNewAccount(username: userName, email: email, password: password)
  }
  
  }
  

}
