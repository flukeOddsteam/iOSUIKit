//
//  DSPillRadio.swift
//  OneAppDesignSystem
//
//  Created by TTB on 26/10/22.
//

import Foundation
import UIKit

private enum Constants {
    static let pillHeight: CGFloat = 40
    static let pillMinimumWidth: CGFloat = 40
    static let horizontalPadding: CGFloat = 24
    static let interitemSpacingForPill: CGFloat = 8
}

// Parameter | Type + Information
//  --- | ---
//  `state` | `DSPillRadioState` State of each pill radio which can be .default, .selected and .disable. There should be only one pill that has selected state in the model.
//  `title` | `String` Label of pill radio cannot be nil.
public struct DSPillRadioViewModel {
    var state: DSPillRadioState
    var title: String
    
    public init(
        state: DSPillRadioState,
        title: String
    ) {
        self.state = state
        self.title = title
    }
}

/// Delegate for DSPillRadio
public protocol DSPillRadioDelegate: AnyObject {
    /// on tap pill radio
    func didSelectPillRadio(tagId: Int, index: Int)
}

/**
 Custom component DSPillRadio for Design System
 
 DSPillRadio is a group of DSPillRadioViews.
 
 ![image](/DocumentationImages/ds-pill-radio.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSPillRadio` Class to the UIView
 2. Binding constraint
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or wherever you want.
     ```
        @IBOutlet weak var pillRadioCollection: DSPillRadio!
         
         override func viewDidLoad() {
             super.viewDidLoad()
             let pillRadioModel = [DSPillRadioViewModel(state: .default, title: "Label"),
                           DSPillRadioViewModel(state: .default, title: "Label"),
                           DSPillRadioViewModel(state: .default, title: "Label"),
                           DSPillRadioViewModel(state: .default, title: "Label"),
                           DSPillRadioViewModel(state: .default, title: "Label")]
             pillRadioCollection.setup(tagId: 001, viewModel: pillRadioModel)
             pillRadioCollection.delegate = self
         }
     ```
 How to use DSPillRadioViewModel
  Parameter | Type + Information
    --- | ---
    `state` | `DSPillRadioState` State of each pill radio which can be .default, .selected and .disable. There should be only one pill that has selected state in the model.
    `title` | `String` Label of pill radio cannot be nil.
    ```
        public struct DSPillRadioViewModel {
            var state: DSPillRadioState
            var title: String
        }
    ```
 */
public final class DSPillRadio: UIView {
    @IBOutlet private weak var collectionView: IntrinsicCollectionView!
    
    private var viewModel: [DSPillRadioViewModel] = []
    private var selectedIndex: Int?
    private var interitemSpacingForPill: CGFloat = Constants.interitemSpacingForPill
    
    // Variable for setup accessibility identifier
    private var prefixPillRadioId: String = ""
    private var prefixPillRadioLabelId: String = ""
    
    /// Delegate of DSPillRadio
    public weak var delegate: DSPillRadioDelegate?
    
    // MARK: - Public
    /// Variable for set tag ID of DSPillRadio
    public var tagId: Int = 0
    
    /// For setup DSPillRadio
    ///
    /// Parameter for setup DSPillRadio
    /// - Parameter tagId: tag ID of DSPillRadio.
    /// - Parameter viewModel: list of DSPillRadioViewModel to display on DSPillRadio.
    /// - Parameter interitemSpacingForPill: space between each pill. Default spacing is 8.
    public func setup(tagId: Int,
                      viewModel: [DSPillRadioViewModel],
                      interitemSpacingForPill: CGFloat? = 8) {
        self.tagId = tagId
        self.viewModel = viewModel
        let leftAlignedFlowLayout = LeftAlignedFlowLayout()
        leftAlignedFlowLayout.minimumInteritemSpacing = interitemSpacingForPill ?? Constants.interitemSpacingForPill
        self.interitemSpacingForPill = interitemSpacingForPill ?? Constants.interitemSpacingForPill
        collectionView.collectionViewLayout = leftAlignedFlowLayout
        collectionView.reloadData()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public func commonInit() {
        setupXib()
        setupUI()
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           prefixPillRadioId: String? = nil,
                                           prefixPillRadioLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.prefixPillRadioId = prefixPillRadioId ?? ""
        self.prefixPillRadioLabelId = prefixPillRadioLabelId ?? ""
    }
}

// MARK: - UICollectionViewDataSource
extension DSPillRadio: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSPillRadioViewCell", for: indexPath) as?
        DSPillRadioViewCell
        cell?.pillRadio.setup(textLabel: viewModel[indexPath.row].title,
                              state: viewModel[indexPath.row].state,
                              action: {})
        
        // Set accessibility identifier for each DSPillRadioView
        let row = String(indexPath.row)
        cell?.pillRadio.setAccessibilityIdentifier(id: self.prefixPillRadioId.idConcatenation(row),
                                                   labelId: self.prefixPillRadioLabelId.idConcatenation(row))
        
        let isSelected = indexPath.item == selectedIndex
        let hasSelection = selectedIndex != nil
        let isPillRadioIsNotDisabled = cell?.pillRadio.state != .disable
        cell?.isUserInteractionEnabled = isPillRadioIsNotDisabled
        
        var pillRadioState: DSPillRadioState
        if hasSelection {
            pillRadioState = isSelected && hasSelection ? .selected : .default
            pillRadioState = isPillRadioIsNotDisabled ? pillRadioState : .disable
            cell?.pillRadio.state = pillRadioState
        } else {
            cell?.pillRadio.state = viewModel[indexPath.row].state
        }
    
        return cell ?? DSPillRadioViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedIndex != indexPath.row else { return }
        selectedIndex = indexPath.row
        delegate?.didSelectPillRadio(tagId: self.tagId, index: indexPath.row)
        collectionView.reloadData()
    }

    /// Reset selectedIndex to `nil`. This will make dequeued cell from collection view to
    /// use selected state from view model.
    func resetSelectedIndex() {
        selectedIndex = nil
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DSPillRadio: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.font = DSFont.labelList
        label.text = viewModel[indexPath.row].title
        label.translatesAutoresizingMaskIntoConstraints = false
        let labelMinimumWidth = Constants.pillMinimumWidth - Constants.horizontalPadding
        if label.intrinsicContentSize.width < labelMinimumWidth {
            label.frame = CGRect(x: 0, y: 0, width: labelMinimumWidth, height: Constants.pillHeight)
        } else {
            label.frame = CGRect(x: 0, y: 0, width: label.intrinsicContentSize.width, height: Constants.pillHeight)
        }
        return CGSize(width: label.frame.width + Constants.horizontalPadding, height: label.frame.height )
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interitemSpacingForPill
    }
}

// MARK: - Private
private extension DSPillRadio {
    func setupUI() {
        self.collectionView.register(
            UINib(nibName: "DSPillRadioViewCell", bundle: .dsBundle),
            forCellWithReuseIdentifier: "DSPillRadioViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}
