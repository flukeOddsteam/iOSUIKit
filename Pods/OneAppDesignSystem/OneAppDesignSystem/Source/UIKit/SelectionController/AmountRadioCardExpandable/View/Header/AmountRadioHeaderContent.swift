//
//  AmountRadioHeaderContent.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/9/2567 BE.
//

import UIKit

protocol AmountRadioHeaderContentDelegate: AnyObject {
    func amountRadioHeaderDidTapped(_ view: AmountRadioHeaderContent)
}

final class AmountRadioHeaderContent: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var radioView: RadioView!
    @IBOutlet weak var titleLabel: UILabel!

    weak var delegate: AmountRadioHeaderContentDelegate?

    var state: DSSelectionRadioState = .default {
        didSet {
            radioView.state = state
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func setup(
        title: String,
        state: DSSelectionRadioState
    ) {
        self.title = title
        self.state = state
    }

    func updateState(
        isEnabled: Bool,
        isSelected: Bool
    ) {
        if isEnabled {
            state = isSelected ? .selected : .default
        } else {
            self.state = .disableUnselected
        }
    }
}

// MARK: - Action
extension AmountRadioHeaderContent {
    @objc func containerViewDidTapped(_ gesture: UIGestureRecognizer) {
        delegate?.amountRadioHeaderDidTapped(self)
    }
}

// MARK: - Private
private extension AmountRadioHeaderContent {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        radioView.state = .default

        titleLabel.setUp(
            font: DSFont.labelList,
            textColor: DSColor.componentLightDefault,
            numberOfLines: .zero
        )

        containerView.backgroundColor = DSColor.componentLightBackground

        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(
                    containerViewDidTapped
                )
            )
        )
    }
}
