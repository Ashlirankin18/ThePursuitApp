//
//  ViewController.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class GeneralViewController: UIViewController {
    
    @IBOutlet weak var generalCollection: UITableView!
    
    @IBOutlet weak var generalSearchBar: UISearchBar!
    
    let cellId = "GeneralCell"
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.generalCollection.reloadData()
            }
        }
    }
    
    private var listener: ListenerRegistration!
    private var authservice = AppDelegate.authService
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        generalCollection.refreshControl = rc
        rc.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
        return rc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generalCollection.delegate = self
        generalCollection.dataSource = self
        fetchPosts()
    }
    
    @objc private func fetchPosts() {
        refreshControl.beginRefreshing()
        listener = DBService.firestoreDB
            .collection(PostCollectionKeys.CollectionKey)
            .addSnapshotListener { [weak self] (snapshot, error) in
                if let error = error {
                    print("failed to fetch posts with error: \(error.localizedDescription)")
                } else if let snapshot = snapshot {
                    snapshot.documents.forEach{
                        let postData = Post(dict: $0.data())
                        self?.posts.append(postData)
                    }
                    DispatchQueue.main.async {
                        self?.refreshControl.endRefreshing()
                    }
                }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostDetails" {
            guard let cell = sender as? GeneralPostCell,
                let indexPath = generalCollection.indexPath(for: cell),
                let postDVC = segue.destination as? PostDetailViewController else {
                    fatalError("cannot segue to PostDVC")
            }
            let post = posts[indexPath.row]
            postDVC.postView.createdDate.text = cell.postView.createdDate.text
            postDVC.postView.fullName.text = cell.postView.fullName.text
            postDVC.postView.postDescription.text = cell.postView.postDescription.text
            postDVC.postView.postTitle.text = cell.postView.postTitle.text
            postDVC.postView.postImage.image = cell.postView.postImage.image
            postDVC.postView.posterProfileImage.image = cell.postView.posterProfileImage.image
        
            postDVC.post = post
        }
    }
}

extension GeneralViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = generalCollection.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? GeneralPostCell else { return UITableViewCell()}
        let post = posts[indexPath.row]
        cell.selectionStyle = .none
        cell.postView.fullName.text = post.posterId
        cell.postView.createdDate.text = post.createdDate
        cell.postView.postTitle.text = post.postTitle
        cell.postView.postDescription.text = post.postDescription
        cell.postView.postImage.kf.setImage(with: URL(string: post.imageURL), placeholder: #imageLiteral(resourceName: "placeholder.png") )
        cell.postView.favoriteButton.isHidden = true
        return cell
    }
}

extension GeneralViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width
    }
   
    
}
