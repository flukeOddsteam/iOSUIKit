//
//  ToastView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 25/11/2565 BE.
//

import UIKit

protocol ToastView {
    var view: UIView { get }
    var isDisplaying: Bool { get set }
}
