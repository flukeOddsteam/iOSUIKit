//
//  DSListMessageViewModels.swift
//  OneAppDesignSystem
//
//  Created by TTB on 10/2/23.
//

import UIKit

/// Parameter | Type + Information
/// --- | ---
/// `style` | `DSListMessageStyle` Style of list message.
/// `label` | `String`  Label of list message never be nil.
/// `value` | `String` Value of list message never be nil.
/// `iconPosition` | `DSListMessageIconPosition?` Position of icon in list message if nill will hide the icon.
/// `error` | `String?` Error message of list message. support for only large type. (optional).
/// `valueError` | `String?` Error message related to the value (optional).
/// `labelStyle` | `DSListMessageLabelStyle` Style for the label text.
/// `valueStyle` | `DSListMessageValueStyle` Style font for the value text.
/// `valueColor` | `DSListMessageValueColor` Style color for the value text.
public struct DSListMessageViewModel {
    let style: DSListMessageStyle
    let label: String
    let value: String
    var iconPosition: DSListMessageIconPosition?
    let error: String?
    let valueError: String?
    let labelStyle: DSListMessageLabelStyle
    let valueStyle: DSListMessageValueStyle?
    let valueColor: DSListMessageValueColor?

    public init(
        style: DSListMessageStyle,
        label: String,
        value: String,
        iconPosition: DSListMessageIconPosition? = nil,
        error: String? = nil,
        valueError: String? = nil,
        labelStyle: DSListMessageLabelStyle = .regular,
        valueStyle: DSListMessageValueStyle? = nil,
        valueColor: DSListMessageValueColor? = nil
    ) {
        self.style = style
        self.label = label
        self.value = value
        self.iconPosition = iconPosition
        self.error = error
        self.valueError = valueError
        self.labelStyle = labelStyle
        self.valueStyle = valueStyle
        self.valueColor = valueColor
    }
}

/// Parameter | Type + Information
/// --- | ---
/// `canExpand` | `Bool` Indicate the list message can be expanded or not.
/// `label` | `String`  Label of list message never be nil.
/// `value` | `String` Value of list message never be nil.
/// `isExpand` | `Bool` Default is false for visibel of expan list.
/// `labelDesc` | `String`  LabelDesc of list message can be nil.
/// `valueDesc` | `String`  LabelDesc of list message can be nil.
/// `contentList` | `[DSMessageListModel]?`  Datasource of expanable list.
/// `leftButton` | `DSButtonViewModel?`  LeftButton of expanable list require action and title.
/// `rightButton` | `DSButtonViewModel?`  RightButton of expanable list require action and title.
/// `pill` | `DSCollectionPillViewModel?` Pill viewmodel.

public struct DSListMessageExpandableViewModel {
    var canExpand: Bool
    var label: String
    var value: String
    var isExpand: Bool = false
    var labelDesc: String?
    var valueDesc: String?
    var contentList: [DSMessageListModel] = []
    var leftButton: DSButtonViewModel?
    var rightButton: DSButtonViewModel?
    var pill: DSCollectionPillViewModel?
    var ratio: CGFloat
    
    public init(canExpand: Bool, label: String, value: String, isExpand: Bool = false, labelDesc: String? = nil, valueDesc: String? = nil, contentList: [DSMessageListModel] = [], leftButton: DSButtonViewModel? = nil, rightButton: DSButtonViewModel? = nil, pill: DSCollectionPillViewModel? = nil, ratio: CGFloat = 1) {
        self.canExpand = canExpand
        self.label = label
        self.value = value
        self.isExpand = isExpand
        self.labelDesc = labelDesc
        self.valueDesc = valueDesc
        self.contentList = contentList
        self.leftButton = leftButton
        self.rightButton = rightButton
        self.pill = pill
        self.ratio = ratio
    }
}

public struct DSCollectionPillViewModel {
    var status: DSCollectionPillStatus?
    var tag: [String]?
    
    public init(status: DSCollectionPillStatus? = nil, tag: [String]? = nil) {
        self.status = status
        self.tag = tag
    }
}

public struct DSMessageListModel {
    var label: String?
    var value: String?
    
    public init(label: String? = nil, value: String? = nil) {
        self.label = label
        self.value = value
    }
}

public struct DSButtonViewModel {
    public var title: String
    public var icon: DSIcons?
    public var onClick: () -> Void = {}
    
    public init(title: String, icon: DSIcons? = nil, onClick: @escaping () -> Void = {}) {
        self.title = title
        self.icon = icon
        self.onClick = onClick
    }
}
