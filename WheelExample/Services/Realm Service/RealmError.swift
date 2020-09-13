//
//  RealmError.swift
//  WheelExample
//
//  Created by Samip shah on 13/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import Foundation

enum RealmError: Error {
  case objectNotFound
  case writeError
  case deleteError
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
      switch self {
      case .writeError:
        return NSLocalizedString("Data could not be saved.", comment: "Database Error")
      case .objectNotFound:
        return NSLocalizedString("Object not found.", comment: "Database Error")
      case .deleteError:
        return NSLocalizedString("Could not be deleted.", comment: "Database Error")
      }
    }
}
