//
//  SceneDelegate+InitialVC.swift
//  WheelExample
//
//  Created by Samip shah on 12/9/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

import UIKit

extension SceneDelegate {
  internal func setupInitialViewController(windowScene: UIWindowScene) {
    setupNavigationAppearance()
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = self.getInitialViewController()
    window?.makeKeyAndVisible()
  }
  
  private func getInitialViewController() -> UIViewController {
    let viewController: WheelItemListViewController = UIStoryboard.storyboard(storyboard: .wheel).instantiateViewController()
    let navController = UINavigationController(rootViewController: viewController)
    return navController
  }
  
  private func setupNavigationAppearance() {
    let attributes = [NSAttributedString.Key.font: AppConstants.Font.navTitle]
    UINavigationBar.appearance().titleTextAttributes = attributes
  }
}
