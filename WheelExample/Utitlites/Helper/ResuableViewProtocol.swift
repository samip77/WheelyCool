//
//  ResuableViewProtocol.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import Foundation

import UIKit

protocol ReusableView {
  static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
  static var reuseIdentifier: String {
    return NSStringFromClass(self)
  }
}

extension UITableViewCell:  ReusableView { }

