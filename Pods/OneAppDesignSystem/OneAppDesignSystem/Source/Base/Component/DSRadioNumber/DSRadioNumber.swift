//
//  DSRadioNumber.swift
//  OneAppDesignSystem
//
//  Created by TTB on 30/12/22.
//

import UIKit

private enum Constants {
    static let radioHeight: CGFloat = 40
    static let radioWidth: CGFloat = 40
    static let interitemSpacingForRadio: CGFloat = 16
}

// Parameter | Type + Information
//  --- | ---
//  `state` | `DSRadioNumberState` State of each radio which can be .default and .selected. There should be only one radio that has selected state in the model.
//  `number` | `Integer` Label of radio number cannot be nil.
public struct DSRadioNumberViewModel {
    var state: DSRadioNumberState
    var number: Int
    
    public init(
        state: DSRadioNumberState,
        number: Int
    ) {
        self.state = state
        self.number = number
    }
}

/// Delegate for DSRadioNumber
public protocol DSRadioNumberDelegate: AnyObject {
    /// on tap radio number
    func didSelectRadioNumber(number: Int)
}

/**
 Custom component DSRadioNumber for Design System
 
 DSRadioNumber is a group of DSRadioNumberViews.
 
 ![image](/DocumentationImages/ds-radio-number.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSRadioNumber` Class to the UIView
 2. Binding constraint
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or wherever you want.
     ```
         @IBOutlet weak var radioNumber: DSRadioNumber!
         
         override func viewDidLoad() {
             super.viewDidLoad()
             let radioNumberList = [DSRadioNumberViewModel(state: .default, number: 1),
                                    DSRadioNumberViewModel(state: .default, number: 2),
                                    DSRadioNumberViewModel(state: .default, number: 89),
                                    DSRadioNumberViewModel(state: .default, number: 99)]
             radioNumber.setup(viewModel: radioNumberList)
             radioNumber.delegate = self
         }
     ```
 How to use DSRadioNumberViewModel
  Parameter | Type + Information
    --- | ---
    `state` | `DSRadioNumberState` State of each radio number which can be .default, .onPress and .selected. There should be only one item that has selected state in the model.
    `number` | `Integer` Label of radio number cannot be nil.
    ```
         public struct DSRadioNumberViewModel {
             var state: DSRadioNumberState
             var number: Int
         }
    ```
 */
public final class DSRadioNumber: UIView {

    @IBOutlet weak var collectionView: IntrinsicCollectionView!
    
    private var viewModel: [DSRadioNumberViewModel] = []
    private var selectedIndex: Int?
    private var interitemSpacingForRadio: CGFloat = Constants.interitemSpacingForRadio
    
    private var prefixRadioNumberId: String = ""
    private var prefixRadioNumberLabelId: String = ""
    
    /// Delegate of DSRadioNumber
    public weak var delegate: DSRadioNumberDelegate?
    
    /// For setup DSRadioNumber
    ///
    /// Parameter for setup DSRadioNumber
    /// - Parameter viewModel: list of DSRadioNumberViewModel to display on DSRadioNumber.
    /// - Parameter interitemSpacingForRadio: space between each item. Default spacing is 16.
    public func setup(viewModel: [DSRadioNumberViewModel],
                      interitemSpacingForRadio: CGFloat? = 16) {
        self.viewModel = viewModel
        let leftAlignedFlowLayout = LeftAlignedFlowLayout()
        leftAlignedFlowLayout.minimumInteritemSpacing = interitemSpacingForRadio ?? Constants.interitemSpacingForRadio
        self.interitemSpacingForRadio = interitemSpacingForRadio ?? Constants.interitemSpacingForRadio
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
    
    public func setAccessibilityIndentifier(id: String? = nil,
                                            prefixRadioNumberId: String? = nil,
                                            prefixRadioNumberLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.prefixRadioNumberId = prefixRadioNumberId ?? ""
        self.prefixRadioNumberLabelId = prefixRadioNumberLabelId ?? ""
    }
}

// MARK: - UICollectionViewDataSource
extension DSRadioNumber: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DSRadioNumberViewCell", for: indexPath) as? DSRadioNumberViewCell
        cell?.radioNumber.setup(action: {},
                                state: viewModel[indexPath.row].state,
                                number: viewModel[indexPath.row].number)
        
        // Set accessibility identifier for each DSRadioNumberView
        let row = String(indexPath.row)
        cell?.radioNumber.setAccessibilityIdentifier(id: self.prefixRadioNumberId.idConcatenation(row),
                                                     radioNumberLabelId: self.prefixRadioNumberLabelId.idConcatenation(row))
        
        let isSelected = indexPath.item == selectedIndex
        let hasSelection = selectedIndex != nil
    
        var radioNumberState: DSRadioNumberState
        if hasSelection {
            radioNumberState = isSelected && hasSelection ? .selected : .default
            cell?.radioNumber.state = radioNumberState
        } else {
            cell?.radioNumber.state = viewModel[indexPath.row].state
        }
        return cell ?? DSRadioNumberViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
        guard selectedIndex != indexPath.row else { return }
        selectedIndex = indexPath.row
        delegate?.didSelectRadioNumber(number: viewModel[indexPath.row].number)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DSRadioNumber: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.font = DSFont.labelList
        label.text = String(viewModel[indexPath.row].number).maxLength(length: 2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: Constants.radioWidth, height: Constants.radioHeight)
       
        return CGSize(width: label.frame.width, height: label.frame.height )
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interitemSpacingForRadio
    }
}

// MARK: - Private
private extension DSRadioNumber {
    func setupUI() {
        self.collectionView.register(
            UINib(nibName: "DSRadioNumberViewCell", bundle: .dsBundle),
            forCellWithReuseIdentifier: "DSRadioNumberViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}
