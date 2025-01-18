//
//  DSBottomSheetListActionIconValue.swift
//  OneAppDesignSystem
//
//  Created by TTB on 8/11/2566 BE.
//

import UIKit

private enum Constants {
    static let footerHeight: CGFloat = 24
}

/**
 Custom component DSBottomSheetListActionIconValue
 
 **Usage Example:**
 1. Declare `DSBottomSheetListActionIconValue`
 2. Set up bottomSheetViewModel
 3. Set up deletegate.
 4. Present pan modal `DSBottomSheetListActionIconValue` that we defined.
 ```
 let bottomSheet = DSBottomSheetListActionIconValue(
                        nibName: String(describing: DSBottomSheetListActionIconValue.self),
                        bundle: .dsBundle
                   )
 
 let dataList: [DSListActionIconValueViewModel] = [
    .init(
         text: "title",
         valueText: "value",
         secondaryText: "description",
         leftIcon: nil,
         rightIcon: .icon16Check,
         hideRightIcon: .onlyIcon
    ),
    .init(
        text: "title",
        valueText: "value",
        secondaryText: "description",
        leftIcon: nil,
        rightIcon: nil,
        hideRightIcon: .onlyIcon
    )
 ]
 
 let bottomSheetViewModel = DSBottomSheetListActionIconValueViewModel(
    title: "Test",
    leftIcon: nil,
    selectedIndex: selectionIndex,
    listItem: dataList
 )
 
 bottomSheet.setUp(viewModel: bottomSheetViewModel)
 
 bottomSheet.delegate = self
 navigationController.presentPanModal(bottomSheet)
 ```
 */
public final class DSBottomSheetListActionIconValue: DSBaseBottomSheetViewController {
    @IBOutlet weak var listActionView: DSListActionView!

    // MARK: - Private variable
    private var dataList: [DSListActionIconValueViewModel] = []
    private var didSelectedDropdown: Bool = false
    
    // MARK: - Public variable
    public weak var delegate: DSBottomSheetDropdownDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        listActionView.setCustomTableFooterHeight(Constants.footerHeight)
        listActionView.setup(style: .listActionIconValue(viewModels: dataList))
        listActionView.delegate = self
    }

    // MARK: - Action
    /// For setup DSBottomSheetListActionIconValue
    public func setUp(viewModel: DSBottomSheetListActionIconValueViewModel) {
        setTitle(title: viewModel.title)
        setFontTitle(font: DSFont.h3)
        setLeftIcon(
            isHidden: true,
            isSpacing: true
        )
        setRightIcon(
            image: SvgIcons.icon24Close.image,
            isHidden: false,
            isSpacing: false
        )
        dataList = viewModel.listItem
    }
    
    public override func rightIconDidPerformAction() {
        super.rightIconDidPerformAction()
        delegate?.bottomSheet(self, didDismiss: didSelectedDropdown)
        dismiss(animated: true)
    }
    
    public override func panModalWillDismiss() {
        super.panModalWillDismiss()
        delegate?.bottomSheet(self, didDismiss: didSelectedDropdown)
    }
}

extension DSBottomSheetListActionIconValue: ListActionViewDelegate {
    public func listActionView(_ view: DSListActionView, didSelectRowAt index: Int) {
        didSelectedDropdown = true
        delegate?.bottomSheet(self, didSelectAt: index)
        dismiss(animated: true)
    }
    
    public func listActionView(_ view: DSListActionView, didScroll offset: CGPoint) {
        let isHidden = offset.y <= 0
        setHeaderShadow(isHidden: isHidden)
    }
}
