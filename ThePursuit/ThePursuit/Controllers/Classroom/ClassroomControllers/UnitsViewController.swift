//
//  ClassroomViewController.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Firebase
import SafariServices

class UnitsViewController: UITableViewController, SFSafariViewControllerDelegate {
    
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
        setTableViewBackgroundGradient(sender: self, UIColor(hexString: "#4242EA"), UIColor(hexString: "#FFFFFF"))
    }
    
    
    func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor:UIColor, _ bottomColor:UIColor) {
        
        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations = [0.0,1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = gradientLocations as [NSNumber]
        
        gradientLayer.frame = sender.tableView.bounds
        let backgroundView = UIView(frame: sender.tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        sender.tableView.backgroundView = backgroundView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.backgroundColor = UIColor.clear
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
        return 100
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(hexString: "#4242EA")
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let url = URL(string: units[indexPath.row].unitLink) else {return}
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
            safariVC.preferredBarTintColor = .black
        } else {
            guard let url = URL(string: resources[indexPath.row].resourceLink) else {return}
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
            safariVC.preferredBarTintColor = .black
        }
        
    }


    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
