//
//  MessageBoxNoticeBulletView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/8/24.
//

import UIKit

class MessageBoxNoticeBulletView: UIView {
    @IBOutlet private weak var bulletView: UIView!
    @IBOutlet private weak var textLabel: UILabel!

    func setUp(text: String, textColor: UIColor, bulletColor: UIColor) {
        bulletView.backgroundColor = bulletColor
        bulletView.set(cornerRadius: 3)
        textLabel.setUp(
            font: DSFont.paragraphSmall,
            textColor: textColor,
            numberOfLines: 0
        )
        textLabel.text = text
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
        let nib = UINib(nibName: "MessageBoxNoticeBulletView", bundle: .dsBundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else {
            fatalError("cannot instantiate MessageBoxNoticeBulletView")
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
