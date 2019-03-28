//
//  ProfileViewController.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

//Using PAUser Model
//unwind from bio view?

import UIKit
import Kingfisher

protocol ProfileSignOutDelegate: AnyObject {
    func didSignOut(_ profileVC: ProfileViewController)
}

class ProfileViewController: UIViewController {
    
    weak var delegate: ProfileSignOutDelegate?

  @IBOutlet weak var profileTableView: UITableView!
  let cellId = "ProfileCell"
    public lazy var profileHeaderView: ProfileHeaderView = {
        let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 240))
        return headerView
    }()
    
    
private let authServices = AppDelegate.authService
private var pursuitUser: PAUser!
    private var favorites = [Post](){
        didSet{
            DispatchQueue.main.async {
                self.profileTableView.reloadData()
            }
        }
    }
    
  override func viewDidLoad() {
        super.viewDidLoad()
    profileTableView.tableHeaderView = profileHeaderView
    profileTableView.dataSource = self
    profileTableView.delegate = self
    configureTableView()
    }
private func configureTableView(){
        profileTableView.tableHeaderView = profileHeaderView
        profileTableView.dataSource = self
        profileTableView.delegate = self
        profileTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        }
    
    private func updateProfileUI(){
        guard let user = authServices.getCurrentUser() else {
            print("no logged user")
            return
        }
        DBService.fetchPostCreator(userId: user.displayName!) { (error, poster) in
            if let error = error {
                print("no annoucements posted")
            } else if let poster = poster {
                
            }
        }
        
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.didSignOut(self)
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else {
             fatalError("ProfileCell not found")
        }
        let favoriteItem = favorites[indexPath.row]
        cell.textLabel?.text = favoriteItem.postTitle
        return cell
    }
    
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: cellId, sender: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.BlogCellHeight
    }
}
