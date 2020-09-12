//
//  AppDelegate+RealmSwift.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import RealmSwift

extension AppDelegate {
  internal func setUpRealmDatabase() {
    //try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
    var config = Realm.Configuration(
      // Set the new schema version. This must be greater than the previously used
      // version (if you've never set a schema version before, the version is 0).
      schemaVersion: 1,
      // Set the block which will be called automatically when opening a Realm with
      // a schema version lower than the one set above
      migrationBlock: { migration, oldSchemaVersion in
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
          // Nothing to do!
          // Realm will automatically detect new properties and removed properties
          // And will update the schema on disk automatically
        }
    })
    
    Realm.Configuration.defaultConfiguration = config
    config = Realm.Configuration()
    config.deleteRealmIfMigrationNeeded = true
  }
}
