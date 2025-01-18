//
//  UILabelExtensions.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/3/2566 BE.
//

import UIKit

extension UILabel {
    func lines() -> Int {
        let textSize = CGSize(width: self.frame.size.width, height: CGFloat(Float.infinity))
        let rHeight = lroundf(Float(self.sizeThatFits(textSize).height))
        let charSize = lroundf(Float(self.font.lineHeight))
        let lineCount = rHeight / charSize
        return lineCount
    }
    
    func setLineHeight(height: CGFloat) {
        guard let text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = height
        paragraphStyle.maximumLineHeight = height
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        self.attributedText = attributedString
    }
    
    func setStrikeThrough(text: String, font: UIFont? = nil) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font ?? DSFont.labelInput ?? .systemFont(ofSize: 12),
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: DSColor.componentSummaryDesc
        ]
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: attributes
        )
        
        self.attributedText = attributedString
    }
    
    func setMaskedText(numberOfDots: Int = 7, spacing: CGFloat = 2.0) {
        let maskedText = String(repeating: "•", count: numberOfDots)
        let attributedString = NSMutableAttributedString(string: maskedText)
        attributedString.addAttribute(.kern,
                                    value: spacing,
                                    range: NSRange(location: 0, length: maskedText.count))
        self.attributedText = attributedString
    }

    func resetToNormalText(_ text: String?) {
        self.attributedText = nil
        self.text = text
    }
}
