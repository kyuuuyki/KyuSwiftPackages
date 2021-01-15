//
//  +UINavigationController.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 24/8/20.
//

import Foundation
import UIKit

// MARK: - Configure Navigation Bar
extension UINavigationController {
    
    ///Configure NavigationBar starting state.
    public func configure(shouldShowNavigationBar: Bool = true) {
        
        if navigationBar.isHidden && shouldShowNavigationBar {
            setNavigationBarHidden(false, animated: true)
        }
        else if !shouldShowNavigationBar {
            setNavigationBarHidden(true, animated: true)
        }
    }
    
    ///Configure NavigationBar starting style.
    public func configureNavigationBarStyle(isFullyTransparent: Bool = false) {
        
        navigationBar.tintColor = Defaults.defaults().color
        interactivePopGestureRecognizer?.isEnabled = true
        
        if Defaults.defaults().navigationBarBackgroundImage == nil {
            Defaults.defaults().navigationBarBackgroundImage = navigationBar.backgroundImage(for: .top, barMetrics: .default)
        }
        
        if Defaults.defaults().navigationBarShadowImage == nil {
            Defaults.defaults().navigationBarShadowImage = navigationBar.shadowImage
        }
        
        if isFullyTransparent {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        }
        else {
            navigationBar.setBackgroundImage(Defaults.defaults().navigationBarBackgroundImage, for: .default)
            navigationBar.shadowImage = Defaults.defaults().navigationBarShadowImage
        }
    }
}
