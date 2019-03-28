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
    
    private var units = [Units]()
    
    
    private var resources = [Resources]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func getResources() {
        listener = DBService.firestoreDB
            .collection("classes").document("ytQtzAfmMgFIbaGt9IFq").collection("resources")
            .addSnapshotListener { [weak self] (snapshot, error) in
                if let error = error {
                    print("failed to fetch resources with error: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    self?.resources = (snapshot.documents.map { Resources(dict: $0.data()) })
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
                    self?.getResources()
                }
          }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUnits()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        if indexPath.section == 0 {
            cell.textLabel?.text = units[indexPath.row].unitName
            
        } else {
            cell.textLabel?.text = resources[indexPath.row].resourceName
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return units.count
        }else{
            return resources.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
           return "Units"
        } else  {
             return "Resources"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: "\(tableView.index)")
    }
}
