//
//  SignUpView.swift
//  FellowBlogger
//
//  Created by Ashli Rankin on 3/14/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
protocol SignUpViewDelegate:AnyObject{
  func didCreateNewAccount(_ signUpView:SignUpView)
}
class SignUpView: UIView {

  weak var delegate: SignUpViewDelegate?
  
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var userNameTextfield: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextfield: UITextField!
  @IBOutlet weak var createButton: UIButton!
  @IBOutlet weak var loginOptionPressed: UIButton!
  private let nibName = "SignUpView"
override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit(){
    Bundle.main.loadNibNamed(nibName, owner: self, options: nil
    )
    addSubview(contentView)
    contentView.frame = self.bounds
    createButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
  }
  
  @objc func createButtonPressed(){
  delegate?.didCreateNewAccount(self)
  }

}
