//
//  TableView+Extension.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
      register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T>(_: T.Type) where T: NibLoadableView, T: ReusableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            print("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func registerHeader<T>(_: T.Type) where T: NibLoadableView, T: ReusableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
}
