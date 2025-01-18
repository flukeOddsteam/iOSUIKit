//
//  ContentListBasicViewInterface.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import UIKit

protocol ContentListBasicViewInterface {
    var view: UIView { get }
    
    func setup(viewModel: DSContentListViewModel)
}
