//
//  Resources.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation

struct Resources {
  
  let resourceName:String
  let resourceLink:String
    let tag:String
  
    init(resourceName:String,resourceLink:String,tag:String){
    self.resourceName = resourceName
    self.resourceLink = resourceLink
    self.tag = tag
  }
  init(dict:[String:Any]){
    self.resourceLink = dict[ResourceCollectionKeys.resourceLink] as? String ?? "no resource link found"
    self.resourceName = dict[ResourceCollectionKeys.resourceName] as? String ?? "no resource name found"
    self.tag = dict[ResourceCollectionKeys.tag] as? String ?? "no resource tag found"
  }
}
