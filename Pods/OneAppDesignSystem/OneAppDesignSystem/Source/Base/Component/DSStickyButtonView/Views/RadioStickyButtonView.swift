//
//  RadioStickyButtonView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 31/1/23.
//

import UIKit

final class RadioStickyButtonView: UIView {
    
    @IBOutlet weak var leftRadioView: DSSelectionRadioView!
    @IBOutlet weak var rightRadioView: DSSelectionRadioView!
    
    // callback action
    private var leftRadioAction: ActionHandler?
    private var rightRadioAction: ActionHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(leftRadioText: String,
               leftRadioIsSelected: Bool = false,
               leftRadioAction: ActionHandler? = nil,
               rightRadioText: String,
               rightRadioIsSelected: Bool = false,
               rightRadioAction: ActionHandler? = nil) {
        self.leftRadioAction = leftRadioAction
        self.rightRadioAction = rightRadioAction
        let leftRadioState: DSSelectionRadioState = leftRadioIsSelected == true ? .selected : .default
        let rightRadioState: DSSelectionRadioState = rightRadioIsSelected == true ? .selected : .default
        leftRadioView.setup(tagId: 1,
                            titleText: leftRadioText,
                            state: leftRadioState,
                            action: { _ in
            self.leftRadioAction?()
            self.leftRadioView.state = .selected
            self.rightRadioView.state = .default
        },
                            hasGhostButton: false,
                            ghostButtonLabel: "")
        rightRadioView.setup(tagId: 2,
                             titleText: rightRadioText,
                             state: rightRadioState,
                             action: { _ in
            self.rightRadioAction?()
            self.leftRadioView.state = .default
            self.rightRadioView.state = .selected
        },
                             hasGhostButton: false,
                             ghostButtonLabel: "")
    }
}

// MARK: - Private
private extension RadioStickyButtonView {
    func commonInit() {
        setupXib()
    }
}
