//
//  AddNoteView.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/28/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class AddNoteView:UIView {
  
  @IBOutlet var contentView: UIView!
  
  
  @IBOutlet weak var postTitle: UITextField!
  
  
  @IBOutlet weak var postDescription: UITextView!
  
  @IBOutlet weak var postTag: UITextField!
  
  
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit(){
    
    Bundle.main.loadNibNamed("AddNoteView", owner: self, options: nil)
     addSubview(contentView)
    contentView.frame = self.bounds
    postTitle.placeholder = "Enter a title for your note"
    postTag.placeholder = "enter your text"
  }
  
}
