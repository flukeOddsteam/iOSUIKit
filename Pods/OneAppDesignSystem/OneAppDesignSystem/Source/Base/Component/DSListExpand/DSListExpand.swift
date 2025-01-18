//
//  DSListExpand.swift
//  OneAppDesignSystem
//
//  Created by TTB on 21/3/2566 BE.
//

import UIKit

public protocol DSListExpandDelegate: AnyObject {
    func listExpand(_ view: DSListExpand, expandStateDidUpdate state: DSListExpandContentState, atIndex index: Int)
}

public protocol DSListExpandDataSource: AnyObject {
    func listExpand(_ view: DSListExpand, viewAtIndex index: Int) -> UIView
}

/**
    Custom component DSListExpand for Design System
 
    ![image](/DocumentationImages/ds-list-expand.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSListExpand` Class to the UIView.
    2. Binding constraint and don't set `height`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
         @IBOutlet weak var listExpand: DSListExpand!
         override func viewDidLoad() {
             super.viewDidLoad()
             let viewModels = [
                 DSListExpandViewModel(title: "Label (Max 2 lines)", textStyle: .h3, image: nil),
                 DSListExpandViewModel(title: "Label (Max 2 lines)", textStyle: .h3, image: .icon(.icon24OutlinePlaceholder), type: .icon),
                 DSListExpandViewModel(title: "Label (Max 2 lines)", textStyle: .h3, image: .icon(.icon24OutlinePlaceholder), type: .icon),
                 DSListExpandViewModel(title: "Label (Max 2 lines)", textStyle: .paragraphMedium, image: nil),
                 DSListExpandViewModel(title: "Label (Max 2 lines)", textStyle: .paragraphMedium, image: .icon(.icon24OutlinePlaceholder), type: .spot),
                 DSListExpandViewModel(title: "Label (Max 2 lines)", textStyle: .paragraphMedium, image: .icon(.icon24OutlinePlaceholder), type: .spot),
                 DSListExpandViewModel(title: "Label (Max 2 lines)", textStyle: .paragraphMedium, image: .icon(.icon24OutlinePlaceholder), type: .spot)
             ]
             listExpand.setup(viewModels: viewModels, dataSource: self, delegate: self, isAnimated: true)
        }
     ```
     5. Conform protocol DSListExpandDataSource for provide view to DSListExpand. (mandatory)
    ```
     extension ViewController: DSListExpandDataSource {
         func listExpand(_ view: DSListExpand, viewAtIndex index: Int) -> UIView {
             let view = UIView(frame: .zero)
             return view
         }
     }
    ```
     6. Conform protocol DSListExpandDelegate for receive event when users touch the expand list (optiional)
     ```
     extension ViewController: DSListExpandDelegate {
         func listExpand(_ view: DSListExpand, expandStateDidUpdate state: DSListExpandContentState, atIndex index: Int) {
             // Do stuff
         }
     }
     ```
 */
public final class DSListExpand: UIView {
    
    @IBOutlet weak var stackView: UIStackView!
    
    /// The array of viewModel for binding data to DSListExpand
    public var viewModels: [DSListExpandViewModel] = []
    
    /// The object that acts as the delegate of the DSListExpand.
    public weak var delegate: DSListExpandDelegate?
    
    /// The object that acts as the datasource of the DSListExpand.
    public weak var dataSource: DSListExpandDataSource!
    
    /// The variable for show animation when user tap expand
    public var isAnimated: Bool = true {
        didSet {
            updateAnimationConfig()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSTextFieldSearch
    ///
    /// Parameter for setup DSTextFieldSearch
    /// - Parameter viewModels: data for binding to view.
    /// - Parameter dataSource: datasource of DSListExpand.
    /// - Parameter delegate: delegate of DSListExpand.
    /// - Parameter isAnimated: The flag that .tell DSListExpand to show/not show expand animation.

    public func setup(viewModels: [DSListExpandViewModel], dataSource: DSListExpandDataSource, delegate: DSListExpandDelegate?, isAnimated: Bool = true) {
        self.delegate = delegate
        self.dataSource = dataSource
        self.viewModels = viewModels
        self.isAnimated = isAnimated
        
        stackView.removeAllSubviews()
        buildViews()
    }
    
    /// Function for refresh list
    public func relayout() {
        stackView.removeAllSubviews()
        buildViews()
    }
}

// MARK: - ListExpandContentViewDelegate
extension DSListExpand: ListExpandContentViewDelegate {
    func listExpandContentView(_ view: ListExpandContentView, didSelectExpand state: DSListExpandContentState) {
        guard let index = stackView.subviews.firstIndex(of: view) else {
            return
        }
        
        delegate?.listExpand(self, expandStateDidUpdate: state, atIndex: index)
    }
}

// MARK: - Private
private extension DSListExpand {
    func commonInit() {
        setupXib()
    }
    
    func buildViews() {
        let views: [UIView] = viewModels.enumerated().map {
            let view = ListExpandContentView(frame: .zero)
            let contentView = dataSource.listExpand(self, viewAtIndex: $0.offset)
            view.setup(viewModel: $0.element, contentView: contentView, isAnimated: self.isAnimated, delegate: self)
            return view
        }
        
        stackView.addArrangedSubviews(views)
    }
    
    func updateAnimationConfig() {
        stackView.subviews.forEach {
            if let view = $0 as? ListExpandContentView {
                view.isAnimated = self.isAnimated
            }
        }
    }
}
