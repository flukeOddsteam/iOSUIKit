//
//  DSBaseBottomSheetViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/11/2566 BE.
//

import UIKit

private enum Constants {
    static var emptyImage = UIImage()
}

/**
    Base component for DSBaseBottomSheetViewController (Using for UIKit only)

    **Usage Example:**
    1. Create UIViewController on UIKit folder
    2. Extended class`DSBaseBottomSheetViewController`
    3. Create 2 uiview in storyboard. and binding to contentView and headerView

 */
open class DSBaseBottomSheetViewController: UIViewController {

    @IBOutlet public weak var contentView: UIView!
    @IBOutlet public weak var headerView: UIView!

    public lazy var rightIcon: DSClickableIconBadge = {
        let button = DSClickableIconBadge(frame: .zero)
        button.setup(style: .normal, image: DSIcons.icon24Close.image)
        button.addTarget(self, action: #selector(rightIconDidTapped), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setSizeConstraint(width: 40, height: 40)
        return button
    }()

    public lazy var leftIcon: DSClickableIconBadge = {
        let button = DSClickableIconBadge(frame: .zero)
        button.setup(style: .normal, image: DSIcons.icon24OutlineChevronLeft.image)
        button.addTarget(self, action: #selector(leftIconDidTapped), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = DSFont.h2
        label.textColor = DSColor.componentLightDefault
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            leftSpacingView,
            leftIcon,
            titleLabel,
            rightIcon,
            rightSpacingView
        ])
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = .zero
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    public lazy var leftSpacingView: UIView = {
        let view = UIView()
        view.setSizeConstraint(width: 40, height: 40)
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()

    public lazy var rightSpacingView: UIView = {
        let view = UIView()
        view.setSizeConstraint(width: 40, height: 40)
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.panModalSetNeedsLayoutUpdate()
        }
    }

    public func setHeaderShadow(isHidden: Bool) {
        headerView.dsShadowDrop(isHidden: isHidden)
    }

    public func setLeftIcon(image: UIImage? = nil,
                            isHidden: Bool,
                            isSpacing: Bool = false) {
        leftIcon.setIconImage(image ?? Constants.emptyImage)
        leftIcon.isHidden = isHidden
        leftSpacingView.isHidden = isSpacing ? !isHidden : true
    }

    public func setRightIcon(image: UIImage? = nil,
                             isHidden: Bool,
                             isSpacing: Bool = false) {
        rightIcon.setIconImage(image ?? Constants.emptyImage)
        rightIcon.isHidden = isHidden
        rightSpacingView.isHidden = isSpacing ? !isHidden : true

    }

    public func setTitle(title: String?) {
        titleLabel.text = title
        titleLabel.isHidden = title.isNilOrEmpty
    }
    
    public func setFontTitle(font: UIFont?) {
        titleLabel.font = font
    }

    open func rightIconDidPerformAction() { }

    open func leftIconDidPerformAction() { }
    
    open func panModalWillDismiss() { }
}

// MARK: - Action
extension DSBaseBottomSheetViewController {
    @objc private func leftIconDidTapped() {
        leftIconDidPerformAction()
    }

    @objc private func rightIconDidTapped() {
        rightIconDidPerformAction()
    }
}

// MARK: - PanModalPresentable
extension DSBaseBottomSheetViewController: PanModalPresentable {

    public var cornerRadius: CGFloat {
        return DSRadius.radius24px.rawValue
    }

    var showDragIndicator: Bool {
        return false
    }

    var isUserInteractionEnabled: Bool {
        return true
    }

    var panScrollable: UIScrollView? {
        return nil
    }

    var anchorModalToLongForm: Bool {
        return true
    }

    var panModalBackgroundColor: UIColor {
        return DSColor.otherBackgroundOverlayScreen
    }

    var topOffset: CGFloat {
        return UIApplication.getStatusBarFrame().height + 16
    }

    var shortFormHeight: PanModalHeight {
        return .intrinsicHeight
    }

    var longFormHeight: PanModalHeight {
        return .intrinsicHeight
    }
}

// MARK: - Private
private extension DSBaseBottomSheetViewController {
    func setupUI() {
        headerView.addSubview(stackView)
        headerView.backgroundColor = DSColor.componentLightBackground
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 40),
            stackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])

        view.layoutIfNeeded()
    }
}

private extension UIView {
    func setSizeConstraint(width: CGFloat, height: CGFloat) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: width),
            self.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
