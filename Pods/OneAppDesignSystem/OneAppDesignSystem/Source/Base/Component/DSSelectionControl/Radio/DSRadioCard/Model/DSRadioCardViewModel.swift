//
//  DSRadioCardViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/12/2566 BE.
//

import Foundation

/// For setup DSRadioCardViewModel
///
/// Parameter for setup DSRadioCardView
/// - Parameter tagId: tag ID of DSRadioCardView.
/// - Parameter label: text to display as label of DSRadioCardView.
/// - Parameter value: text to display as value of DSRadioCardView.
/// - Parameter isShowExpandList: Handle display expandview.
/// - Parameter labelDesc: text to display as labelDesc of DSRadioCardView.
/// - Parameter ghostButton: optional ghost button of DSRadioCardView.
/// - Parameter pill: DSCollectionPillViewModel to initial pill in card of DSRadioCardView.
/// - Parameter expandViewModel: expand info card of DSRadioCardView.
/// - Parameter enableExpanded: show / not show  the seeMore button
public struct DSRadioCardViewModel {
    public var tagId: Int
    public var label: String
    public var value: String?
    public var isShowExpandList: Bool = false
    public var labelDesc: String?
    public var ghostButton: DSRadioCardButtonViewModel?
    public var pill: DSCollectionPillViewModel?
    public var expandViewModel: DSRadioCardExpandViewModel?
    public var enableExpanded: Bool = true

    public init(
        tagId: Int,
        label: String,
        value: String?,
        isShowExpandList: Bool = false,
        labelDesc: String? = nil,
        expandViewModel: DSRadioCardExpandViewModel? = nil,
        ghostButton: DSRadioCardButtonViewModel? = nil,
        contentList: [DSMessageListModel] = [],
        pill: DSCollectionPillViewModel? = nil,
        enableExpanded: Bool = true
    ) {
        self.tagId = tagId
        self.label = label
        self.value = value
        self.isShowExpandList = isShowExpandList
        self.labelDesc = labelDesc
        self.ghostButton = ghostButton
        self.expandViewModel = expandViewModel
        self.pill = pill
        self.enableExpanded = enableExpanded
    }
}

public typealias DSSelectionRadioCardAction = ((_ currentState: DSSelectionRadioState) -> Void)
