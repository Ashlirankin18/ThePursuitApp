//
//  Units.swift
//  ThePursuit
//
//  Created by Ashli Rankin on 3/27/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import Foundation

struct Units{
  let unitLink:String
  let unitName:String
  
  init(unitLink:String,unitName:String){
    self.unitLink = unitLink
    self.unitName = unitName
  }
  
  init(dict:[String:Any]){
    self.unitName = dict[UnitsCollectionKeys.unitName] as? String ?? "no unit name found"
    self.unitLink = dict[UnitsCollectionKeys.unitLink] as? String ?? "no unit link found"
  }
}
