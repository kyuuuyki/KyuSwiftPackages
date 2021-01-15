//
//  SlidableView.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 19/9/20.
//

import Foundation
import UIKit

public class SlidableView: UIView {
    
    public var viewController: UIViewController!
    
    public var slidableBackgroundView: UIView!
    public var slidableContentView: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSlidableView()
    }

    public convenience init() {
        self.init(frame: CGRect.zero)
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    public func initSlidableView() {
        
        let contentRect = CGRect(x: Defaults.defaults().padding, y: Defaults.defaults().padding, width: frame.size.width - 2 * Defaults.defaults().padding, height: frame.size.height - 2 * Defaults.defaults().padding)
        
        slidableBackgroundView = UIView(frame: contentRect)
        slidableContentView = UIView(frame: contentRect)
        
        //Blur
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = slidableBackgroundView.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation

        blurEffectView.roundCorners(corners: .allCorners, radius: Defaults.defaults().cornerRadius)
        slidableBackgroundView.addSubview(blurEffectView)

        //Shadow
        slidableBackgroundView.roundCorners(corners: .allCorners, radius: Defaults.defaults().cornerRadius)

        slidableBackgroundView.clipsToBounds = false
        slidableBackgroundView.layer.shadowRadius = Defaults.defaults().cornerRadius
        slidableBackgroundView.layer.shadowOpacity = 0.25
        slidableBackgroundView.layer.shadowColor = UIColor.black.cgColor

        slidableBackgroundView.sendSubviewToBack(blurEffectView)

        //View
        slidableContentView.roundCorners(corners: .allCorners, radius: Defaults.defaults().cornerRadius)
        slidableContentView.backgroundColor = .clear
        
        addSubview(slidableBackgroundView)
        addSubview(slidableContentView)
    }
}
