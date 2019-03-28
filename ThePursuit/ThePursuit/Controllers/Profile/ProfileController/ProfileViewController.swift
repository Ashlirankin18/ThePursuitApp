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


class ProfileViewController: UIViewController {
    
    

  @IBOutlet weak var profileTableView: UITableView!
    
  let cellId = "ProfileCell"
    
    public lazy var profileHeaderView: ProfileHeaderView = {
        let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 270))
        return headerView
    }()
    
    
private let authServices = AppDelegate.authService
    
private var pursuitUser: PAUser?
    private var favorites = [Post](){
        didSet{
            DispatchQueue.main.async {
                self.profileTableView.reloadData()
            }
        }
    }
    
  override func viewDidLoad() {
        super.viewDidLoad()
    configureTableView()
    }
    
private func configureTableView(){
        profileTableView.tableHeaderView = profileHeaderView
        profileTableView.dataSource = self
        profileTableView.delegate = self
    
        }
    
    private func updateProfileUI(){
        guard let user = authServices.getCurrentUser() else {
            print("no logged user")
            return
        }
        DBService.fetchUser(userId: user.uid) { [weak self] (error, profile) in
            if let error = error {
                self?.showAlert(title: "Error fetching user", message: error.localizedDescription, actionTitle: "try again?")
            }
            else if let profile = profile {
                self?.pursuitUser = profile
                self?.profileHeaderView.fullNameLabel.text = self?.pursuitUser?.firstName
                self?.profileHeaderView.nicknameLabel.text = self?.pursuitUser?.nickname
                guard let photoURL = profile.photoURL,
                    !photoURL.isEmpty else {
                    return
                }
                self?.profileHeaderView.profileImageView.kf.setImage(with: URL(string: profile.photoURL ?? "No photo"), placeholder: #imageLiteral(resourceName: "placeholder"))
            }

        }
        
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
        cell.profileView.postDescription.text = favoriteItem.postDescription
        cell.profileView.createdDate.text = favoriteItem.createdDate
        //cell.profileView.postImage.image
        return cell
    }
    
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProfileCell", sender: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.PostCellHeight
    }
}

extension ProfileViewController: ProfileHeaderViewDelegate {
    func willSignOut(_ profileHeaderView: ProfileHeaderView) {
        authServices.signOut()
    }
    
    func willEditProfile(_ profileHeaderView: ProfileHeaderView) {
        performSegue(withIdentifier: "Show Edit Profile", sender: nil)
    }
    
    
}
