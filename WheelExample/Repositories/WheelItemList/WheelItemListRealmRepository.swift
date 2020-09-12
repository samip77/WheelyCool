//
//  WheelItemListRealmRepository.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import Foundation
import RealmSwift


class WheelItemListRealmRepository: WheelItemListRepository {
  private let realmService = ReamlService.shared
  
  func save(_ wheelItem: WheelItemModel, onCompletion: (Result<Bool, Error>) -> ()) {
    realmService.save(wheelItem, onCompletion: onCompletion)
  }
  
  func deleteWheelItem(with primaryKey: String, onCompletion: (Result<Bool, Error>) -> ()) {
    realmService.deleteItem(of: WheelItemModel.self, with: primaryKey, onCompletion: onCompletion)
  }
  
  func getWheelItemList(onCompletion: (Result<[WheelItemModel], Error>) -> ()) {
    realmService.getItems(onCompletion: onCompletion)
  }
}

