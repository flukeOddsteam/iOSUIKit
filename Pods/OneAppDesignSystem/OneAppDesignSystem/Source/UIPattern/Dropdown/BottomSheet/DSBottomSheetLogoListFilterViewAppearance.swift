//
//  DSBottomSheetLogoListFilterViewAppearance.swift
//  OneAppDesignSystem
//
//  Created by TTB on 20/5/24.
//

public struct DSBottomSheetLogoListFilterViewAppearance {

    /// Title display as a navigation title on the bottom sheet
    public let title: String

    /// Search textfield appearance
    public let searchTextField: DSTextFieldSearchViewModel

    /// Appearance for empty item list on the bottom sheet
    ///
    /// The empty appearance uses the DSEmptyAndErrorState
    /// to display the image and description (not display the title)
    public let emptyView: DSBottomSheetLogoListFilterEmptyViewModel

    public init(
        title: String,
        searchTextField: DSTextFieldSearchViewModel,
        emptyView: DSBottomSheetLogoListFilterEmptyViewModel
    ) {
        self.title = title
        self.searchTextField = searchTextField
        self.emptyView = emptyView
    }
}

public struct DSBottomSheetLogoListFilterEmptyViewModel {
    public let style: DSEmptyAndErrorStateStyle
    public let description: String

    public init(style: DSEmptyAndErrorStateStyle, description: String) {
        self.style = style
        self.description = description
    }
}
