//
//  DSCheckboxListMessageExpandable.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/4/2566 BE.
//

import UIKit

private enum Constants {
    static let animationTimeInterval: TimeInterval = 0.2
}

public protocol DSCheckboxListMessageExpandableDelegate: AnyObject {
    func checkboxListMessageExpandable(_ view: DSCheckboxListMessageExpandable, didExpandWithExpandState state: DSCheckboxListMessageExpandableState, withTag tag: Int)
    func checkboxListMessageExpandable(_ view: DSCheckboxListMessageExpandable, didSelectWithState state: DSSelectionCheckboxState, withTag tag: Int)
}

public extension DSCheckboxListMessageExpandableDelegate {
    func checkboxListMessageExpandable(_ view: DSCheckboxListMessageExpandable, didExpandWithExpandState state: DSCheckboxListMessageExpandableState, withTag tag: Int) { }
    func checkboxListMessageExpandable(_ view: DSCheckboxListMessageExpandable, didSelectWithState state: DSSelectionCheckboxState, withTag tag: Int) { }
}

public protocol DSCheckboxListMessageExpandableDataSource: AnyObject {
    func checkboxListMessageExpandable(_ view: DSCheckboxListMessageExpandable, contentViewWithTagId tag: Int) -> UIView
}

/**
    Custom component DSCheckboxListMessageExpandable for Design System
 
    ![image](/DocumentationImages/ds-checkbox-list-message-expandable.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSCheckboxListMessageExpandable` Class to the UIView.
    2. Binding constraint and don't set `height`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
```
        @IBOutlet weak var checkboxListMessage: DSCheckboxListMessageExpandable!

        override func viewDidLoad() {
             super.viewDidLoad()
             let viewModel = DSCheckboxListMessageExpandableViewModel(labelTitle: "Label",
                                                                      valueTitle: "Value",
                                                                       description: .labelAndValueDesc(labelDescription: "Desc (Optional) Lorem ipsum dolor sit amet consectetur. Ut turp", valueDescription: "Desc (Optional) Lorem ipsum dolor sit amet consectetur. Ut turp"),
                                                                      isEnableExpandable: false, pillViewModel: DSCollectionPillViewModel(status: .init(title: "DEFAULT", style: .default), tag: ["DEFAULT", "DEFAULT"]))
             checkboxListMessageNoExpand1.setup(tagId: 1,
                                                contentMultipiler: 50/50,
                                                isDisplayDivider: true,
                                                viewModel: viewModel1,
                                                dataSource: self,
                                                delegate: self)
        }
```

     5. Conform protocol DSCheckboxListMessageExpandableDataSource for provide view to DSCheckboxListMessageExpandable. (optional if isEnableExpandable is false.)
```
     extension ViewController: DSCheckboxListMessageExpandableDataSource {
        func checkboxListMessageExpandable(_ view: DSCheckboxListMessageExpandable, contentViewWithTagId tag: Int) -> UIView {
             let view = UIView(frame: .zero)
             return view
        }
     }
```

     6. Conform protocol DSCheckboxListMessageExpandableDelegate for receive event when users has interactive with checkbox (optiional)
```
     extension ViewController: DSCheckboxListMessageExpandableDelegate {
            func checkboxListMessageExpandable(_ view: DSCheckboxListMessageExpandable,
                                                didExpandWithExpandState state: DSCheckboxListMessageExpandableState,
                                                withTag tag: Int) {
                // Do stuff
            }

            func checkboxListMessageExpandable(_ view: DSCheckboxListMessageExpandable,
                                                didSelectWithState state: DSSelectionCheckboxState,
                                                withTag tag: Int) {
                // Do stuff
            }
     }
```
 */

