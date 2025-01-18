//
//  DSBulletListFactory.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/1/2566 BE.
//

import UIKit

public struct DSBulletListFactory {
    
    func build(style: DSBulletStyle) -> [UIView] {
        switch style {
        case .bullet(let viewModels):
            return viewModels.map {
                let view = BulletPrimaryView(frame: .zero)
                view.setup(viewModel: $0)
                return view
            }
        case .number(let viewModels):
            
            return viewModels.enumerated().map {
                let order = $0.offset + 1
                let view = BulletNumberPrimaryView(frame: .zero)
                view.setup(order: order, viewModel: $0.element)
                return view
            }
            
        case .remark(let viewModels):
            return viewModels.map {
                let view = BulletRemarkView(frame: .zero)
                view.setup(viewModel: $0)
                return view
            }
        case .keyHighLight(let viewModels):
            return viewModels.map {
                let view = BulletKeyHighLightView(frame: .zero)
                view.setup(viewModel: $0)
                return view
            }
        }
    }
}
