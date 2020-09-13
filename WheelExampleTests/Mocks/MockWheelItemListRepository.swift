//
//  MockWheelItemListRepository.swift
//  WheelExampleTests
//
//  Created by Samip shah on 13/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import Foundation
@testable import WheelExample

class MockWheelItemListRepository: WheelItemListRepository {
  private var showError: Bool
  private var items = [ WheelItemModel(id: "0", title: "Title1"),
               WheelItemModel(id: "0", title: "Title2"),
               WheelItemModel(id: "0", title: "Title3") ]
  
  init(withError showError: Bool = false) {
    self.showError = showError
  }
  
  func save(_ wheelItem: WheelItemModel, onCompletion: (Result<Bool, Error>) -> ()) {
    if showError {
      onCompletion(.failure(RealmError.writeError))
    } else {
      items.append(wheelItem)
      onCompletion(.success(true))
    }
  }
  
  func deleteWheelItem(with primaryKey: String, onCompletion: (Result<Bool, Error>) -> ()) {
    if showError {
         onCompletion(.failure(RealmError.deleteError))
    } else {
      items.remove(at: 0)
      onCompletion(.success(true))
    }
  }
  
  func getWheelItemList(onCompletion: (Result<[WheelItemModel], Error>) -> ()) {
    onCompletion(.success(items))
  }
  
  func lastItem() -> WheelItemModel?{
    return items.last
  }
}