public final class DSCheckboxListMessageExpandable: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var checkboxView: DSInputCheckBox!
    @IBOutlet weak var titleContentView: CheckboxListExpandTitleContentView!
    @IBOutlet weak var descriptionContentView: CheckboxListExpandDescriptionContentView!
    @IBOutlet weak var pillContentView: DSMessageContentPillView!
    @IBOutlet weak var expandContainerView: UIView!
    @IBOutlet weak var divider: UIView!

    // MARK: - Public variable
    public var tagId: Int = .zero

    /// The object that acts as the delegate of the DSCheckboxListMessageExpandable.
    public weak var dataSource: DSCheckboxListMessageExpandableDataSource?
    
    /// The object that acts as the datasource of the DSCheckboxListMessageExpandable.
    public weak var delegate: DSCheckboxListMessageExpandableDelegate?

    /// Variable for updating state of DSCheckboxListMessageExpandable
    public var state: DSSelectionCheckboxState = .default {
        didSet {
            updateState()
        }
    }
    
    /// Variable for updating display divider line (default is true)
    public var isDisplayDivider: Bool = true {
        didSet {
            divider.isHidden = !isDisplayDivider
        }
    }
    
    /// Variable for updating expand state. (default is collapse)
    public var expandState: DSCheckboxListMessageExpandableState = .collapse {
        didSet {
            updateDisplayExpandContentView()
        }
    }
    
    // MARK: - Private variable
    private var contentMultipiler: CGFloat = 1
    private var isEnabledExpandable: Bool = true

    // MARK: - Public Constructor
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// For setup DSCheckboxListMessageExpandable
    ///
    /// Parameter for setup DSCheckboxListMessageExpandable
    /// - Parameter tagId: Tag identifier of DSCheckboxListMessageExpandable.
    /// - Parameter contentMultipiler: The ratio of header content. example 70/30 or 50/50
    /// - Parameter isDisplayDivider: The argument that tell view to display or hidden divider line.
    /// - Parameter viewModel: The data for binding to view.
    /// - Parameter dataSource: Argument of dataSource.
    /// - Parameter delegate: Argument of delegate.
    public func setup(tagId: Int = .zero,
                      contentMultipiler: CGFloat = 1,
                      isDisplayDivider: Bool = true,
                      viewModel: DSCheckboxListMessageExpandableViewModel,
                      dataSource: DSCheckboxListMessageExpandableDataSource?,
                      delegate: DSCheckboxListMessageExpandableDelegate?) {
        self.tagId = tagId
        self.isDisplayDivider = isDisplayDivider
        self.contentMultipiler = contentMultipiler
        self.dataSource = dataSource
        self.delegate = delegate
        
        titleContentView.setup(title: viewModel.labelTitle,
                               value: viewModel.valueTitle,
                               isEnabledExpandable: viewModel.isEnableExpandable,
                               contentMultipiler: contentMultipiler)
                
        descriptionContentView.isHidden = viewModel.description.isNull
        if let descriptionStyle = viewModel.description {
            descriptionContentView.setup(contentMultipiler: contentMultipiler,
                                         style: descriptionStyle)
        }
        
        pillContentView.isHidden = viewModel.pillViewModel.isNull
        if let pillViewModel = viewModel.pillViewModel {
            let viewModels = convertPillViewModelToContentPillListViewModel(viewModel: pillViewModel)
            pillContentView.isHidden = viewModels.isEmpty
            pillContentView.setup(viewModel: viewModels)
        }
        
        isEnabledExpandable = viewModel.isEnableExpandable
        if viewModel.isEnableExpandable {
            setupExpandContent()
        }
    }
}

// MARK: - Action
extension DSCheckboxListMessageExpandable {
    @objc func checkboxTouchAreaDidTapped(_ sender: UIGestureRecognizer) {
        guard [.default, .checked].contains(state) else {
            return
        }
        
        if state == .default {
            state = .checked
        } else if state == .checked {
            state = .default
        }
        
        delegate?.checkboxListMessageExpandable(self, didSelectWithState: state, withTag: tagId)
    }
}

// MARK: - CheckboxListExpandTitleContentViewDelegate
extension DSCheckboxListMessageExpandable: CheckboxListExpandTitleContentViewDelegate {
    func checkboxListExpandContentDidTapExpand(_ view: CheckboxListExpandTitleContentView) {
        guard isEnabledExpandable else {
            return
        }
        
        expandState.switched()
        delegate?.checkboxListMessageExpandable(self, didExpandWithExpandState: expandState, withTag: tagId)
    }
}

// MARK: - Private
private extension DSCheckboxListMessageExpandable {
    func commonInit() {
        setupXib()
        setupUI()
        setupGesture()
    }
    
    func setupUI() {
        backgroundColor = .clear
        divider.backgroundColor = DSColor.componentDividerBackgroundBig
        titleContentView.delegate = self
    }
    
    func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(checkboxTouchAreaDidTapped(_:)))
        self.addGestureRecognizer(gesture)
    }
    
    func setupExpandContent() {
        guard let dataSource = dataSource else {
            return
        }
        
        expandContainerView.removeSubviews()
        let view = dataSource.checkboxListMessageExpandable(self, contentViewWithTagId: tagId)
        view.translatesAutoresizingMaskIntoConstraints = false
        expandContainerView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: expandContainerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: expandContainerView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: expandContainerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: expandContainerView.trailingAnchor)
        ])
    }
    
    func updateState() {
        checkboxView.state = state
    }
    
    func updateDisplayExpandContentView() {
        titleContentView.updateExpandState(state: self.expandState)
        
        let isCollapse = self.expandState == .collapse
        UIView.animate(withDuration: Constants.animationTimeInterval,
                       delay: .zero,
                       options: .curveLinear,
                       animations: {
            self.expandContainerView.isHidden = isCollapse
            self.expandContainerView.alpha = isCollapse ? .zero : 1
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func convertPillViewModelToContentPillListViewModel(
        viewModel: DSCollectionPillViewModel
    ) -> [DSMessageContentPillViewModel] {
        var viewModels: [DSMessageContentPillViewModel] = []
        
        if let pillStatus = viewModel.status {
            let status = DSMessageContentPillViewModel(style: .status(pillStatus.style), title: pillStatus.title)
            viewModels.append(status)
        }
        
        let pillTags: [DSMessageContentPillViewModel] = viewModel.tag?.compactMap {
            DSMessageContentPillViewModel(style: .tag, title: $0)
        } ?? []
        
        viewModels.append(contentsOf: pillTags)
        return viewModels
    }
}
