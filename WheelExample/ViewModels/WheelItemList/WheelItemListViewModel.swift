//
//  WheelItemListViewModel.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import Foundation
import Combine


class WheelItemListViewModel: ObservableObject  {
  private var repository: WheelItemListRepository
  private let itemLimit = 10
  
  @Published var isLoading = false
  @Published var errorMessage: String?
  @Published var enableNavigation = false
  @Published var items: [WheelItemViewModel] = [] {
    didSet {
      enableNavigation = items.count > 0
    }
  }
  
  init(with repository: WheelItemListRepository) {
    self.repository = repository
  }
  
  func saveItem(with title: String){
    guard items.count <= itemLimit else {
      self.errorMessage = "You exceeded the limit of \(itemLimit). Try Deleting few Items."
      return
    }
    
    isLoading = true
    
    let id = Date().description
    let wheelItem = WheelItemModel(id: id, title: title)
    
    repository.save(wheelItem) { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success:
        self.items.append(WheelItemViewModel(wheelItem))
      case .failure(let error):
        self.errorMessage = error.localizedDescription
      }
      
      self.isLoading = false
    }
  }
  
  func deleteItem(at index: Int) {
    guard index < items.count else { return }
    
    isLoading = true
    let item: WheelItemViewModel = items[index]
    
    repository.deleteWheelItem(with: item.primaryKey) { [weak self] (result) in
      guard let self = self else { return }
      
      switch result {
      case .success:
        self.items.remove(at: index)
        break
      case .failure(let error):
        print(error.localizedDescription)
        self.errorMessage = error.localizedDescription
      }
      
      self.isLoading = false
    }
  }
  
  func loadWheelItems(){
    isLoading = true
    
    repository.getWheelItemList { [weak self] (result) in
      guard let self = self else { return }
      
      switch result {
      case .success(let items):
        self.items = items.map{ WheelItemViewModel($0)}
      case .failure(let error):
        self.errorMessage = error.localizedDescription
      }
      
      self.isLoading = false
    }
  }
}
