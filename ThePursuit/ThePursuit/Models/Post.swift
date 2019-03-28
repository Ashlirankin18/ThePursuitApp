//
//  Post.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
struct Post {
  let postTitle:String
  let postDescription:String
  let postId: String
  let imageURL:String
  let posterId:String
  let createdDate:String
  let tag:String
  
    init(postTitle:String,postDescription:String,postId:String,imageURL:String,posterId:String,createdDate:String,tag:String){
        self.postTitle = postTitle
        self.postDescription = postDescription
        self.postId = postId
        self.imageURL = imageURL
        self.posterId = posterId
        self.createdDate = createdDate
        self.tag = tag
    }
    
    init(dict: [String : Any]) {
        self.postTitle = dict[PostCollectionKeys.PostTitleKey] as? String ?? "no title"
        self.postDescription = dict[PostCollectionKeys.PostDescriptionKey] as? String ?? "no Description"
        self.postId = dict[PostCollectionKeys.DocumentIdKey] as? String ?? "no post Id"
        self.imageURL = dict[PostCollectionKeys.ImageURLKey] as? String ?? "not imageURL"
        self.posterId = dict[PostCollectionKeys.PosterId] as? String ?? "not poster Id"
        self.createdDate = dict[PostCollectionKeys.CreatedDateKey] as? String ?? "no date"
        self.tag = dict[PostCollectionKeys.TagKey] as? String ?? "not tag"
    }
    

}
