//
//  LogoTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/5/24.
//

import UIKit

protocol LogoTableViewCellDelegate: AnyObject {
    func logoTableViewCell(
        _ view: UITableViewCell,
        didSelect item: DSBottomSheetLogoListFilterItemLogoDisplayable
    )
}

class LogoTableViewCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var stackView: UIStackView!

    private let itemsPerRow = 4
    weak var delegate: LogoTableViewCellDelegate?

    func configure(
        items: [DSBottomSheetLogoListFilterItemLogoDisplayable],
        delegate: LogoTableViewCellDelegate?
    ) {
        self.delegate = delegate
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        items
            .chunked(into: itemsPerRow)
            .forEach {
                stackView.addArrangedSubview(makeClickableSelectionRowView(for: $0))
            }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    private func makeClickableSelectionRowView(
        for rowItems: [DSBottomSheetLogoListFilterItemLogoDisplayable]
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        rowItems.forEach { item in
            stackView.addArrangedSubview(
                DSClickableSelection(item) { [weak self] _ in
                    guard let self else { return }
                    self.delegate?.logoTableViewCell(self, didSelect: item)
                }
            )
        }
        addEmptyViewIfNeed(to: stackView, currentRowCount: rowItems.count)
        return stackView
    }

    private func addEmptyViewIfNeed(to stackView: UIStackView, currentRowCount count: Int) {
        stride(from: count, to: itemsPerRow, by: 1)
            .map { _ in UIView() }
            .forEach { stackView.addArrangedSubview($0) }
    }
}

fileprivate extension DSClickableSelection {
    convenience init(
        _ item: DSBottomSheetLogoListFilterItemLogoDisplayable,
        action: @escaping (Int) -> Void
    ) {
        self.init()
        setup(
            title: item.label,
            style: .image(
                .url(
                    url: URL(string: item.imageURL),
                    cacheable: true
                )
            ),
            state: item.isSelected ? .selected : .default,
            clickableDidTapped: action
        )
    }
}

fileprivate extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
