//
//  WheelViewController.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

class WheelViewController: UIViewController {
  //MARK:- IBOutlets and Variables
  @IBOutlet private weak var wheelyView: WheelyView!
  @IBOutlet private weak var spinButton: UIButton!
  @IBOutlet weak var winnerLabel: UILabel!
  
  private let labelAnimationDuration = 0.5
  
  private var viewModel: WheelViewModel!
  
  //MARK:- LifeCycle Methods
  class func load(with wheelViewModel: WheelViewModel) -> WheelViewController {
    let vc: WheelViewController = UIStoryboard.storyboard(storyboard: .wheel).instantiateViewController()
    vc.viewModel = wheelViewModel
    
    return vc
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  func setupView(){
    wheelyView.delegate = self
    wheelyView.dataSource = self
    
    spinButton.isEnabled = viewModel.enableSpin
    spinButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    spinButton.roundedFilled(with: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), and: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    
    winnerLabel.font = AppConstants.Font.congratulation
    winnerLabel.textColor = AppConstants.Color.congratulation
    resetWinnerLabel()
  }
  
  //MARK:- Actions
  @IBAction func spinButtonAction(_ sender: UIButton) {
    resetWinnerLabel()
    wheelyView.animate()
  }
  
  func resetWinnerLabel() {
    winnerLabel.text = nil
  }
  
  func setWinnerLabel(with winner: String) {
    self.winnerLabel.text = "Lucky Winnner is \(winner)"
  
    winnerLabel.center.x -= view.bounds.width
    UIView.animate(withDuration: labelAnimationDuration, delay: 0, options: .curveEaseInOut, animations: {
      self.winnerLabel.center.x += self.view.bounds.width
     
    }, completion: nil)
  }
}

//MARK:- WheelyView DataSource
extension WheelViewController: WheelyViewDataSource {
  func wheelyViewTotalNumberOfSlice(_ wheelyView: WheelyView) -> Int {
    return viewModel.items.count
  }
  
  func wheelyView(_ wheeyView: WheelyView, titleFor index: Int) -> String {
    return viewModel.items[index].title
  }
  
  func wheelyView(_ wheelyView: WheelyView, sliceColorFor index: Int) -> UIColor {
    return viewModel.items[index].backgroundColor
  }
  
  func wheelyView(_ wheelyView: WheelyView, titleColorFor index: Int) -> UIColor {
    return viewModel.items[index].titleColor
  }
}

//MARK:- WheelyView Delegate
extension WheelViewController: WheelyViewDelegate {
  func wheelyView(_ wheelyView: WheelyView, didSelectAt index: Int) {
    setWinnerLabel(with: viewModel.items[index].title)
  }
}
