//
//  UIViewController+Alert.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(with title: String,
                 and message: String,
                 preferredStyle: UIAlertController.Style = .actionSheet){
    let alert = UIAlertController(title: title,
                                  message: message,
                                  preferredStyle:preferredStyle)
    let cancel = UIAlertAction(title: "OK", style: .destructive)
    alert.addAction(cancel)
    
    present(alert, animated: true)
  }
  
  func showTextInputAlert(with title: String,
                          and message: String,
                          preferredStyle: UIAlertController.Style = .actionSheet,
                          onSave: @escaping (String)->()) {
    let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert )
    alert.addTextField { (textField) in
      textField.placeholder = message
      textField.textColor = AppConstants.Color.textField
    }
    
    let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
      let textField = alert.textFields![0] as UITextField
      guard let text = textField.text, !text.isEmpty else { return }
      onSave(text)
    }
    let cancel = UIAlertAction(title: "Cancel", style: .destructive)
    
    alert.addAction(save)
    alert.addAction(cancel)
    
    present(alert, animated:true, completion: nil)
  }
}
