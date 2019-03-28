//
//  ClassroomViewController.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Firebase

class UnitsViewController: UITableViewController {
    
    let cellId = "UnitCell"
    let classData = [UnitsCollectionKeys.CollectionKey,ResourceCollectionKeys.CollectionKeys]
    
    private var listener: ListenerRegistration!
    private var authservice = AppDelegate.authService
    
    private var units = [Units]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
//    @objc private func fetchBlogPosts() {
//        refreshControl.beginRefreshing()
//        listener = DBService.firestoreDB
//            .collection(BlogsCollectionKeys.CollectionKey)
//            .addSnapshotListener { [weak self] (snapshot, error) in
//                if let error = error {
//                    print("failed to fetch blogs with error: \(error.localizedDescription)")
//                } else if let snapshot = snapshot {
//                    self?.blogs = snapshot.documents.map { Blog(dict: $0.data()) }
//                        .sorted { $0.createdDate.date() > $1.createdDate.date() }
//                }
//                DispatchQueue.main.async {
//                    self?.refreshControl.endRefreshing()
//                }
//        }
//    }
//
    @objc private func getUnits() {
        listener = DBService.firestoreDB
        .collection(UnitsCollectionKeys.CollectionKey)
            .addSnapshotListener { [weak self] (snapshot, error) in
                if let error = error {
                    print("failed to fetch units with error: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    self?.units = (snapshot.documents.map { Units(dict: $0.data()) })
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnitCell", for: indexPath)
        cell.textLabel?.text = units.description
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return units.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        <#code#>
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        <#code#>
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        <#code#>
    }

}
