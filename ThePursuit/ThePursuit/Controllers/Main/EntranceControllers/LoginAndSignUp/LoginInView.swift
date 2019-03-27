//
//  LoginInView.swift
//  FellowBlogger
//
//  Created by Ashli Rankin on 3/14/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
enum AccountLoginStatus{
  case newAccount
  case existingAccount
}
protocol LoginViewDelegate:AnyObject
{
  func userDidSelectLoginButton(_ loginView:LoginInView,loginStatus:AccountLoginStatus)
}

class LoginInView: UIView {
  weak var delegate:LoginViewDelegate?
  
  @IBOutlet var contentView: LoginInView!
  @IBOutlet weak var userEmail: UITextField!
  @IBOutlet weak var userPassword: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var createOptionButton: UIButton!
  
  private let nibName = "LoginView"
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
   super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit(){
    
    Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
  }
 @objc func loginButtonPressed(){
  delegate?.userDidSelectLoginButton(self, loginStatus: .existingAccount)
  }

}
