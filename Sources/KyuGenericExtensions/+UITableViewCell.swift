//
//  +UITableViewCell.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 21/10/18.
//

import Foundation
import UIKit

// MARK: - TableViewCell's Style
extension UITableViewCell {
    
    ///Hide cell's separator.
    public func hideSeparatorInset() {
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
    }
}

