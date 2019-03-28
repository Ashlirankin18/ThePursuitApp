//
//  PostView.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

protocol PostDetailsDelegate {
//    func addToFavorites() {
//    
//    }
}

class PostView: UIView {


    @IBOutlet var postContainterView: UIView!
    @IBOutlet weak var posterProfileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
        override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PostView", owner: self, options: nil)
        addSubview(postContainterView)
        postContainterView.frame = bounds
    }
    
    
}
