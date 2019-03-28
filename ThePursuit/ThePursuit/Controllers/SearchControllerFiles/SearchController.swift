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
    
    getNotes()
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
    DBService.firestoreDB.collection(NotesCollectionKeys.CollectionKeys).whereField(NotesCollectionKeys.PosterId, isEqualTo: "admin")
      .addSnapshotListener {[weak self] (snapshot, error) in
      if let error = error {
        self?.showAlert(title: "Error", message: "there was an error getting your notes: \(error.localizedDescription)", actionTitle: "Tryagain")
      }
      else if let snapshot = snapshot {
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
}
extension SearchController:UITableViewDataSource{
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
  
  
}
extension SearchController:UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    notes = notes.filter{$0.tag.lowercased().contains(searchText.lowercased())}
  }
}
