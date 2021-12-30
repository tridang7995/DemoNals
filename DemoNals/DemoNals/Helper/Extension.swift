//
//  Extension.swift
//  DemoNals
//
//  Created by Tri Dang on 30/12/2021.
//

import Foundation
import UIKit

extension UIViewController {
    func setupNavigation(tittle: String?, leftButton: UIView?, rightButton: UIView?) {
        if let leftButton = leftButton {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        }
        if let rightButton = rightButton {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rightButton)
        }
        if let tittle = tittle {
            self.navigationItem.title = tittle
        }
    }
}
