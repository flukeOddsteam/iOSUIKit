//
//  KitchenSinkNavigationView.swift
//  OneApp
//
//  Created by TTB on 11/1/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import UIKit
import OneAppDesignSystem

protocol KitchenSinkNavigationViewDelegate: AnyObject {
    func onBackButtonTapped()
}

extension KitchenSinkNavigationViewDelegate {
    func onBackButtonTapped() { /* optional */ }
}

@IBDesignable
class KitchenSinkNavigationView: UIView {

    weak var delegate: KitchenSinkNavigationViewDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerBackgroundView: UIView!
    @IBOutlet weak var paddingHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var paddingView: UIView!

    private let NOTCH_PADDING_POINT: CGFloat = 8.0

    // MARK: - View Cycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        setupXib()
        titleLabel.font = FontFamily.OneApp.bold.font(size: 20)
        updateUI()
    }

    // MARK: - Properties

    @IBInspectable var title: String {
        get { return titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }

    @IBInspectable var navBarBackgroundColor: UIColor? = .clear {
        didSet {
            backgroundColor = navBarBackgroundColor
            headerBackgroundView.backgroundColor = navBarBackgroundColor
            paddingView.backgroundColor = navBarBackgroundColor
        }
    }
    
    @IBInspectable var backButtonColor: UIColor? = .clear {
        didSet {
            backButton.setImage(
                DSIcons.icon24ChevronLeft.image.maskWithColor(
                    color: backButtonColor ?? .clear
                ), for: .normal
            )
        }
    }
    
    // MARK: - update UI when style and theme changed.

    private func updateUI() {
        navBarBackgroundColor = UIColor.white
        titleLabel.textColor = DSColor.pageLightTextDefault
        backButton.isHidden = false
        backButton.setImage(DSIcons.icon24ChevronLeft.image, for: .normal)
    }

    // MARK: - Event Handler

    @IBAction func onBackPressed(_ sender: Any) {
        delegate?.onBackButtonTapped()
    }
    
    public func setUpDarkTheme() {
        navBarBackgroundColor = DSColor.pageDarkBackground
        titleLabel.textColor = DSColor.pageLightBackground
        backButton.isHidden = false
        backButton.setImage(
            DSIcons.icon24ChevronLeft.image.maskWithColor(
                color: DSColor.pageLightBackground
            ), for: .normal
        )
    }
}
