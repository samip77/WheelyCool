//
//  WheelViewModelTests.swift
//  WheelExampleTests
//
//  Created by Samip shah on 13/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import XCTest
@testable import WheelExample

class WheelViewModelTests: XCTestCase {
  
  var viewModel: WheelViewModel!
  
  override func setUp() {
    super.setUp()
    viewModel = WheelViewModel([])
  }
  
  override func tearDown() {
    super.tearDown()
    viewModel = nil
  }

  func testEmptyWheelItemViewModelInitialize() {
    XCTAssert(viewModel.items.count == 0, "Items count should be zero., instead found \(viewModel.items.count)")
    XCTAssert(viewModel.enableSpin == false, "Enable Spin should be false, instead found \(viewModel.enableSpin)")
  }
  
  func testWheelItemViewModelInitialize() {
    let model = WheelItemViewModel(WheelItemModel(id: "0", title: "Title1"))
    viewModel = WheelViewModel([model])
    XCTAssert(viewModel.items.count == 1, "Items count should be one., instead found \(viewModel.items.count)")
    XCTAssert(viewModel.enableSpin == true, "Enable Spin should be true, instead found \(viewModel.enableSpin)")
  }

}
