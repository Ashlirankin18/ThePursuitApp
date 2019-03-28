//
//  DBExtension.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/28/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

extension DBService {
  
  static public func fetchUser(userId: String, completion: @escaping (Error?, PAUser?) -> Void) {
    DBService.firestoreDB
      .collection(PAUserCollectionKeys.CollectionKey)
      .whereField(PAUserCollectionKeys.PAUserIdKey, isEqualTo: userId)
      .getDocuments { (snapshot, error) in
        if let error = error {
          completion(error, nil)
        } else if let snapshot = snapshot?.documents.first {
          let postCreator = PAUser(dict: snapshot.data())
          completion(nil, postCreator)
        }
    }
  }
}
