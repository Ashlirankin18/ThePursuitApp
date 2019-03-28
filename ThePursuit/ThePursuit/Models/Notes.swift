//
//  Notes.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation

struct Notes {
  let description:String
  let createdDate:String
  let tag:String
  let noteId: String
  let posterId:String
  let title:String
  init(description:String,createdDate:String,tag:String,noteId:String,posterId:String,title:String){
    self.description = description
    self.createdDate = createdDate
    self.tag = tag
    self.noteId = noteId
    self.posterId = posterId
    self.title = title
  }
  
  init(dict:[String:Any]){
    self.createdDate = dict[NotesCollectionKeys.CreatedDateKey] as? String ?? "no created date found"
    self.description = dict[NotesCollectionKeys.DescriptionKey] as? String ?? "no description found"
    self.tag = dict[NotesCollectionKeys.TagKey] as? String ?? "no tag found"
    self.noteId = dict[NotesCollectionKeys.NoteId] as? String ?? "no note id found"
    self.posterId = dict[NotesCollectionKeys.PosterId] as? String ?? "no poster Id Found"
    self.title = dict[NotesCollectionKeys.title] as? String ?? "no title found"
  }
  
}
