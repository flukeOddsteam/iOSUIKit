//
//  DSMessageBoxNotice.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/8/24.
//

import UIKit

public enum DSMessageBoxNoticeStatus {
    case informative
    case warning
    case error
}

public class DSMessageBoxNotice: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bulletStackView: UIStackView!

    public func setUp(
        _ status: DSMessageBoxNoticeStatus,
        icon: UIImage = DSIcons.icon24OutlinePlaceholder.image,
        title: String? = nil,
        description: String? = nil,
        bullets: [String]? = nil
    ) {
        iconImageView.setUp(icon, tintColor: status.iconTintColor)
        titleLabel.set(text: title)
        descriptionLabel.set(text: description)
        bulletStackView.set(items: bullets, color: status.descriptionTextColor)

        setUpAppearance(status)
    }

    private func setUpAppearance(_ status: DSMessageBoxNoticeStatus) {
        contentView.backgroundColor = status.backgroundColor
        titleLabel.setUp(
            font: DSFont.h3,
            textColor: status.titleTextColor,
            numberOfLines: 0
        )
        descriptionLabel.setUp(
            font: DSFont.paragraphSmall,
            textColor: status.descriptionTextColor,
            numberOfLines: 0
        )

        iconImageView.tintAdjustmentMode = .normal
    }

    // MARK: - Initialize view
    public override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        instantiateView()
    }

    private func instantiateView() {
        let nib = UINib(nibName: "DSMessageBoxNotice", bundle: .dsBundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else {
            fatalError("cannot instantiate DSMessageBoxNotice")
        }
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        contentView.set(cornerRadius: 12)
    }
}

fileprivate extension UIImageView {
    func setUp(_ image: UIImage, tintColor: UIColor) {
        self.image = image.withRenderingMode(.alwaysTemplate)
        self.tintColor = tintColor
    }
}

fileprivate extension UILabel {
    func set(text: String?) {
        guard let text, text.isNotEmpty else {
            isHidden = true
            return
        }
        self.text = text
        isHidden = false
    }
}

fileprivate extension UIStackView {
    func set(items: [String]?, color: UIColor) {
        guard let items else {
            isHidden = true
            return
        }
        isHidden = false
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        items
            .map { MessageBoxNoticeBulletView($0, color) }
            .forEach { addArrangedSubview($0) }
    }
}

fileprivate extension MessageBoxNoticeBulletView {
    convenience init(_ text: String, _ color: UIColor) {
        self.init()
        setUp(text: text, textColor: color, bulletColor: color)
    }
}

fileprivate extension DSMessageBoxNoticeStatus {
    var backgroundColor: UIColor {
        switch self {
        case .informative: return DSColor.componentinformativeBackground
        case .warning: return DSColor.componentWarningBackground
        case .error: return DSColor.componentErrorBackground
        }
    }

    var iconTintColor: UIColor {
        switch self {
        case .informative: return DSColor.componentinformativeOutlineIcon
        case .warning: return DSColor.componentWarningOutlineIcon
        case .error: return DSColor.componentErrorOutlineIcon
        }
    }

    var titleTextColor: UIColor {
        switch self {
        case .informative: return DSColor.componentinformativeDefault
        case .warning: return DSColor.componentWarningDefault
        case .error: return DSColor.componentErrorDefault
        }
    }

    var descriptionTextColor: UIColor {
        switch self {
        case .informative: return DSColor.componentinformativeDesc
        case .warning: return DSColor.componentWarningDesc
        case .error: return DSColor.componentErrorDesc
        }
    }
}
