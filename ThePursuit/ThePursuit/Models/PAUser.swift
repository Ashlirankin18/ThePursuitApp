//
//  PAUser.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation

struct PAUser{
  let firstName:String?
  let lastName: String?
  let photoURL:String?
  let email: String
  let nickname: String?
  let bio: String?
  let PAUserId:String

  init (firstName:String?,lastName:String?,photoURL:String?,email:String,nickname:String?,bio:String?,PAUserId:String){
    
    self.firstName = firstName
    self.lastName = lastName
    self.photoURL = photoURL
    self.email = email
    self.nickname = nickname
    self.bio = bio
    self.PAUserId = PAUserId
  }
  
  init(dict:[String:Any]){
    self.firstName = dict[PAUserCollectionKeys.FirstNameKey] as? String ?? "no first name found"
    self.lastName = dict[PAUserCollectionKeys.LastNameKey] as? String ?? "no last name found"
    self.photoURL = dict[PAUserCollectionKeys.PhotoURLKey] as? String ?? "no photo URL found"
    self.email = dict[PAUserCollectionKeys.EmailKey] as? String ?? "no email found"
    self.nickname = dict[PAUserCollectionKeys.NicknameKey] as? String ?? "no nickename found"
    self.bio = dict[PAUserCollectionKeys.BioKey]  as? String ?? "no bio found"
    self.PAUserId = dict[PAUserCollectionKeys.PAUserIdKey] as?  String ?? "no user id found"
    
  }
}
