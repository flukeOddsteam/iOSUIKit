//
//  DSInstallmentPlanRadioCardExpandableViewModel.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/9/24.
//

/// View model for DSInstallmentPlanRadioCardExpandable
public struct DSInstallmentPlanRadioCardExpandableViewModel {
    public let model: DSInstallmentPlanRadioCardExpandableModel

    /// Closure for handling pill selection
    ///
    /// Only called when user tapped on the pill. NOT called if the pill selection changed
    /// by calling ``DSInstallmentPlanRadioCardExpandable/update(pillSelectedIndex:)``
    ///
    /// When triggered, the closure will receive whole selected pill item value.
    /// Use ``DSInstallmentPlanRadioCardExpandable/selectedPillIndex`` for getting the index
    public let onSelectPill: (DSInstallmentPlanRadioCardExpandableModel.PillRadio.Item) -> Void

    /// Closure for handling ghost button tapping
    public let ghostButtonAction: () -> Void

    /// Closure for handling radio selection area tapping
    ///
    /// Use ``DSInstallmentPlanRadioCardExpandable/state-swift.property`` to get current state.
    /// Use ``DSInstallmentPlanRadioCardExpandable/expandState-swift.property`` to get current
    /// expand state.
    ///
    /// Radio will not change the state by itself.
    /// Use ``DSInstallmentPlanRadioCardExpandable/update(state:)`` to change the selection state.
    public let onTapRadio: () -> Void

    public init(
        _ model: DSInstallmentPlanRadioCardExpandableModel,
        onSelectPill: @escaping (DSInstallmentPlanRadioCardExpandableModel.PillRadio.Item) -> Void = { _ in },
        ghostButtonAction: @escaping () -> Void = {},
        onTapRadio: @escaping () -> Void
    ) {
        self.model = model
        self.onSelectPill = onSelectPill
        self.ghostButtonAction = ghostButtonAction
        self.onTapRadio = onTapRadio
    }
}

public struct DSInstallmentPlanRadioCardExpandableModel {
    public let title: String
    public let state: DSInstallmentPlanRadioCardExpandable.State
    public let expandState: DSInstallmentPlanRadioCardExpandable.ExpandState
    public let pillRadio: DSInstallmentPlanRadioCardExpandableModel.PillRadio?
    public let remark: DSInstallmentPlanRadioCardExpandableModel.Remark?
    public let ghostButton: DSInstallmentPlanRadioCardExpandableModel.GhostButton?

    public init(
        title: String,
        state: DSInstallmentPlanRadioCardExpandable.State,
        expandState: DSInstallmentPlanRadioCardExpandable.ExpandState,
        pillRadio: DSInstallmentPlanRadioCardExpandableModel.PillRadio? = nil,
        remark: DSInstallmentPlanRadioCardExpandableModel.Remark? = nil,
        ghostButton: DSInstallmentPlanRadioCardExpandableModel.GhostButton? = nil
    ) {
        self.title = title
        self.state = state
        self.expandState = expandState
        self.pillRadio = pillRadio
        self.remark = remark
        self.ghostButton = ghostButton
    }
}

public extension DSInstallmentPlanRadioCardExpandableModel {
    struct PillRadio {
        public let title: String
        public let selectedIndex: Int
        public let items: [DSInstallmentPlanRadioCardExpandableModel.PillRadio.Item]
        
        public init(
            title: String,
            selectedIndex: Int,
            items: [DSInstallmentPlanRadioCardExpandableModel.PillRadio.Item]
        ) {
            self.title = title
            self.selectedIndex = selectedIndex
            self.items = items
        }
    }
    
    /// ListMessage
    ///
    /// When `items` is empty, the component will not display
    struct ListMessage {
        public let title: String?
        public let description: String?
        public let items: [DSInstallmentPlanRadioCardExpandableModel.ListMessage.Item]
        
        public init(
            title: String? = nil,
            description: String? = nil,
            items: [DSInstallmentPlanRadioCardExpandableModel.ListMessage.Item]
        ) {
            self.title = title
            self.description = description
            self.items = items
        }
    }
    
    /// Remark
    ///
    /// When `isShowSymbol` is nil, the component will not display bullet symbol (dot)
    /// if the `bullets` has only one item.
    struct Remark {
        public let title: String
        public let isShowSymbol: Bool
        public let bullets: [String]

        public init(title: String, isShowSymbol: Bool? = nil, bullets: [String]) {
            self.title = title
            self.isShowSymbol = isShowSymbol ?? (bullets.count > 1)
            self.bullets = bullets
        }
    }

    /// Ghost button
    ///
    /// Passing `nil` for `icon` when initialize to hide the button icon.
    /// Default is right icon with chevron right symbol.
    struct GhostButton {
        public let label: String
        public let icon: DSInstallmentPlanRadioCardExpandableModel.GhostButton.Icon?

        public init(
            label: String,
            icon: DSInstallmentPlanRadioCardExpandableModel.GhostButton.Icon? = nil
        ) {
            self.label = label
            self.icon = icon
        }
    }
}

public extension DSInstallmentPlanRadioCardExpandableModel.PillRadio {
    struct Item {
        public let id: String
        public let label: String
        public let selectedPillIndex: Int

        public init(
            id: String,
            label: String,
            selectedPillIndex: Int
        ) {
            self.id = id
            self.label = label
            self.selectedPillIndex = selectedPillIndex
        }
    }
}

public extension DSInstallmentPlanRadioCardExpandableModel.ListMessage {
    struct Item {
        public let label: String
        public let value: String
        public let ratio: CGFloat
        
        public init(label: String, value: String, ratio: CGFloat = 1) {
            self.label = label
            self.value = value
            self.ratio = ratio
        }
    }
}

public extension DSInstallmentPlanRadioCardExpandableModel.GhostButton {
    enum Icon {
        case left(DSIcons)
        case right(DSIcons)
    }
}
