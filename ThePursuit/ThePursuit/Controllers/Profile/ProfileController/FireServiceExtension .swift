//
//  FireServiceExtension .swift
//  ThePursuit
//
//  Created by Yaz Burrell on 3/28/19.
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
    
    static public func deleteFavorite(post: Post, completion: @escaping (Error?) -> Void) {
        DBService.firestoreDB
            .collection(PostCollectionKeys.CollectionKey)
            .document(post.postId)
            .delete { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
        }
    }
}
