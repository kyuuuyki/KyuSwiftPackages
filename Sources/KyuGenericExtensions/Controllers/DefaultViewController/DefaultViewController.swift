//
//  DefaultViewController.swift
//  Drunker
//
//  Created by Chayanon Ardkham on 29/8/20.
//  Copyright © 2020 Chayanon Ardkham. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CLASS
open class DefaultViewController: UIViewController, UIGestureRecognizerDelegate {
    
    public func configure() {
        
        navigationController?.configure()
        navigationController?.configureNavigationBarStyle()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
