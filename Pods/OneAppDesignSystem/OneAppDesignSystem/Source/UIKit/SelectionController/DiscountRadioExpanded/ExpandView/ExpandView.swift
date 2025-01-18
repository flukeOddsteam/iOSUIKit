//
//  ExpandView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 2/9/2567 BE.
//

import UIKit

protocol ExpandViewDelegate: AnyObject {
    func expandViewGhostButtonDidTapped(_ view: ExpandView)
}

final class ExpandView: UIView {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: IntrinsicTableView!
    @IBOutlet weak var ghostButton: DSGhostButton!
    @IBOutlet weak var ghostButtonContainerView: UIView!
    @IBOutlet weak var bulletNotesView: SelectionRemarkView!
    @IBOutlet weak var bulletNoteContainerView: UIView!
    
    weak var delegate: ExpandViewDelegate?
    
    private var listMessageViewModel: [DSRadioListMessageViewModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(viewModel: DSRadioExpandedViewModel) {
        tableView.isHidden = viewModel.listMessage?.isEmpty ?? true
        listMessageViewModel = viewModel.listMessage ?? []
        tableView.reloadData()
        
        ghostButtonContainerView.isHidden = viewModel.ghostButton.isNull
        if viewModel.ghostButton?.leftIcon.isNotNull ?? false {
            self.ghostButton.smallGhostNoPaddingLeftAndRightIconLeft(
                text: viewModel.ghostButton?.title ?? "",
                icon: viewModel.ghostButton?.leftIcon?.image ?? DSIcons.icon24OutlinePlaceholder.image
            )
        } else if viewModel.ghostButton?.rightIcon.isNotNull ?? false {
            self.ghostButton.smallGhostNoPaddingLeftAndRightIconRight(
                text: viewModel.ghostButton?.title ?? "",
                icon: viewModel.ghostButton?.rightIcon?.image ?? DSIcons.icon24OutlinePlaceholder.image
            )
        } else {
            self.ghostButton.smallGhostTextOnlyNoPadding(text: viewModel.ghostButton?.title ?? "")
        }
        
        bulletNoteContainerView.isHidden = viewModel.bulletNote.isNull
        if let bulletNote = viewModel.bulletNote {
            bulletNotesView.setup(with: bulletNote)
        }
    }
}

// MARK: - Action
extension ExpandView {
    @IBAction func ghostButtonDidTapped(_ sender: Any) {
        delegate?.expandViewGhostButtonDidTapped(self)
    }
}

// MARK: - UITableViewDataSource
extension ExpandView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listMessageViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listMessageViewModel[indexPath.row]
        
        switch item.type {
        case .small:
            let cell: DSMessageContentListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setup(messageModel: DSMessageListModel(item.viewModel))
            cell.listMessageView.ratio = item.viewModel.ratio
            return cell
        case .accent:
            let cell: RadioListMessageAccentCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(viewModel: item.viewModel)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ExpandView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Private
private extension ExpandView {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        tableView.register(DSMessageContentListCell.self)
        tableView.register(RadioListMessageAccentCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        stackView.layoutIfNeeded()
        layoutIfNeeded()
    }
}

// MARK: - DSMessageListModel Mapping
fileprivate extension DSMessageListModel {
    init(_ viewModel: DSRadioListMessageViewModel.ListItemViewModel) {
        self.label = viewModel.title
        self.value = viewModel.value
    }
}
