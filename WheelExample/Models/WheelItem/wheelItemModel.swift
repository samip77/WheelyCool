//
//  WheelItemModel.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import Foundation
import RealmSwift

class WheelItemModel: Object {
  @objc dynamic var id = ""
  @objc dynamic var title = ""
  
  convenience init(id: String, title: String) {
    self.init()
    self.id = id
    self.title = title
  }
  
  override class func primaryKey() -> String? {
    return "id"
  }
}
