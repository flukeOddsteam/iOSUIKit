//
//  DSBulletViewModels.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/1/2566 BE.
//

import UIKit

/// For setup DSBulletViewModel
///
/// Parameter for setup DSBulletViewModel
/// - Parameter title: text label of the DSBullet is mandatory, which cannot be nil.
/// - Parameter secondary: List of DSBulletSecondaryViewModel. If the list is empty, there will be no secondary item.
public struct DSBulletViewModel {
    let title: String
    let titleColor: BulletPrimaryTextColor
    let secondary: [DSBulletSecondaryViewModel]
    let secondarySpacing: CGFloat
    let secondaryPadding: CGFloat
    
    public init(title: String,
                titleColor: BulletPrimaryTextColor = .nevy,
                secondary: [DSBulletSecondaryViewModel],
                secondarySpacing: CGFloat = 8,
                secondaryPadding: CGFloat = 16) {
        self.title = title
        self.titleColor = titleColor
        self.secondary = secondary
        self.secondarySpacing = secondarySpacing
        self.secondaryPadding = secondaryPadding
    }
}

/// For setup DSBulletViewModel
///
/// Parameter for setup DSBulletViewModel
/// - Parameter title: text label of the DSBullet is mandatory, which cannot be nil.
/// - Parameter isShowBullet: a flag to set bullet view display. When the flag is set to true, the bullet will be shown. When the flag is set to false, the bullet view will be hidden.
public struct DSBulletSecondaryViewModel {
    let title: String
    let isShowBullet: Bool
    
    public init(title: String, isShowBullet: Bool) {
        self.title = title
        self.isShowBullet = isShowBullet
    }
}

/// For setup DSBulletNumberViewModel
///
/// Parameter for setup DSBulletNumberViewModel
/// - Parameter title: text label of the DSBullet is mandatory, which cannot be nil.
/// - Parameter secondary: List of DSBulletNumberSecondaryViewModel. If the list is empty, there will be no secondary item.
public struct DSBulletNumberViewModel {
    let title: String
    let titleColor: BulletPrimaryTextColor
    let secondary: [DSBulletNumberSecondaryViewModel]
    let secondarySpacing: CGFloat
    let secondaryPadding: CGFloat

    public init(title: String,
                titleColor: BulletPrimaryTextColor = .nevy,
                secondary: [DSBulletNumberSecondaryViewModel],
                secondarySpacing: CGFloat = 8,
                secondaryPadding: CGFloat = 16) {
        self.title = title
        self.titleColor = titleColor
        self.secondary = secondary
        self.secondarySpacing = secondarySpacing
        self.secondaryPadding = secondaryPadding
    }
}

/// Enum DSBulletNumberSecondary style.
public enum DSBulletNumberSecondaryStyle {
    /// Each item starts with a circle bullet view.
    case bullet
    /// Each item starts with a running number.
    case number
    /// Each item starts with title. There is no any bullet view or number in front of the title.
    case description
}

/// For setup DSBulletNumberSecondaryViewModel
///
/// Parameter for setup DSBulletNumberSecondaryViewModel
/// - Parameter title: text label of the DSBullet is mandatory, which cannot be nil.
/// - Parameter style: DSBulletNumberSecondaryStyle of a secondary.
public struct DSBulletNumberSecondaryViewModel {
    let title: String
    let style: DSBulletNumberSecondaryStyle

    public init(title: String, style: DSBulletNumberSecondaryStyle) {
        self.title = title
        self.style = style
    }
}

/// For setup DSBulletRemarkViewModel
///
/// Parameter for setup DSBulletRemarkViewModel
/// - Parameter title: text label of the DSBullet is mandatory, which cannot be nil.
public struct DSBulletRemarkViewModel {
    let title: String
    let titleColor: BulletRemarkTextColor
    
    public init(title: String, titleColor: BulletRemarkTextColor = .grey) {
        self.title = title
        self.titleColor = titleColor
    }
}

/// For setup DSBulletKeyHighLightViewModel
///
/// Parameter for setup DSBulletKeyHighLightViewModel
/// - Parameter title: text label of the DSBullet is mandatory, which cannot be nil.
public struct DSBulletKeyHighLightViewModel {
    let title: String
    let titleColor: BulletPrimaryTextColor
    
    public init(title: String, titleColor: BulletPrimaryTextColor = .nevy) {
        self.title = title
        self.titleColor = titleColor
    }
}

public enum BulletPrimaryTextColor {
    case nevy
    case grey
    case white
    
    var textColor: UIColor {
        switch self {
        case .nevy:
            return DSColor.componentLightDefault
        case .grey:
            return DSColor.componentLightDesc
        case .white:
            return .white
        }
    }
}

public enum BulletRemarkTextColor {
    case grey
    case white
    
    var textColor: UIColor {
        switch self {
        case .grey:
            return DSColor.componentLightDesc
        case .white:
            return .white
        }
    }
}
