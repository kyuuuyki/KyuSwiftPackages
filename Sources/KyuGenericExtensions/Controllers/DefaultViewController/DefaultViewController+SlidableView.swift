//
//  DefaultViewController+SlidableView.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 19/9/20.
//

import Foundation
import UIKit

extension DefaultViewController {
    
    public func displaySlidableView(in frame: CGRect, viewController: UIViewController, completion: @escaping () -> Void = {}) {
        
        var existedSlidableView: SlidableView?
        
        //Shrink Existing SlidableViews
        for subview in view.subviews {
            if let slidableView = subview as? SlidableView {
                if slidableView.viewController == viewController {
                    existedSlidableView = slidableView
                }
                else {
                    UIView.animate(withDuration: 0.35, animations: {
                        slidableView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    })
                }
            }
        }
        
        //If already shown, do nothing
        if existedSlidableView != nil {
            return
        }
        
        //Display Target SlidableView
        let slidableView = SlidableView(frame: frame)
        slidableView.viewController = viewController
        
        addChild(viewController)
        viewController.view.frame = CGRect(origin: .zero, size: slidableView.slidableContentView.frame.size)
        slidableView.slidableContentView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        view.addSubview(slidableView)
        slidableView.slideIn(from: .left, withDuration: 0.35, completion:  {
            completion()
        })
    }
    
    public func dismissSlidableView(viewController: UIViewController, completion: @escaping () -> Void = {}) {
        
        //Dismiss Target SlidableView
        for subview in view.subviews {
            if let slidableView = subview as? SlidableView {
                
                if slidableView.viewController == viewController {
                    slidableView.slideOut(to: .left, withDuration: 0.35, completion:  {
                        
                        viewController.willMove(toParent: nil)
                        viewController.view.removeFromSuperview()
                        viewController.removeFromParent()
                        
                        subview.removeFromSuperview()
                        
                        completion()
                    })
                }
                else {
                    UIView.animate(withDuration: 0.35, animations: {
                        slidableView.transform = CGAffineTransform.identity
                    })
                }
            }
        }
    }
}
