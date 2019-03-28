//
//  FirestoreService.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

struct PAUserCollectionKeys {
  static let CollectionKey = "PAUser"
  static let PAUserIdKey = "posterId"
  static let NicknameKey = "nickname"
  static let FirstNameKey = "firstName"
  static let LastNameKey = "lastName"
  static let EmailKey = "email"
  static let PhotoURLKey = "photoURL"
  static let BioKey = "bio"
}

struct PostCollectionKeys {
  static let CollectionKey = "posts"
  static let PostDescriptionKey = "postDescription"
  static let PosterId = "posterId"
  static let CreatedDateKey = "createdDate"
  static let DocumentIdKey = "documentId"
  static let ImageURLKey = "imageURL"
  static let TagKey = "tag"
}

struct CommentCollectionKeys{
  static let CollectionKey = "comments"
  static let commentId = "commentId"
  static let createdDate = "createdDate"
  static let commentedBy = "commentedBy"
  static let commentText = "commentText"
  static let blogId = "blogId"
}

struct UnitsCollectionKeys{
  static let CollectionKey = "units"
  static let unitName = "unitName"
  static let unitLink = "unitLink"
}

struct ResourceCollectionKeys{
  static let CollectionKeys = "resources"
  static let resourceName = "resourceName"
  static let resourceLink = "resourceLink"
}
struct NotesCollectionKeys{
  static let CollectionKeys = "notes"
  static let DescriptionKey = "description"
  static let CreatedDateKey = "createdDate"
  static let TagKey = "tag"
  static let NoteId = "noteId"
  static let PosterId = "posterId"
}
final class DBService {
  private init() {}
  
  public static var firestoreDB: Firestore = {
    let db = Firestore.firestore()
    let settings = db.settings
    settings.areTimestampsInSnapshotsEnabled = true
    db.settings = settings
    return db
  }()
  
  static public var generateDocumentId: String {
    return firestoreDB.collection(PAUserCollectionKeys.CollectionKey).document().documentID
  }
  
  static public func createUser(user: PAUser, completion: @escaping (Error?) -> Void) {
    firestoreDB.collection(PAUserCollectionKeys.CollectionKey)
      .document(user.PAUserId)
      .setData([ PAUserCollectionKeys.PAUserIdKey: user.PAUserId,
                 PAUserCollectionKeys.NicknameKey : user.nickname ?? "",
                 PAUserCollectionKeys.EmailKey   : user.email,
                 PAUserCollectionKeys.PhotoURLKey    : user.photoURL ?? "" ,
                 PAUserCollectionKeys.BioKey         : user.bio ?? ""
      ]) { (error) in
        if let error = error {
          completion(error)
        } else {
          completion(nil)
        }
    }
  }
  
  static public func createPost(post: Post) {
    firestoreDB.collection(PostCollectionKeys.CollectionKey)
      .document(post.postId).setData([
        PostCollectionKeys.CreatedDateKey     : post.createdDate,
       PostCollectionKeys.PosterId     : post.posterId,
       PostCollectionKeys.PostDescriptionKey  : post.postDescription,
        PostCollectionKeys.ImageURLKey        : post.imageURL,
        PostCollectionKeys.DocumentIdKey      : post.postId
        ])
      { (error) in
        if let error = error {
          print("posting blog error: \(error)")
        } else {
          print("blog posted successfully to ref: \(post.postId)")
        }
    }
  }
  
  static public func createNote(note:Notes){
    firestoreDB.collection(NotesCollectionKeys.CollectionKeys).document(note.noteId).setData([NotesCollectionKeys.CreatedDateKey:note.createdDate,NotesCollectionKeys.DescriptionKey:note.description,NotesCollectionKeys.NoteId:note.noteId,NotesCollectionKeys.PosterId:note.posterId,NotesCollectionKeys.TagKey:note.tag]) { (error) in
      if let error = error {
        print("there was an error creating your note: \(error.localizedDescription)")
      }
      print("note sucessfully created")
    }
  }
}
