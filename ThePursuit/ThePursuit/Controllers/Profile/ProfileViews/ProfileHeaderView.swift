//
//  ProfileHeaderView.swift
//  ThePursuit
//
//  Created by Yaz Burrell on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
protocol ProfileHeaderViewDelegate: AnyObject {
    func willSignOut(_ profileHeaderView: ProfileHeaderView)
    func willEditProfile(_ profileHeaderView: ProfileHeaderView)
}
class ProfileHeaderView: UIView {
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileImageView: CircularImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var cohortLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ProfileViewHeader", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        delegate?.willEditProfile(self)
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        delegate?.willEditProfile(self)
    }
    
}
