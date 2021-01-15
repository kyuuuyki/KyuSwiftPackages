//
//  +UIWindow.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 19/9/20.
//

import Foundation
import UIKit

// MARK: - Override UserInterfaceStyle
extension UIWindow {
    
    ///Override UserInterfaceStyle with specific style.
    public func overrideUserInterfaceStyle(preferredStyle: UIUserInterfaceStyle?) {
        
        let imageView = UIImageView()
        imageView.image = UIApplication.shared.delegate!.window!?.toImage()
        imageView.frame = CGRect(origin: .zero, size: frame.size)
        addSubview(imageView)
        
        UIView.animate(withDuration: 0.35, animations: {
            
            self.overrideUserInterfaceStyle = preferredStyle ?? .unspecified
            imageView.alpha = 0
            
        }, completion: { (_) in
            imageView.removeFromSuperview()
        })
    }
}
