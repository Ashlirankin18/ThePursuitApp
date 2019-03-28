//
//  NotesResultView.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class NotesResultViews:UIView {
  
  lazy var notesTableView: UITableView = {
    let tableView = UITableView(frame: frame, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    tableView.backgroundColor = .white
   
    return tableView
  }()
  let cellId = "SearchCell"
  
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  func commonInit(){
    setupConstraints()
    
    
  }
  
  
}
extension NotesResultViews{
  func setupConstraints(){
    addSubview(notesTableView)
    notesTableView.translatesAutoresizingMaskIntoConstraints = false
    notesTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    notesTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    notesTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    notesTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
}
