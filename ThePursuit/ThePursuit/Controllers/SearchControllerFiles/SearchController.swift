//
//  SearchController.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
  
  
  let notesView = NotesResultViews()
  let authService = AuthService()
  
  let cellId = "SearchCell"
  var notes = [Notes](){
    didSet{
      notesView.notesTableView.reloadData()
      
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  setupNavigationBar()
    view.addSubview(notesView)
    notesView.notesTableView.dataSource = self
    notesView.notesTableView.delegate = self
    getNotes()
    let date = Date.getISOTimestamp()
    print(date)
  }
  
  func setupNavigationBar(){
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Notes"
    let searchController = UISearchController(searchResultsController: nil)
    navigationItem.searchController = searchController
    searchController.searchBar.delegate = self
  navigationItem.hidesSearchBarWhenScrolling = false
    searchController.searchBar.barStyle = .blackOpaque
  searchController.hidesNavigationBarDuringPresentation = false
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonPressed))
  }
  func getNotes(){
    guard let user = authService.getCurrentUser() else {return};DBService.firestoreDB.collection(NotesCollectionKeys.CollectionKeys).whereField(NotesCollectionKeys.PosterId, isEqualTo: user.uid )
      .addSnapshotListener {[weak self] (snapshot, error) in
      if let error = error {
        self?.showAlert(title: "Error", message: "there was an error getting your notes: \(error.localizedDescription)", actionTitle: "Tryagain")
      }
      else if let snapshot = snapshot {
        self?.notes.removeAll()
        snapshot.documents.forEach{
          self?.notes.append(Notes(dict: $0.data()))
        }
      }
    }
  }
  
  @objc func addButtonPressed(){
    let addController = AddNoteController()
    addController.modalTransitionStyle = .coverVertical
    addController.modalPresentationStyle = .currentContext
    self.present(UINavigationController(rootViewController: addController), animated: true, completion: nil)
  }
  
  func deleteNote(note:Notes){
    DBService.firestoreDB.collection(NotesCollectionKeys.CollectionKeys).document(note.noteId).delete { (error) in
      if let error = error {
        self.showAlert(title: "Error!", message: "there was an error deleting your post: \(error)", actionTitle: "TryAgain")
      }
      
      print("Post sucessfully deleted")
      
    }
  }
}
extension SearchController:UITableViewDataSource,UITableViewDelegate{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = notesView.notesTableView.dequeueReusableCell(withIdentifier:cellId , for: indexPath)
    cell.accessoryType = .disclosureIndicator
    let note = notes[indexPath.row]
    cell.textLabel?.text = note.description
    cell.detailTextLabel?.text = "#\(note.tag)"
  
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  let note = notes[indexPath.row]
   let detailledController = AddNoteController()
    detailledController.navigationItem.title = "MyNote"
    detailledController.addNoteView.postDescription.text = note.description
    detailledController.addNoteView.postTitle.text = note.title
    detailledController.addNoteView.postDescription.isEditable = false
    detailledController.addNoteView.postTag.isEnabled = false
        detailledController.addNoteView.postTitle.isEnabled = false
    
self.navigationController?.pushViewController(detailledController, animated: true)
    
  }
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (delete, indexPath) in
      let note = self.notes[indexPath.row]
      self.deleteNote(note: note)
  }
    return [deleteAction]
  }
}
extension SearchController:UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    if searchBar.text?.isEmpty ?? false  {
      getNotes()
    }else{
      notes = notes.filter{$0.tag.lowercased().contains(searchText.lowercased())}
    }
    
  }
}
