//
//  NavigationManager.swift
//  Double Plan
//
//  Created by Prince Sojitra on 22/02/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//


import Foundation
import UIKit

class NavigationManager : NSObject {
    
    private override init() { }
    
    static let shared:NavigationManager  = NavigationManager()
    
    func setEventListRootViewController() {
        let eventListVC = Constants.MAINSTORYBOARD.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.EventListVC) as! EventListVC
        let navObjc = UINavigationController.init(rootViewController: eventListVC)
        Constants.APPDELEGATE.window?.rootViewController = navObjc
    }
}

extension UINavigationController {
    
    override open var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}
