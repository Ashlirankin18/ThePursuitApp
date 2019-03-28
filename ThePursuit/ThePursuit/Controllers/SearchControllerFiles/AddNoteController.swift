//
//  AddNoteViewController.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/28/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class AddNoteController: UIViewController {

  let addNoteView = AddNoteView()

    override func viewDidLoad() {
        super.viewDidLoad()
      view.addSubview(addNoteView)
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
    self.navigationItem
  }
  
  @objc func backButtonPressed(){
    dismiss(animated: true, completion: nil)
  }
  

    
}
