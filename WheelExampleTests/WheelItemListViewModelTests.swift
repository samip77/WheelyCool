//
//  WheelItemListViewModelTests.swift
//  WheelExampleTests
//
//  Created by Samip shah on 13/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import XCTest
@testable import WheelExample

class WheelItemListViewModelTests: XCTestCase {
   var repository: WheelItemListRepository!
    var viewModel: WheelItemListViewModel!
    
    override func setUp() {
      super.setUp()
       repository = MockWheelItemListRepository()
       viewModel = WheelItemListViewModel(with: repository)
    }
    
    override func tearDown() {
      super.tearDown()
      repository = nil
      viewModel = nil
    }
    
    func testInitialItemCount() {
      let itemCount = viewModel.items.count
      XCTAssert(itemCount == 0, "Initally Count should be zero")
    }
    
    func testloadWheelItems() {
      viewModel.loadWheelItems()
      let itemCount = viewModel.items.count
      XCTAssert(itemCount == 3, "Item Count should be 3 after loadWheelItems, instead found \(itemCount)")
    }

    func testDeleteItems() {
      viewModel.loadWheelItems()
      viewModel.deleteItem(at: 0)
      let itemCount = viewModel.items.count
      XCTAssert(itemCount == 2, "Item Count should be 2 after deleteItem, instead found \(itemCount)")
    }
    
    func testDeleteItemsError() {
      repository = MockWheelItemListRepository(withError: true)
      viewModel = WheelItemListViewModel(with: repository)
      
      viewModel.loadWheelItems()
      viewModel.deleteItem(at: 0)
      let itemCount = viewModel.items.count
      let error = viewModel.errorMessage
      
      guard let errorMessage = error else {
        return XCTFail("There should be error from Database")
      }
      
      XCTAssert(errorMessage.elementsEqual(RealmError.deleteError.localizedDescription),
                "There should be \(RealmError.deleteError.localizedDescription) error, instead found \(errorMessage)")
      XCTAssert(itemCount == 3, "Item Count should not change after deleteItem, instead found \(itemCount)")
    }
    
    func testSaveItem() {
     viewModel.loadWheelItems()
     viewModel.saveItem(with: "Samip")
     let itemCount = viewModel.items.count
     let lastAdded = (repository as? MockWheelItemListRepository)?.lastItem()
     XCTAssert(itemCount == 4, "Item Count should be 4 after deleteItem, instead found \(itemCount)")
     
     guard let last = lastAdded else {
       return XCTFail("Last Added Item should not be nil")
     }
     
     XCTAssert(last.title.elementsEqual("Samip"), "Last added Item should be correct")
    }
    
    func testSaveItemError() {
      repository = MockWheelItemListRepository(withError: true)
      viewModel = WheelItemListViewModel(with: repository)
      
      viewModel.loadWheelItems()
      viewModel.saveItem(with: "Samip")
      
      let itemCount = viewModel.items.count
      let error = viewModel.errorMessage
    
      guard let errorMessage = error else {
        return XCTFail("There should be error from Database")
      }
      
      XCTAssert(errorMessage.elementsEqual(RealmError.writeError.localizedDescription),
                "There should be \(RealmError.writeError.localizedDescription) error, instead found \(errorMessage)")
      XCTAssert(itemCount == 3, "Item Count should not change after saveItem, instead found \(itemCount)")
    }
}




