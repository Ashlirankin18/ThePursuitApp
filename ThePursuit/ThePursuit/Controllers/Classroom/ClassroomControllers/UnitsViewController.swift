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


    @objc private func getUnits() {
        listener = DBService.firestoreDB
            .collection("classes").document("ytQtzAfmMgFIbaGt9IFq").collection("units")
            .addSnapshotListener { [weak self] (snapshot, error) in
                if let error = error {
                    print("failed to fetch units with error: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    self?.units = (snapshot.documents.map { Units(dict: $0.data()) }).sorted{
                        $0.unitName < $1.unitName
                    }
                }
          }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUnits()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        cell.textLabel?.text = units[indexPath.row].unitName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return units.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Units"
//    }

}
