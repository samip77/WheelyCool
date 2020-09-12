//
//  WheelItemListRepository.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import Foundation


protocol WheelItemListRepository {
  func save(_ wheelItem: WheelItemModel, onCompletion: (Result<Bool, Error>) -> ())
  func deleteWheelItem(with primaryKey: String, onCompletion: (Result<Bool, Error>) -> ())
  func getWheelItemList(onCompletion: (Result<[WheelItemModel], Error>) -> ())
}
