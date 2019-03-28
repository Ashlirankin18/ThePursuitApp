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
  let authService = AuthService()
  var addButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
      view.addSubview(addNoteView)
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
      
    addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonPressed))
      self.navigationItem.rightBarButtonItem = addButton
      
      self.navigationItem.title = "Create Note"
navigationController?.navigationBar.prefersLargeTitles = true
      addNoteView.postTag.delegate = self
      addNoteView.postTitle.delegate = self
      addNoteView.postDescription.delegate = self
  }
  
  @objc func backButtonPressed(){
    navigationController?.dismiss(animated: true)
  }
  
  @objc func addButtonPressed(){
    guard let user = authService.getCurrentUser() else {return}
  
    guard  !addNoteView.postDescription.text.isEmpty,
      !(addNoteView.postTag.text?.isEmpty)!,
      !(addNoteView.postTitle.text?.isEmpty)!
    else {
    showAlert(title: "Missing Fields", message: "All fields are required", actionTitle: "TryAgain")
      return
    }
     let createdDate = Date.getISOTimestamp()
     let noteId = DBService.generateDocumentId
    let note = Notes(description: addNoteView.postDescription.text, createdDate: createdDate, tag: addNoteView.postTag.text!, noteId: noteId, posterId: user.uid, title:addNoteView.postTitle.text! )
    DBService.createNote(note: note)
    
  }
    
}
extension AddNoteController:UITextFieldDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    return true
  }
}

  extension AddNoteController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
      if !textView.text.isEmpty {
        textView.text = ""
        textView.textColor = .black
      }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      if text == "\n"{
        textView.resignFirstResponder()
        return false
      }
      return true
    }
  }


