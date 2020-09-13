//
//  RealmService.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import Foundation
import RealmSwift


class ReamlService {
  static let shared = ReamlService()
  
  private let realm = try! Realm()
  
  private init() { }
  
  func save<T: Object>(_ object: T, onCompletion: (Result<Bool, Error>) -> ()) {
    do {
      try realm.write{
        realm.add(object, update: .modified)
        onCompletion(.success(true))
      }
    } catch {
      onCompletion(.failure(RealmError.writeError))
    }
  }
  
  func getItems<T: Object>(onCompletion: (Result<[T], Error>) -> ()) {
    let objects: [T] = realm.objects(T.self).map{ $0 }
    onCompletion(.success(objects))
  }
  
  func deleteItem<T: Object>(of type: T.Type,
                             with primaryKey: String,
                             onCompletion: (Result<Bool, Error>) -> ()) {
    guard let  object = realm.object(ofType: type, forPrimaryKey: primaryKey) else {
      onCompletion(.failure(RealmError.objectNotFound))
      return
    }
    
    do {
      try realm.write {
        realm.delete(object)
        onCompletion(.success(true))
      }
    } catch {
      onCompletion(.failure(RealmError.deleteError))
    }
  }
}
