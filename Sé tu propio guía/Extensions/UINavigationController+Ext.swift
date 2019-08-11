//
//  UINavigationController+Ext.swift
//  Sé tu propio guía
//
//  Created by Tania Rossainz on 8/9/19.
//  Copyright © 2019 Emiliano Martínez. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    // For Xcode 9 users, childForStatusBarStyle is equal to childViewControllerForStatusBarStyle
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
