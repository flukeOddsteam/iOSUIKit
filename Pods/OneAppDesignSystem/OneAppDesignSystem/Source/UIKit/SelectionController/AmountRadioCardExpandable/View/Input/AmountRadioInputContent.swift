//
//  AmountRadioInputContent.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/9/2567 BE.
//

import UIKit
protocol AmountRadioInputContentDelegate: AnyObject {
    func amountRadioInputGhostButtonDidTapped(_ view: AmountRadioInputContent)
}

final class AmountRadioInputContent: UIView {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textField: DSTextFieldAmount!
    @IBOutlet weak var remarkView: SelectionRemarkView!
    @IBOutlet weak var ghostButton: DSGhostButton!
    @IBOutlet weak var ghostContainerView: UIView!
    @IBOutlet weak var additionalStackView: UIStackView!

    weak var delegate: AmountRadioInputContentDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func setRemark(_ remark: DSAmountRadioCardExpandableViewModel.Remark?) {
        remarkView.isHidden = remark.isNull
        updateAdditionalContainer()
        if let remark {
            remarkView.setup(
                with: SelectionRemarkViewModel(
                    remark
                )
            )
        }
    }

    func setGhostButton(viewModel: DSAmountRadioCardExpandableViewModel.GhostButton?) {
        ghostContainerView.isHidden = viewModel.isNull
        updateAdditionalContainer()
        guard let viewModel else { return }

        switch viewModel {
        case .textOnly(let title):
            ghostButton.smallGhostText(text: title)
        case .iconRight(let title, let icon):
            ghostButton.smallGhostNoPaddingLeftAndRightIconRight(
                text: title,
                icon: icon
            )
        case .iconLeft(let title, let icon):
            ghostButton.smallGhostNoPaddingLeftAndRightIconLeft(
                text: title,
                icon: icon
            )
        }
    }

    func setTextField(viewModel: DSAmountRadioCardExpandableViewModel.TextFieldAmount) {
        textField.setup(
            titleText: viewModel.titleText,
            state: viewModel.state,
            type: viewModel.type,
            errorEmptyAmountText: viewModel.errorEmptyAmountText,
            textFieldValue: viewModel.textFieldValue,
            helperText: viewModel.helperText,
            placeholder: viewModel.placeholder,
            feeText: viewModel.feeText,
            suffixText: viewModel.suffixText,
            maxLength: viewModel.maxLength
        )
    }
}

// MARK: - Action
extension AmountRadioInputContent {
    @IBAction func ghostButtonDidTapped(_ sender: Any) {
        delegate?.amountRadioInputGhostButtonDidTapped(self)
    }
}

// MARK: - Private
private extension AmountRadioInputContent {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        backgroundColor = DSColor.componentSummaryBackground
        ghostButton.smallGhostTextOnlyNoPadding(text: "")
    }

    func updateAdditionalContainer() {
        let isHidden = ghostContainerView.isHidden && remarkView.isHidden
        additionalStackView.isHidden = isHidden
    }
}

// MARK: - Private SelectionRemarkViewModel
private extension SelectionRemarkViewModel {
    init(_ remark: DSAmountRadioCardExpandableViewModel.Remark) {
        self.init(
            title: remark.title,
            isShowBullet: remark.isShowSymbol,
            bulletItems: remark.bullets
        )
    }
}
