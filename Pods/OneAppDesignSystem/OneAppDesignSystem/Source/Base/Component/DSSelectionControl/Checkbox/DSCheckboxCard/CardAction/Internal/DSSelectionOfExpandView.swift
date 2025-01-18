//
//  DSSelectionOfExpandView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 26/10/2565 BE.
//

import UIKit

public struct DSSelectionOfExpandViewModel {
    public let title: String
    public var pill: [DSSelectionPillViewModel]
    public let selectedPillIndex: Int

    public init(title: String, pill: [DSSelectionPillViewModel], selectedPillIndex: Int) {
        self.title = title
        self.pill = pill
        self.selectedPillIndex = selectedPillIndex
    }
}

public struct DSSelectionPillViewModel {
    public let valueOfPill: String
    public var messageList: [DSSelectionListModel]

    public init(valueOfPill: String, messageList: [DSSelectionListModel]) {
        self.valueOfPill = valueOfPill
        self.messageList = messageList
    }
}

public struct DSSelectionListModel {
    public var label: String?
    public var value: String?

    public init(label: String? = nil, value: String? = nil) {
        self.label = label
        self.value = value
    }
}

protocol DSSelectionOfExpandViewDelegate: AnyObject {
    func didChangeValueOfPill(value: String, index: Int)
}

class DSSelectionOfExpandView: UIView {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: IntrinsicTableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bottomTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var leftButtonView: DSGhostButton!
    // MARK: - Private variable
    private var iconLeftAction: () -> Void = {}
    private var iconRightAction: () -> Void = {}
    private var dataSource: [DSSelectionListModel] = []
    private var optionViewModel: DSSelectionOfExpandViewModel?
    @IBOutlet weak var pillRadioCollection: DSPillRadio!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var pillRadioView: UIView!
    
    weak var delegate: DSSelectionOfExpandViewDelegate?
    
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
        title.font = DSFont.h4
        title.textColor = DSColor.componentLightDefault
        baseView.backgroundColor = DSColor.componentSummaryBackground
        bottomTableViewConstraint.constant = 8
        tableView.register(DSMessageContentListCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        stackView.layoutIfNeeded()
        layoutIfNeeded()
        pillRadioCollection.delegate = self
    }
    
    public func setup(type: ExpandType, button: DSButtonViewModel?) {
        switch type {
        case .list(let datas):
            title.isHidden = true
            dataSource = datas
            pillRadioView.isHidden = true
        case .option(let datas):
            title.isHidden = false
            title.text = datas.title
            optionViewModel = datas
            let pillRadioModel: [DSPillRadioViewModel] = datas.pill.enumerated().map { index, data in
                if index == datas.selectedPillIndex {
                    return DSPillRadioViewModel(state: .selected, title: data.valueOfPill)
                } else {
                    return DSPillRadioViewModel(state: .default, title: data.valueOfPill)
                }
            }
            dataSource = optionViewModel?.pill[safe: datas.selectedPillIndex]?.messageList ?? []
            pillRadioCollection.setup(tagId: 0, viewModel: pillRadioModel, interitemSpacingForPill: 4)
            if pillRadioModel.count == 0 {
                pillRadioView.isHidden = true
            }
        }
        
        if let buttonLeft = button,
           let iconLeft = buttonLeft.icon {
            leftButtonView.smallGhostNoPaddingRightIconRight(text: buttonLeft.title,
                                                             icon: iconLeft.image)
            iconLeftAction = buttonLeft.onClick
            bottomView.isHidden = false
            bottomTableViewConstraint.constant = 0
        }
        
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
    
    @IBAction func leftAction(_ sender: Any) {
        iconLeftAction()
    }
}

// MARK: - UITableViewDataSource
extension DSSelectionOfExpandView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DSMessageContentListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .none
        cell.setup(messageModel: dataSource[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DSSelectionOfExpandView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - DSPillRadioDelegate
extension DSSelectionOfExpandView: DSPillRadioDelegate {
    func didSelectPillRadio(tagId: Int, index: Int) {
        dataSource = optionViewModel?.pill[index].messageList ?? []
        tableView.reloadData()
        tableView.layoutIfNeeded()
        delegate?.didChangeValueOfPill(value: optionViewModel?.pill[index].valueOfPill ?? "", index: index)
    }
}
