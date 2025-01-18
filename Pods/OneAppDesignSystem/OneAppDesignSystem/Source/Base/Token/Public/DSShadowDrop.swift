//
//  ShadowDrop.swift
//  OneApp
//
//  Created by TTB on 10/8/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import Foundation
import UIKit

public enum DSShadowDropStyle {
    case left
    case right
    case top
    case bottom
}

private struct DSShadowAppearance {
    var shadowRadius: CGFloat = 0
    var shadowOpacity: Float = 0.3
    var width: CGFloat = 0
    var height: CGFloat = 2
    var color: UIColor = .lightGray
}

public extension UIView {
    
    func dsShadowDrop(
        layerHeight: CGFloat = 2,
        layer2Height: CGFloat = 4,
        layer2ViewTag: Int = 1002,
        isHidden: Bool = false,
        style: DSShadowDropStyle = .bottom
    ) {
        let firstDSShadowAppearance = setupModel(style: style, layerHeight: layerHeight, multiplier: 0.06, isHidden: isHidden)
        self.setShadowDrop(shadowRadius: firstDSShadowAppearance.shadowRadius,
                           shadowOpacity: firstDSShadowAppearance.shadowOpacity,
                           width: firstDSShadowAppearance.width,
                           height: firstDSShadowAppearance.height,
                           color: firstDSShadowAppearance.color)
        if let foundView = self.viewWithTag(layer2ViewTag) {
            foundView.removeFromSuperview()
        }
        
        let shadowDropView2 = UIView()
        shadowDropView2.tag = layer2ViewTag
        shadowDropView2.backgroundColor = self.backgroundColor
        shadowDropView2.layer.cornerRadius = self.layer.cornerRadius
        self.addSubview(shadowDropView2)
        self.sendSubviewToBack(shadowDropView2)
        shadowDropView2.translatesAutoresizingMaskIntoConstraints = false
        shadowDropView2.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        shadowDropView2.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        shadowDropView2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        shadowDropView2.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        shadowDropView2.backgroundColor = self.backgroundColor
        let secondDSShadowAppearance = setupModel(style: style, layerHeight: layer2Height, multiplier: 0.04, isHidden: isHidden)
        shadowDropView2.setShadowDrop(shadowRadius: secondDSShadowAppearance.shadowRadius,
                                      shadowOpacity: secondDSShadowAppearance.shadowOpacity,
                                      width: secondDSShadowAppearance.width,
                                      height: secondDSShadowAppearance.height,
                                      color: secondDSShadowAppearance.color)
    }
    
    private func setupModel(style: DSShadowDropStyle, layerHeight: CGFloat, multiplier: Float, isHidden: Bool) -> DSShadowAppearance {
        let color = UIColor(hex: "#4C5765")
        var overspend: CGFloat = 1
        let opacity: Float = isHidden ? 0.0 : 1.0
        switch style {
        case .left:
            overspend = -1
            return DSShadowAppearance(shadowRadius: 0, shadowOpacity: multiplier * opacity, width: overspend * layerHeight, height: 0, color: color)
        case .right:
            return DSShadowAppearance(shadowRadius: 0, shadowOpacity: multiplier * opacity, width: overspend * layerHeight, height: 0, color: color)
        case .top:
            overspend = -1
            return DSShadowAppearance(shadowRadius: 0, shadowOpacity: multiplier * opacity, width: 0, height: overspend * layerHeight, color: color)
        case .bottom:
            return DSShadowAppearance(shadowRadius: 0, shadowOpacity: multiplier * opacity, width: 0, height: overspend * layerHeight, color: color)
        }
    }
    
    private func setShadowDrop(
        shadowRadius: CGFloat = 0,
        shadowOpacity: Float = 0.3,
        width: CGFloat = 0,
        height: CGFloat = 2,
        color: UIColor = .lightGray
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = shadowRadius
    }
    
}
