//
//  DSCommonContainerView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/11/2567 BE.
//

import UIKit

// Datasource
public protocol DSCommonContainerDataSource: AnyObject {
    func dscommonPaymentValueContainer(_ view: UIView) -> [DSCommonContainerViewModelInterface]
    func spacing(_ view: UIView) -> CGFloat
    func selectMultiple(_ view: UIView) -> Bool
}
// Delegate
public protocol DSCommonContainerDelegate: AnyObject {
    func didSelect(_ view: UIView, index: [Int], tagIds: [Int])
}

// ViewModel Interface
public protocol DSCommonContainerViewModelInterface {
    var tagId: Int { get set }
    var title: String { get set }
    var value: String { get set }
    var isEnabled: Bool { get set }
    var isSelected: Bool { get set }
    var ratio: CGFloat { get set }
}

public protocol DSCommonContainerViewInterface {
    var tagId: Int { get }
    func getIsSelected() -> Bool
    func reloadView()
}

public class DSCommonContainerView: UIView {
    // Outlet
    @IBOutlet private weak var stackView: UIStackView!
    // Getter
    public var subViewItems: [UIView] {
        return viewItems
    }
    
    public var viewsSelected: [UIView] {
        return subViewItems.filter { ($0 as? DSCommonContainerViewInterface)?.getIsSelected() ?? false }
    }
    
    public var tagIdsSelected: [Int] {
        return viewsSelected.compactMap({ $0.tag })
    }
    
    public var indexItemsSelected: [Int] {
        return viewsSelected.enumerated().compactMap { index, element in
            if let item = element as? DSCommonContainerViewInterface {
                return item.getIsSelected() ? index : nil
            }
            return nil
        }
    }
    
    // Object
    private var viewItems: [UIView] = []
    private var dataSourceItems: [DSCommonContainerViewModelInterface] = []
    private var isSelectMultiple: Bool = true
    // DataSource
    private weak var dataSource: DSCommonContainerDataSource?
    // Delegate
    private weak var delgate: DSCommonContainerDelegate?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
    }
    
    // MARk: - Public
    public func set(dataSource: DSCommonContainerDataSource?,
                    delgate: DSCommonContainerDelegate?) {
        self.dataSource = dataSource
        self.delgate = delgate
        updateData()
    }
    
    public func set(tagId: Int) {
        self.tag = tagId
    }
    
    public func allDeselected() {
        self.resetDeselected()
    }
}

private extension DSCommonContainerView {
    func setViews() {
        setupXib()
        // setup
        updateData()
    }
    
    func updateData() {
        guard let dataSource = dataSource?.dscommonPaymentValueContainer(self) else { return }
        dataSourceItems = dataSource
        initSubViews(dataSource)
        updateStackSpacing()
        updateSelectMultiple()
    }
    
    func updateStackSpacing() {
        guard let spacing = dataSource?.spacing(self) else { return }
        stackView.spacing = spacing
        stackView.clipsToBounds = false
    }
    
    func updateSelectMultiple() {
        guard let isSelectMultiple = dataSource?.selectMultiple(self) else { return }
        self.isSelectMultiple = isSelectMultiple
    }
    
    func initSubViews(_ items: [DSCommonContainerViewModelInterface]) {
        viewItems = items.map { item -> DSCardSelectionView in
            let radioView = DSCardSelectionView()
            radioView.tag = item.tagId
            radioView.setUp(dataSource: self, delegate: self)
            return radioView
        }
        updateSubViews()
    }
    
    func updateSubViews() {
        stackView = viewItems.reduce(into: stackView) { stack, view in
            view.clipsToBounds = false
            stack?.addArrangedSubview(view)
        }
        reloadAllSubview()
    }
    
    func reloadAllSubview() {
        viewItems.forEach { view in
            if let itemView = view as? DSCommonContainerViewInterface {
                itemView.reloadView()
            }
        }
    }
    
    func resetDeselected(view: DSCommonContainerViewInterface? = nil) {
        viewItems.forEach { radioView in
            if let itemView = radioView as? DSCommonContainerViewInterface,
               itemView.tagId != view?.tagId {
                if let dscView = itemView as? DSCardSelectionView {
                    dscView.set(isSelected: false)
                }
            }
        }
    }
}

// MARK: - DetaSource
extension DSCommonContainerView: DSCardSelectionDataSource {
    func getItem(view: DSCardSelectionView) -> DSCardSelectionViewModel? {
        return dataSourceItems.first { $0.tagId == view.tag }
            .map { item -> DSCardSelectionViewModel in
                return DSCardSelectionViewModel(title: item.title,
                                                value: item.value,
                                                tagId: item.tagId,
                                                isEnabled: item.isEnabled,
                                                isSelected: item.isSelected,
                                                ratio: item.ratio)
        }
    }
    
    public func dscardSelectionView(in view: DSCardSelectionView) -> DSCardSelectionViewModel? {
        return getItem(view: view)
    }
}

// MARK: - Delegate
extension DSCommonContainerView: DSCardSelectionDelegate {
    private func setStateSelected(view: DSCommonContainerViewInterface) {
        if isSelectMultiple {
            toggleSelected(view: view)
            return
        }
        // single selected
        resetDeselected(view: view)
        toggleSelected(view: view)
    }
    
    private func toggleSelected(view: DSCommonContainerViewInterface) {
        if let dscView = view as? DSCardSelectionView {
            if isSelectMultiple {
                dscView.toggleSelected()
                return
            }
            dscView.set(isSelected: true)
        }
    }
    
    public func didSelect(_ view: DSCardSelectionView, tagId: Int) {
        setStateSelected(view: view)
        delgate?.didSelect(self, index: indexItemsSelected, tagIds: tagIdsSelected)
    }
}
