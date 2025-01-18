//
//  DSSelectionRadioCardBenefitList.swift
//  OneAppDesignSystem
//
//  Created by TTB on 25/4/2566 BE.
//

import UIKit

private enum Constants {
    static let cellIdentifier = "RadioCardBenefitCollectionViewCell"
}

public protocol DSSelectionRadioCardBenefitListDelegate: AnyObject {
    func radioCardBenefitList(_ view: DSSelectionRadioCardBenefitList, didSelectItemAt index: Int)
}

/**
 Custom component DSSelectionRadioCardBenefitList for Design System
 
 ![image](/DocumentationImages/ds-radio-card-benefit.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSSelectionRadioCardBenefitList` Class to the UIView
 2. Binding constraint and don't set `height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
        @IBOutlet weak var radioCardBenefitList1: DSSelectionRadioCardBenefitList!
         
        override func viewDidLoad() {
            super.viewDidLoad()
            
         let radioCardBenefitContent1 = DSRadioCardBenefitViewModel(image: .image(SvgIcons.ttbFlashCreditCardImageMock.image),
                                                                    title: "Label Max 1 Line",
                                                                    amount: "0,000",
                                                                    amountUnit: "Unit")
         
         let radioCardBenefitContent2 = DSRadioCardBenefitViewModel(image: .image(SvgIcons.ttbReserveCreditCardImageMock.image),
                                                                    title: "Label Max 1 Line Label Max 1 Line",
                                                                    amount: "00,000,000",
                                                                    amountUnit: "Unit",
                                                                    isEnable: true)
         
         let radioCardBenefitContent3 = DSRadioCardBenefitViewModel(image: .image(SvgIcons.ttbSignaturetCreditCardImageMock.image),
                                                                    title: "Label Max 1 Line",
                                                                    amount: "0,000",
                                                                    amountUnit: "Unit",
                                                                    isEnable: false)
         
         let radioCardBenefitContent4 = DSRadioCardBenefitViewModel(image: .image(SvgIcons.placeholderSmall16x9.image),
                                                                    title: "Label Max 1 Line",
                                                                    amount: "0,000")
         
         let radioCardBenefitContent5 = DSRadioCardBenefitViewModel(image: .image(SvgIcons.placeholderSmall16x9.image),
                                                                    title: "Label Max 1 Line Label Max 1 Line",
                                                                    amount: "00,000,000,000",
                                                                    isEnable: true)
         
         let radioCardBenefitContent6 = DSRadioCardBenefitViewModel(image: .image(SvgIcons.placeholderSmall16x9.image),
                                                                    title: "Label Max 1 Line",
                                                                    amount: "0,000",
                                                                    isEnable: false)
         
         radioCardBenefitList1.setup(style: .card,
                                     viewModels: [radioCardBenefitContent1,
                                                  radioCardBenefitContent2,
                                                  radioCardBenefitContent3],
                                     selectedIndex: 1)
         radioCardBenefitList2.tag = 0
         radioCardBenefitList1.delegate = self
         
         radioCardBenefitList2.setup(style: .icon,
                                     viewModels: [radioCardBenefitContent4,
                                                  radioCardBenefitContent5,
                                                  radioCardBenefitContent6])
         radioCardBenefitList2.tag = 1
         radioCardBenefitList2.delegate = self
        }
     ```
 
 How to use DSRadioCardBenefitViewListViewModel for DSBulletList remark type
  Parameter | Type + Information
    --- | ---
    `image` | `DSRadioCardBenefitImageType` For setup the card image that came from UIImage or url.
    `title` | `String` For setup the title in TextFieldWithPlusMinusButton.
    `amount` | `String` For setup the value of amout.
    `isEnable` | `Int` For setup the enable of radio card view.
    ```
        public struct DSRadioCardBenefitViewListViewModel {
            var image: DSRadioCardBenefitImageType
            var title: String
            var amount: String
            var isEnable: Bool
        }
    ```
 */
public final class DSSelectionRadioCardBenefitList: UIView {
    // MARK: - Public outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Public properties
    public weak var delegate: DSSelectionRadioCardBenefitListDelegate?
    public var style: DSSelectionRadioCardBenefitListStyle = .card
    public var viewModels: [DSRadioCardBenefitViewModel] = [] {
        didSet {
            updateCollectionView()
        }
    }
    
    public var selectedIndex: Int? {
        didSet {
            updateCollectionView()
        }
    }
    
    /// For setup DSSelectionRadioCardBenefitList///
    ///
    /// Parameters for setup funtion
    /// - Parameter style: style of card to display.
    /// - Parameter viewModels: card view models .
    /// - Parameter selectedIndes: set selected index for radio button view ( optional )
    public func setup(style: DSSelectionRadioCardBenefitListStyle = .card, viewModels: [DSRadioCardBenefitViewModel], selectedIndex: Int? = nil) {
        self.style = style
        self.viewModels = viewModels
        self.selectedIndex = selectedIndex
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}
    
// MARK: - UICollectionViewDataSource
extension DSSelectionRadioCardBenefitList: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RadioCardBenefitCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let viewModel = self.viewModels[indexPath.row]
        let isSelected = selectedIndex == indexPath.item
        cell.setup(style: self.style,
                   viewModel: viewModel,
                   isSelected: isSelected)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DSSelectionRadioCardBenefitList: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        self.delegate?.radioCardBenefitList(self,
                                            didSelectItemAt: indexPath.row)
    }
}

extension DSSelectionRadioCardBenefitList: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: 0,
                            bottom: 0,
                            right: 0)
    }
}

// MARK: - Private
private extension DSSelectionRadioCardBenefitList {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        self.collectionView.register(RadioCardBenefitCollectionViewCell.self, bundle: .dsBundle)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.collectionView.layoutIfNeeded()
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}
