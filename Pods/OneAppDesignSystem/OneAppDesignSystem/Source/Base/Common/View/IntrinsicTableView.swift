//
//  IntrinsicTableView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 30/9/2565 BE.
//
import UIKit

public final class IntrinsicTableView: UITableView {

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    public override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }

    public override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        return contentSize
    }
}
