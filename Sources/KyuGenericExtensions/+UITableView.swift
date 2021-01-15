//
//  +UITableView.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 21/10/18.
//

import Foundation
import UIKit

// MARK: - Configure Cells
extension UITableView {
    
    ///Register reusable cells by ClassName.
    public func register<T: UITableViewCell>(_ cell: T.Type) {
        register(UINib(nibName: String(describing: cell), bundle: Bundle(for: cell)), forCellReuseIdentifier: String(describing: cell))
    }
    
    ///Dequeue reusable cells by ClassName.
    public func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cell)) as! T
    }
    
    ///Dequeue reusable cells by ClassName.
    public func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! T
    }
}

// MARK: - Scrolling
extension UITableView {
    
    ///Scroll to last UITableViewCell.
    public func scrollToBottom() {
        
        let section = numberOfSections - 1
        let row = numberOfRows(inSection: section) - 1
        
        let indexPath = IndexPath(row: row, section: section)
        
        DispatchQueue.main.async {
            
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
