//
//  DSWaitingScreen.swift
//  OneAppDesignSystem
//
//  Created by TTB on 13/2/2567 BE.
//

import UIKit
import OneAppDesignSystem

private enum Constants {
    static let loadingSize = CGSize(width: 24, height: 24)
}

open class DSWaitingScreenViewController: UIViewController {

    lazy var mediaView: WaitingScreenMediaView = {
        let view = WaitingScreenMediaView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var loadingView: DSLoading = {
        let view = DSLoading(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubviews(titleLabel, descriptionContainerStackView)
        return stackView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = DSFont.h2
        label.numberOfLines = .zero
        label.textColor = DSColor.componentLightDefault
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = DSFont.labelList
        label.numberOfLines = .zero
        label.textColor = DSColor.pageLightDesc
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descriptionContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubviews(loadingView, descriptionLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var descriptionContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(descriptionContentView)
        return stackView
    }()

    lazy var ghostButton: DSGhostButton = {
        let button = DSGhostButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    public var viewModel: DSWaitingScreenViewModel?
    public var accessibility: DSWaitingScreenAccessibility?

    public weak var delegate: DSWaitingScreenDelegate?

    open override func viewDidLoad() {
        super.viewDidLoad()
        initiateSubView()
        bindingData()
        setupAccessibility()
    }

    public func setup(
        viewModel: DSWaitingScreenViewModel,
        accessibility: DSWaitingScreenAccessibility?
    ) {
        self.viewModel = viewModel
        self.accessibility = accessibility
    }

    public func reloadData() {
        bindingData()
    }
}

// MARK: - Action
extension DSWaitingScreenViewController {
    @objc func ghostButtonDidTapped(_ sender: Any) {
        performDisplayBottomSheet()
    }
}

// MARK: - DSWaitingScreenInterface
extension DSWaitingScreenViewController: DSWaitingScreenInterface {
    public func close() {
        dismiss(animated: true) { [weak self] in
            self?.delegate?.waitingScreenDidClosed()
        }
    }
}

// MARK: - Private
private extension DSWaitingScreenViewController {

    func initiateSubView() {
        view.backgroundColor = .white
        view.addSubviews(
            mediaView,
            contentStackView,
            ghostButton
        )

        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([

            mediaView.heightAnchor.constraint(equalToConstant: 240),
            mediaView.widthAnchor.constraint(equalToConstant: 240),
            mediaView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            mediaView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

            contentStackView.topAnchor.constraint(equalTo: mediaView.bottomAnchor, constant: 16),
            contentStackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            contentStackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16),

            loadingView.topAnchor.constraint(equalTo: descriptionContentView.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: descriptionContentView.leadingAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 24),
            loadingView.widthAnchor.constraint(equalToConstant: 24),

            descriptionLabel.leadingAnchor.constraint(equalTo: loadingView.trailingAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContentView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContentView.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContentView.bottomAnchor),

            ghostButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16),
            ghostButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16),
            ghostButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24)
        ])

        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        ghostButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        ghostButton.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }

    func bindingData() {

        loadingView.updateSize(size: Constants.loadingSize)
        loadingView.showLoading()

        if let viewModel {
            ghostButton.largeGhostText(text: viewModel.screenPhrase.ghostButtonTitle)
            ghostButton.addTarget(
                self,
                action: #selector(ghostButtonDidTapped),
                for: .touchUpInside
            )

            mediaView.mediaType = viewModel.mediaType

            titleLabel.text = viewModel.screenPhrase.title
            titleLabel.isHidden = viewModel.screenPhrase.title.isEmpty

            descriptionLabel.text = viewModel.screenPhrase.subtitle
            descriptionContainerStackView.isHidden = viewModel.screenPhrase.subtitle.isEmpty
        }
    }

    func setupAccessibility() {
        guard let accessibility else {
            return
        }

        titleLabel.accessibilityIdentifier = accessibility.titleId
        descriptionLabel.accessibilityIdentifier = accessibility.descriptionId

        ghostButton.setAccessibilityIdentifier(
            id: accessibility.ghostButtonId,
            titleLabelId: accessibility.ghostButtonLabelId
        )
    }

    func performDisplayBottomSheet() {
        guard let viewModel else {
            return
        }

        let style = BottomSheetMessageStyle.confirm(
            title: viewModel.bottomSheetPhrase.title,
            description: viewModel.bottomSheetPhrase.description,
            buttonTextPrimary: viewModel.bottomSheetPhrase.primaryButtonTitle,
            buttonTextPrimaryAction: ({
                self.delegate?.waitingScreenBottomSheetPrimaryButtonDidTapped()
            }),
            buttonTextGhost: viewModel.bottomSheetPhrase.ghostButtonTitle,
            buttonTextGhostAction: ({
                self.delegate?.waitingScreenBottomSheetGhostButtonDidTapped()
            })
        )

        var bottomSheetAccessibility: DSBottomSheetAccessibilityIdentifier?
        if let accessibility {
            bottomSheetAccessibility = DSBottomSheetAccessibilityIdentifier.bottomSheetGeneralConfirm(
                titleId: accessibility.bottomSheetAccessibility?.titleId ?? "",
                descriptionId: accessibility.bottomSheetAccessibility?.descriptionId ?? "",
                buttonPrimaryId: accessibility.bottomSheetAccessibility?.primaryButtonId ?? "",
                buttonPrimaryLabelId: accessibility.bottomSheetAccessibility?.primaryButtonLabelId ?? "",
                buttonGhostId: accessibility.bottomSheetAccessibility?.ghostButtonId ?? "",
                buttonGhostLabelId: accessibility.bottomSheetAccessibility?.ghostButtonLabelId ?? "",
                closeButtonId: accessibility.bottomSheetAccessibility?.closeButtonId ?? ""
            )
        }

        DSBottomSheetWrapper.presentBottomSheetGeneral(
            viewController: self,
            style: style,
            delegate: nil,
            tagId: .zero,
            params: nil,
            accessibilityIdentifier: bottomSheetAccessibility
        )
    }

}
