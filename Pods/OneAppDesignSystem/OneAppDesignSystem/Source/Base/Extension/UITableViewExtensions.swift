//
//  UITableViewExtensions.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/9/2565 BE.
//

import UIKit

public extension UITableView {
    func register<T: NibLoadable>(_: T.Type, bundle: Bundle = .dsBundle) {
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}

    func dequeueReusableCell<T: NibLoadable>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    func registerHeaderFooter<T: NibLoadable>(_ cellClass: T.Type, bundle: Bundle = .dsBundle) {
		let nib = UINib(nibName: T.nibName, bundle: bundle)
		register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
	}
    
    func dequeueReusableHeaderFooterView<T: NibLoadable>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue header footer view with identifier: \(T.defaultReuseIdentifier)")
        }
        return headerFooterView
    }
}
