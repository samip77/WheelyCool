//
//  WheelItemListViewController.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit
import Combine

class WheelItemListViewController: UIViewController {
  
  //MARK:- IBOutlets and Variables
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var doneButton: UIButton!
  
  private lazy var refreshControl: UIRefreshControl = {
    let control = UIRefreshControl()
    control.addTarget(self, action: #selector(self.loadWheelItems), for: .valueChanged)
    return control
  }()
  
  private lazy var backgroundForNoData: UIView = {
    let label = UILabel(frame: .init(origin: .zero, size: CGSize(width: self.tableView.bounds.width, height: 44)))
    
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .lightGray
    label.text = "There is no item in Database. Click + on Navigation Bar to add an item."
    
    let containter = UIStackView()
    containter.addArrangedSubview(label)
    return containter
  }()
  
  private var viewModel: WheelItemListViewModel =  WheelItemListViewModel(with: WheelItemListRealmRepository())
  
  private var cancellables: Set<AnyCancellable> = []
  
  //MARK:- LifeCycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bindViewModel()
    loadWheelItems()
  }
  
  func setup(){
    title = "Wheel Item List"
    
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.register(WheelItemListTableViewCell.self)
    tableView.addSubview(refreshControl)
    
    let addItemButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addItemButtonAction))
    self.navigationItem.rightBarButtonItem = addItemButton
    
    doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    doneButton.roundedFilled(with: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), and: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
  }
  
  //MARK:- ViewModel Binding
  func bindViewModel() {
    bindTableView()
    bindDoneButton()
    bindErrorMessage()
    bindRefreshControl()
  }
  
  func bindDoneButton() {
    viewModel.$enableNavigation.sink { [weak self] (enable) in
      self?.doneButton.isEnabled = enable
    }.store(in: &cancellables)
  }
  
  func bindTableView() {
    viewModel.$items.sink { [weak self] (items) in
      if items.count == 0 {
        self?.tableView.backgroundView = self?.backgroundForNoData
      }else {
        self?.tableView.backgroundView = nil
      }
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }.store(in: &cancellables)
  }
  
  func bindRefreshControl(){
    viewModel.$isLoading.sink { [weak self] (loading) in
      DispatchQueue.main.async {
        if loading {
          self?.refreshControl.beginRefreshing()
        }else {
          self?.refreshControl.endRefreshing()
        }
      }
    }.store(in: &cancellables)
  }
  
  func bindErrorMessage(){
    viewModel.$errorMessage.sink { [weak self] (error) in
      if let errorMessage = error {
        DispatchQueue.main.async {
          self?.showAlert(with: "Error", and: errorMessage, preferredStyle: .alert)
        }
      }
    }.store(in: &cancellables)
  }
  
  //MARK:- IBActions and Actions
  @objc func addItemButtonAction() {
    self.showTextInputAlert(with: "Enter Name", and: "Name of Slice") { (text) in
      self.viewModel.saveItem(with: text)
    }
  }
  
  @objc func loadWheelItems() {
    viewModel.loadWheelItems()
  }
  
  @IBAction func doneButtonAction(_ sender: UIButton) {
    let viewController = WheelViewController.load(with: WheelViewModel(viewModel.items))
    self.present(viewController, animated: true, completion: nil)
  }
}

//MARK:- TableView DataSource
extension WheelItemListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:WheelItemListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    cell.configure(with: viewModel.items[indexPath.row], and: indexPath.row)
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      viewModel.deleteItem(at: indexPath.row)
    }
  }
}

