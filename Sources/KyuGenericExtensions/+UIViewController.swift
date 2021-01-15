//
//  +UIViewController.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 24/8/20.
//

import Foundation
import UIKit

// MARK: - Hide keyboard when tapping outside input field
extension UIViewController {
    
    ///Make ViewController automatically end editing when user tapped outside input field.
    public func hideKeyboardWhenTappedAround() {
        
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        
        view.endEditing(true)
    }
}

// MARK: - Alert handling
extension UIViewController {
    
    ///Display AlertView with activity indicator.
    public func displayAlertWithActivityIndicator(loadingText: String? = nil) {
        let alert = UIAlertController(title: nil, message: loadingText ?? "Processing...", preferredStyle: .alert)

        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()
        
        alert.view.addSubview(indicator)
        
        present(alert, animated: true, completion: nil)
    }
    
    ///Display AlertView with default error style.
    public func displayAlertWithErrorStyle(title: String? = nil, message: String? = nil, confirmButtonTitle: String? = nil) {
        let alert = UIAlertController(title: title ?? "Oops!", message: message ?? "Don't worry, it's not your fault.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: confirmButtonTitle ?? "Oh, Okay.", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    ///Dismiss presenting AlertView.
    public func dismissAlertController() {
        dismissAlertController { }
    }
    
    ///Dismiss presenting AlertView.
    public func dismissAlertController(completion: @escaping () -> ()) {
        if let window = UIApplication.shared.delegate?.window, var topController = window?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            if topController.isKind(of: UIAlertController.self) {
                topController.dismiss(animated: true, completion: completion)
            }
        }
    }
}
