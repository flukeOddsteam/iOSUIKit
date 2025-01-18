//
//  DSMessageContentList.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/9/2565 BE.
//

import UIKit

class DSMessageContentListView: UIView {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: IntrinsicTableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bottomTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var rightButtonView: DSGhostButton!
    @IBOutlet weak var leftButtonView: DSGhostButton!
    // MARK: - Private variable
    private var iconLeftAction: () -> Void = {}
    private var iconRightAction: () -> Void = {}
    private var dataSource: [DSMessageListModel] = []
    
    // Variable to set accessibility identifier
    private var prefixLabelId: String = ""
    private var prefixValueId: String = ""
    
    // MARK: - Public variable
    public var ratio: CGFloat = 1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        baseView.backgroundColor = DSColor.componentSummaryBackground
        bottomTableViewConstraint.constant = 0
        tableView.register(DSListMessageRatioCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        stackView.layoutIfNeeded()
        layoutIfNeeded()
    }
    
    public func setup(viewModel: DSListMessageExpandableViewModel) {
        dataSource = viewModel.contentList
        tableView.reloadData()
        
        if let buttonLeft = viewModel.leftButton,
           let iconLeft = buttonLeft.icon {
            leftButtonView.smallGhostNoPaddingRightIconRight(text: buttonLeft.title,
                                                             icon: iconLeft.image)
            iconLeftAction = buttonLeft.onClick
        }
        
        if let buttonRight = viewModel.rightButton,
           let iconRight = buttonRight.icon {
            rightButtonView.smallGhostNoPaddingLeftIconLeft(text: buttonRight.title,
                                                            icon: iconRight.image)
            iconRightAction = buttonRight.onClick
        }
        bottomView.isHidden = viewModel.rightButton == nil && viewModel.leftButton == nil
        tableView.layoutIfNeeded()
    }

    func setAccessibilityIdentifier(prefixLabelId: String,
                                    prefixValueId: String,
                                    rightButtonId: String,
                                    rightButtonLabelId: String,
                                    leftButtonId: String,
                                    leftButtonLabelId: String) {
        self.prefixLabelId = prefixLabelId
        self.prefixValueId = prefixValueId
        self.rightButtonView.setAccessibilityIdentifier(id: rightButtonId,
                                                        titleLabelId: rightButtonLabelId)
        self.leftButtonView.setAccessibilityIdentifier(id: leftButtonId,
                                                       titleLabelId: leftButtonLabelId)
    }
}

// MARK: - Action
extension DSMessageContentListView {
    @IBAction func rightAction(_ sender: Any) {
        iconRightAction()
    }
    
    @IBAction func leftAction(_ sender: Any) {
        iconLeftAction()
    }
}

// MARK: - UITableViewDataSource
extension DSMessageContentListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DSListMessageRatioCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .none
        cell.setup(label: dataSource[indexPath.row].label ?? "", value: dataSource[indexPath.row].value ?? "", ratio: ratio)
        
        // Set Accessibility Identifier
        let row = String(indexPath.row)
        cell.setAccessibilityIdentifier(labelTextId: prefixLabelId.idConcatenation(row),
                                        valueTextId: prefixValueId.idConcatenation(row))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DSMessageContentListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
