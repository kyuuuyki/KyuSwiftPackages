//
//  +UIView.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 24/8/18.
//

import Foundation
import UIKit

// MARK: - Initialization
extension UIView {
    
    private class func initFromNib<T: UIView>(_ viewClass: T.Type) -> T {
        return Bundle(for: viewClass).loadNibNamed(String(describing: viewClass), owner: nil, options: nil)!.first as! T
    }
    
    ///Initialize view by ClassName.
    public class func initFromNib() -> Self {
        return initFromNib(self)
    }
}

// MARK: - Round Corner
extension UIView {
    
    ///Set corners for View.
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    
    ///Set circle for View.
    public func circle() {
        layer.cornerRadius = frame.height / 2
    }
}

// MARK: - View to Image
extension UIView {
    
    ///Get image from View.
    public func toImage() -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { ctx in
            
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}

// MARK: - Add Blurred Background Image
extension UIView {
    
    ///Add Blur Background.
    public func insertBlurredBackground(withStyle: UIBlurEffect.Style? = nil) {
        
        //Back View
        let blurEffect = UIBlurEffect(style: withStyle ?? .systemChromeMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        
        addSubview(blurEffectView)
        sendSubviewToBack(blurEffectView)
    }
}

// MARK: - SLIDE VIEW IN OR OUT
extension UIView {
    
    ///Animate slide in from edge.
    public func slideIn(from edge: UIRectEdge, withDuration: Double, delay: Double = 0, usingSpringWithDamping: CGFloat = 1, initialSpringVelocity: CGFloat = 1, options: AnimationOptions = [], animation: @escaping () -> () = {}, completion: @escaping () -> () = {}) {
        
        animate(isSlideIn: true, from: edge, withDuration: withDuration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animation: animation, completion: completion)
    }
    
    ///Animate slide out to edge.
    public func slideOut(to edge: UIRectEdge, withDuration: Double, delay: Double = 0, usingSpringWithDamping: CGFloat = 1, initialSpringVelocity: CGFloat = 1, options: AnimationOptions = [], animation: @escaping () -> () = {}, completion: @escaping () -> () = {}) {
        
        animate(isSlideIn: false, from: edge, withDuration: withDuration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animation: animation, completion: completion)
    }
    
    private func animate(isSlideIn: Bool, from edge: UIRectEdge, withDuration: Double, delay: Double, usingSpringWithDamping: CGFloat, initialSpringVelocity: CGFloat, options: AnimationOptions, animation: @escaping () -> (), completion: @escaping () -> ()) {
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        //Does not support all direction
        if edge == .all {
            return
        }
        
        //Starting Point
        var startingX: CGFloat = 0
        var startingY: CGFloat = 0
        
        if isSlideIn {

            switch edge {
            case .top:
                startingY = 0 - frame.size.height
                
            case .left:
                startingX = 0 - frame.size.width
            
            case .right:
                startingX = UIScreen.main.bounds.width
            
            case .bottom:
                startingY = UIScreen.main.bounds.height
            
            default:
                break
            }
        }
        else {

            switch edge {
            case .top:
                startingY = 0 + statusBarHeight
                
            case .left:
                startingX = 0
            
            case .right:
                startingX = UIScreen.main.bounds.width - frame.size.width
            
            case .bottom:
                startingY = UIScreen.main.bounds.height - frame.size.height
            
            default:
                break
            }
        }

        isHidden = false
        alpha = 1
        
        var distanceToStartingX = startingX - frame.origin.x
        var distanceToStartingY = startingY - frame.origin.y
        
        switch edge {
        case .top, .bottom:
            distanceToStartingX = 0
            
        case .left, .right:
            distanceToStartingY = 0
        
        default:
            break
        }

        transform = transform.translatedBy(x: distanceToStartingX, y: distanceToStartingY)
        
        //Distance to Move
        var distanceToMoveX: CGFloat = 0
        var distanceToMoveY: CGFloat = 0
        
        switch edge {
        case .top:
            distanceToMoveY = frame.size.height + statusBarHeight
            
        case .left:
            distanceToMoveX = frame.size.width
        
        case .right:
            distanceToMoveX = -frame.size.width
        
        case .bottom:
            distanceToMoveY = -frame.size.height
        
        default:
            break
        }
        
        //If sliding out, reverse direction of movement
        if !isSlideIn {
            
            distanceToMoveX = -distanceToMoveX
            distanceToMoveY = -distanceToMoveY
        }
        
        //Animate
        UIView.animate(withDuration: withDuration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animations: {
            
            self.transform = self.transform.translatedBy(x: distanceToMoveX, y: distanceToMoveY)
            
            animation()
            
        }) { (_) in
            
            completion()
        }
    }
}

// MARK: - Gradient layer
extension UIView {
    
    ///Apply Gradient layer on View.
    public func applyGradient(colors: [UIColor]) {
        applyGradient(colors: colors, locations: nil)
    }

    ///Apple Gradient layer on View with specific location.
    public func applyGradient(colors: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
