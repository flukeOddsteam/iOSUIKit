//
//  ContentListHorizontalScreen.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/11/2565 BE.
//

import UIKit

private enum Constants {
    static let minimumScreenWidth: CGFloat = 320
}

enum ContentListHorizontalScreen {
    case min
    case max
    
    init(screenWidth: CGFloat) {
        let isMinWidth = screenWidth <= Constants.minimumScreenWidth
        self = isMinWidth ? .min : .max
    }
    
    var contentImageViewWidth: CGFloat {
        switch self {
        case .min:
            return 104
        case .max:
            return 124
        }
    }
    
    var contentImageViewHeight: CGFloat {
        switch self {
        case .min:
            return 104
        case .max:
            return 124
        }
    }
}
