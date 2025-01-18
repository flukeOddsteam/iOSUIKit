//
//  NibLoadable.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/11/2565 BE.
//

import UIKit

public protocol NibLoadable: AnyObject {
    static var defaultReuseIdentifier: String { get }
    static var nibName: String { get }
}

public extension NibLoadable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
    static var nibName: String {
        return String(describing: type(of: self)).components(separatedBy: ".").first ?? ""
    }
}
