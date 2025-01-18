//
//  DSRadioExpandedViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/9/2567 BE.
//

import Foundation

/// Struct DSRadioExpandedViewModel
public struct DSRadioExpandedViewModel {
    /// Determines if the radio button is currently selected.
    public var isSelected: Bool
    /// Determines if the radio button is disabled.
    public var isEnabled: Bool
    /// The title to be displayed.
    public var title: String
    /// Array of list messages to be displayed.
    public var listMessage: [DSRadioListMessageViewModel]?
    /// Optional configuration for a ghost button within the component.
    public var ghostButton: DSGhostRadioExpandedViewModel?
    /// Optional configuration for a bullet note or remark.
    public var bulletNote: SelectionRemarkViewModel?
    /// The image to be displayed, either as a UIImage or a URL.
    public var iconImage: DSRadioExpandedImageType
    
    public init(
        title: String,
        isSelected: Bool,
        isEnabled: Bool,
        listMessage: [DSRadioListMessageViewModel]? = nil,
        ghostButton: DSGhostRadioExpandedViewModel? = nil,
        bulletNote: SelectionRemarkViewModel? = nil,
        iconImage: DSRadioExpandedImageType
    ) {
        self.title = title
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.listMessage = listMessage
        self.ghostButton = ghostButton
        self.bulletNote = bulletNote
        self.iconImage = iconImage
    }
}
