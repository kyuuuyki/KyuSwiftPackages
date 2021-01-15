//
//  +UIStoryboard.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 7/8/2563 BE.
//

import Foundation
import UIKit

// MARK: - Initialization

///Make ViewController initializable from Storyboard using ClassName.
public protocol StoryboardInstantiable {

    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
    static var storyboardIdentifier: String { get }
}

public extension StoryboardInstantiable {

    static var storyboardBundle: Bundle? { return nil }
    static var storyboardIdentifier: String? { return nil }

    ///Initialize ViewController from Storyboard by ClassName.
    static func initFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
