//
//  InstallmentPlanRadioCardExpandContentView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/9/24.
//

import UIKit

class InstallmentPlanRadioCardExpandContentView: UIView {
    @IBOutlet private weak var pillGroup: InstallmentPlanExpandContentPillGroup!
    @IBOutlet private weak var listMessageView: InstallmentPlanExpandContentListMessage!
    @IBOutlet private weak var remarkView: SelectionRemarkView!
    @IBOutlet private weak var ghostButton: InstallmentPlanExpandContentGhostButton!

    var selectedPillIndex: Int? {
        pillGroup.selectedPillIndex
    }

    var selectedPill: InstallmentPlanExpandContentPillGroupViewModel.Item? {
        pillGroup.selectedPill
    }

    func setUp(viewModel: InstallmentPlanRadioCardExpandContentViewModel) {
        pillGroup.setUp(viewModel.pillGroup, tagId: 0)
        remarkView.setUp(viewModel.remark)
        ghostButton.setUp(viewModel.ghostButton)
    }
    
    func setUp(listMessage: InstallmentPlanExpandContentListMessageViewModel) {
        listMessageView.setUp(listMessage)
    }

    func update(selectedPillIndex: Int) {
        pillGroup.update(selectedIndex: selectedPillIndex)
    }
    
    // MARK: - Initialize view
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    private func setUp() {
        instantiateView()
    }

    private func instantiateView() {
        let nib = UINib(nibName: "InstallmentPlanRadioCardExpandContentView", bundle: .dsBundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else {
            fatalError("cannot instantiate InstallmentPlanRadioCardExpandContentView")
        }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

fileprivate extension SelectionRemarkView {
    func setUp(_ viewModel: SelectionRemarkViewModel?) {
        guard let viewModel else {
            isHidden = true
            return
        }
        setup(with: viewModel)
        isHidden = false
    }
}

struct InstallmentPlanRadioCardExpandContentViewModel {
    let pillGroup: InstallmentPlanExpandContentPillGroupViewModel?
    let remark: SelectionRemarkViewModel?
    let ghostButton: InstallmentPlanExpandContentGhostButtonViewModel?
}
