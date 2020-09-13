//
//  WheelItemListTableViewCell.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

class WheelItemListTableViewCell: UITableViewCell, NibLoadableView {
  
  @IBOutlet private weak var wheelItemNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    initialSetup()
  }
  
  func initialSetup() {
    wheelItemNameLabel.font = AppConstants.Font.cellTitle
    wheelItemNameLabel.textColor = AppConstants.Color.cellTitleLabel
  }
  
  func configure(with viewModel: WheelItemViewModel, and index: Int) {
    wheelItemNameLabel.text = viewModel.title
    contentView.backgroundColor = index % 2 == 0
      ? AppConstants.Color.cellBackground : .white
  }
}
