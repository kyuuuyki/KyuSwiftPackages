//
//  +UICollectionView.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 7/8/2563 BE.
//

import Foundation
import UIKit

// MARK: - Configure Cells
extension UICollectionView {
    
    ///Register reusable cells by ClassName.
    public func register<T: UICollectionViewCell>(_ cell: T.Type) {
        register(UINib(nibName: String(describing: cell), bundle: Bundle(for: cell)), forCellWithReuseIdentifier: String(describing: cell))
    }
    
    ///Dequeue reusable cells by ClassName.
    public func dequeueReusableCell<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as! T
    }
}
