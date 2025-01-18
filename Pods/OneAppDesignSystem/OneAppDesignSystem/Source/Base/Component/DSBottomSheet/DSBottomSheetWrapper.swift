//
//  DSBottomSheetWrapper.swift
//  OneAppDesignSystem
//
//  Created by TTB on 27/9/2565 BE.
//

import UIKit

public enum DSBottomSheetAccessibilityIdentifier {
    case bottomSheetExternal(titleLabelId: String, closeButtonId: String, webViewId: String)
    case bottomSheetGeneralConfirm(titleId: String,
                                   descriptionId: String,
                                   buttonPrimaryId: String,
                                   buttonPrimaryLabelId: String,
                                   buttonGhostId: String,
                                   buttonGhostLabelId: String,
                                   closeButtonId: String)
    case bottomSheetGeneralConfirmImage(titleId: String,
                                        descriptionId: String,
                                        buttonPrimaryId: String,
                                        buttonPrimaryLabelId: String,
                                        buttonGhostId: String,
                                        buttonGhostLabelId: String,
                                        closeButtonId: String)
    case bottomSheetGeneralBlock(titleId: String,
                                 descriptionId: String,
                                 buttonPrimaryId: String,
                                 buttonPrimaryLabelId: String)
    case bottomSheetGeneralError(titleId: String,
                                 descriptionId: String,
                                 buttonPrimaryId: String,
                                 buttonPrimaryLabelId: String,
                                 closeButtonId: String)
    case bottomSheetGeneralInformative(titleId: String,
                                       subTitleId: String,
                                       descriptionId: String,
                                       closeButtonId: String)
    case bottomSheetGeneralLimitation(titleId: String,
                                      descriptionId: String,
                                      buttonPrimaryId: String,
                                      buttonPrimaryLabelId: String,
                                      closeButtonId: String)
    case bottomSheetMenuListMessage(titleId: String,
                                    prefixMenuListMessageId: String,
                                    prefixMenuListMessageLabelId: String,
                                    closeButtonId: String)
    case bottomSheetTechnical(titleId: String,
                              descriptionId: String,
                              buttonPrimaryId: String,
                              buttonPrimaryLabelId: String,
                              buttonGhostId: String,
                              buttonGhostLabelId: String,
                              closeButtonId: String)
    case bottomSheetMenuListMultiSection(titleId: String,
                                         prefixMenuListMultiSectionId: String,
                                         prefixMenuListMultiSectionLabelId: String,
                                         closeButtonId: String)
}

/**
 Custom component `DSBottomSheet` for design system
 
 **Bottom Sheet Confirm**
 
 ![image](/DocumentationImages/ds-bottomsheet-general-confirm.png)
 
 **Bottom Sheet Block**
 
 ![image](/DocumentationImages/ds-bottomsheet-general-block.png)
 
 **Bottom Sheet Informative**
 
 ![image](/DocumentationImages/ds-bottomsheet-general-informative-image.png)
 
 **Bottom Sheet Informative-message**
 
 ![image](/DocumentationImages/ds-bottomsheet-general-informative.png)
 
 **Bottom Sheet Error**
 
 ![image](/DocumentationImages/ds-bottomsheet-general-error.png)
 
 **Bottom Sheet  Limitation**
 
 ![image](/DocumentationImages/ds-bottomsheet-general-limitation.png)
 
 **Bottom Sheet  External**
 
 ![image](/DocumentationImages/ds-bottomsheet-external.png)
 
 **Bottom Sheet  Menu List Description**
 
 ![image](/DocumentationImages/ds-bottom-sheet-menu-list-description.png)
 
 
 **Usage Example:**
 1. import oneappdesignsystem.
 2. Call DSBottomSheetWrapper.present()
 3. Sending data to parameter of style.
 
 **For example :** Bottom sheet general -> style `confirm`
 ```
 DSBottomSheetWrapper.presentBottomSheetGeneral(viewController: self,
 style: .confirm(title: "Title",
 description: "Description",
 buttonTextPrimary: "Primary",
 buttonTextPrimaryAction: actionOne,
 buttonTextGhost: "Ghost",
 buttonTextGhostAction: actionTwo))
 ```
 
 **Example of** Bottom sheet external link
 ```
 DSBottomSheetWrapper.presentBottomSheetExternal(viewController: self,
 title: "Title",
 urlString: url,
 scrollEnable: true)
 ```
 
 **Example of** Bottom sheet menu list message
 ```
 let item = DSBottomSheetMenuListMessageItem(icon: .icon24OutlinePlaceholder,
 title: "Label")
 let itemList = [item,
 item,
 item,
 item,
 item]
 
 DSBottomSheetWrapper.presentBottomSheetMenuListMessage(
 viewController: self,
 title: "Heading, Keep it short (1 line)",
 itemList: itemList,
 tagId: "second")
 ```
 
 **Example of** Bottom sheet menu list description
 ```
 let viewModels = [
 DSBottomSheetMenuListDescriptionViewModel(title: "Label",
 description: "Description message here, keep this short, 2 lines maximum",
 imageStyle: .icon(.icon36OutlinePlaceholder, iconSize: .size32px)),
 DSBottomSheetMenuListDescriptionViewModel(title: "Label",
 description: "Description message here, keep this short, 2 lines maximum",
 imageStyle: .icon(.icon36OutlinePlaceholder, iconSize: .size32px))
 ]
 DSBottomSheetWrapper.presentBottomSheetMenuListDescription(viewController: self,
 title: "Heading, Keep it short (1 line)",
 imageRatio: .ratio1x1,
 viewModels: viewModels)
 ```
 
 **There's 5 style of bottom sheet general:**
 - Block
 - Error
 - Limitation
 - Confirm
 - Informative (this type can selecting description data type between `String` and `NSAttributeString` for customable)
 
 
 You can click on component in figma and see left section or about right section, It's will tell you what style of bottom sheet general that you implementing.
 
 **Note:** The optional parameter if you don't sending data it's will hide ui by each parameter that not send.
 
 */
public class DSBottomSheetWrapper {
    public static func presentBottomSheetGeneral(viewController: UIViewController, style: BottomSheetMessageStyle) {
        presentBottomSheetGeneral(viewController: viewController, style: style, delegate: nil, params: nil)
    }
    
    public static func presentBottomSheetGeneral(viewController: UIViewController,
                                                 style: BottomSheetMessageStyle,
                                                 delegate: DSBottomSheetGeneralEventDelegate?,
                                                 tagId: Int = 0,
                                                 params: [String: Any]?,
                                                 accessibilityIdentifier: DSBottomSheetAccessibilityIdentifier? = nil) {
        if case .confirmImage = style {
            presentBottomSheetGeneralConfirmImage(viewController: viewController,
                                                  style: style,
                                                  delegate: delegate,
                                                  params: params)
            return
        }
        let bottomsheet: DSBottomSheetGeneral = DSBottomSheetGeneral(style: style)
        bottomsheet.delegate = delegate
        bottomsheet.tagId = tagId
        bottomsheet.params = params
        viewController.presentBottomSheet(viewController: bottomsheet)
        
        switch accessibilityIdentifier {
        case .bottomSheetGeneralConfirm(let titleId,
                                        let descriptionId,
                                        let buttonPrimaryId,
                                        let buttonPrimaryLabelId,
                                        let buttonGhostId,
                                        let buttonGhostLabelId,
                                        let closeButtonId):
            bottomsheet.setAccessibilityIdentifier(
                style: .bottomSheetGeneralConfirm(
                    titleId: titleId,
                    descriptionId: descriptionId,
                    buttonPrimaryId: buttonPrimaryId,
                    buttonPrimaryLabelId: buttonPrimaryLabelId,
                    buttonGhostId: buttonGhostId,
                    buttonGhostLabelId: buttonGhostLabelId,
                    closeButtonId: closeButtonId))
        case .bottomSheetGeneralBlock(let titleId,
                                      let descriptionId,
                                      let buttonPrimaryId,
                                      let buttonPrimaryLabelId):
            bottomsheet.setAccessibilityIdentifier(
                style: .bottomSheetGeneralBlock(
                    titleId: titleId,
                    descriptionId: descriptionId,
                    buttonPrimaryId: buttonPrimaryId,
                    buttonPrimaryLabelId: buttonPrimaryLabelId))
        case .bottomSheetGeneralError(let titleId,
                                      let descriptionId,
                                      let buttonPrimaryId,
                                      let buttonPrimaryLabelId,
                                      let closeButtonId):
            bottomsheet.setAccessibilityIdentifier(
                style: .bottomSheetGeneralError(
                    titleId: titleId,
                    descriptionId: descriptionId,
                    buttonPrimaryId: buttonPrimaryId,
                    buttonPrimaryLabelId: buttonPrimaryLabelId,
                    closeButtonId: closeButtonId))
        case .bottomSheetGeneralInformative(let titleId,
                                            let subTitleId,
                                            let descriptionId,
                                            let closeButtonId):
            bottomsheet.setAccessibilityIdentifier(
                style: .bottomSheetGeneralInformative(
                    titleId: titleId,
                    subTitleId: subTitleId,
                    descriptionId: descriptionId,
                    closeButtonId: closeButtonId))
        case .bottomSheetGeneralLimitation(let titleId,
                                           let descriptionId,
                                           let buttonPrimaryId,
                                           let buttonPrimaryLabelId,
                                           let closeButtonId):
            bottomsheet.setAccessibilityIdentifier(
                style: .bottomSheetGeneralLimitation(
                    titleId: titleId,
                    descriptionId: descriptionId,
                    buttonPrimaryId: buttonPrimaryId,
                    buttonPrimaryLabelId: buttonPrimaryLabelId,
                    closeButtonId: closeButtonId))
        case .bottomSheetTechnical(let titleId,
                                   let descriptionId,
                                   let buttonPrimaryId,
                                   let buttonPrimaryLabelId,
                                   let buttonGhostId,
                                   let buttonGhostLabelId,
                                   let closeButtonId):
            bottomsheet.setAccessibilityIdentifier(
                style: .bottomSheetGeneralConfirm(
                    titleId: titleId,
                    descriptionId: descriptionId,
                    buttonPrimaryId: buttonPrimaryId,
                    buttonPrimaryLabelId: buttonPrimaryLabelId,
                    buttonGhostId: buttonGhostId,
                    buttonGhostLabelId: buttonGhostLabelId,
                    closeButtonId: closeButtonId))
        case .bottomSheetMenuListMultiSection(let titleId,
                                              let prefixMenuListMultiSectionId,
                                              let prefixMenuListMultiSectionLabelId,
                                              let closeButtonId):
            bottomsheet.setAccessibilityIdentifier(
                style: .bottomSheetMenuListMultiSection(
                    titleId: titleId,
                    prefixMenuListMultiSectionId: prefixMenuListMultiSectionId,
                    prefixMenuListMultiSectionLabelId: prefixMenuListMultiSectionLabelId,
                    closeButtonId: closeButtonId
                )
            )
        default: break
        }
    }
    
    public static func presentBottomSheetGeneralConfirmImage(viewController: UIViewController,
                                                             style: BottomSheetMessageStyle,
                                                             delegate: DSBottomSheetGeneralEventDelegate?,
                                                             tagId: Int = 0,
                                                             params: [String: Any]?,
                                                             accessibilityIdentifier: DSBottomSheetAccessibilityIdentifier? = nil) {
        let bottomsheet: DSBottomSheetGeneralConfirmImage = DSBottomSheetGeneralConfirmImage(style: style)
        bottomsheet.delegate = delegate
        bottomsheet.tagId = tagId
        bottomsheet.params = params
        viewController.presentBottomSheet(viewController: bottomsheet)
        
        switch accessibilityIdentifier {
        case let .bottomSheetGeneralConfirmImage(titleId,
                                                 descriptionId,
                                                 buttonPrimaryId,
                                                 buttonPrimaryLabelId,
                                                 buttonGhostId,
                                                 buttonGhostLabelId,
                                                 closeButtonId):
            bottomsheet.setAccessibilityIdentifier(style: .bottomSheetGeneralConfirmImage(titleId: titleId,
                                                                                          descriptionId: descriptionId,
                                                                                          buttonPrimaryId: buttonPrimaryId,
                                                                                          buttonPrimaryLabelId: buttonPrimaryLabelId,
                                                                                          buttonGhostId: buttonGhostId,
                                                                                          buttonGhostLabelId: buttonGhostLabelId,
                                                                                          closeButtonId: closeButtonId))
        default: break
        }
    }
    
    public static func presentBottomSheetExternal(viewController: UIViewController,
                                                  title: String,
                                                  urlString: String,
                                                  scrollEnable: Bool = true,
                                                  visibleBackButton: Bool = true,
                                                  accessibilityIdentifier: DSBottomSheetAccessibilityIdentifier? = nil) {
        let bottomsheet: DSBottomSheetExternal = DSBottomSheetExternal()
        bottomsheet.titleText = title
        bottomsheet.urlString = urlString
        bottomsheet.scrollEnable = scrollEnable
        bottomsheet.visibleBackButton = visibleBackButton
        viewController.presentBottomSheet(viewController: bottomsheet)
        switch accessibilityIdentifier {
        case .bottomSheetExternal(let titleLabelId,
                                  let closeButtonId,
                                  let webViewId):
            bottomsheet.setAccessibilityIdentifier(titleLabelId: titleLabelId,
                                                   closeButtonId: closeButtonId,
                                                   webViewId: webViewId)
        default: break
        }
    }
    
    public static func presentBottomSheetMenuListMessage(viewController: UIViewController,
                                                         title: String,
                                                         itemList: [DSBottomSheetMenuListMessageItem],
                                                         tagId: String = "",
                                                         accessibilityIdentifier: DSBottomSheetAccessibilityIdentifier? = nil) {
        
        if itemList.isNotEmpty {
            let viewModel: DSBottomSheetMenuListMessageViewModel = .init(title: title,
                                                                         listItem: itemList)
            let bottomsheet = DSBottomSheetMenuListMessage(viewModel: viewModel)
            if let delegate = viewController as? DSBottomSheetMenuListMessageDelegate {
                bottomsheet.delegate = delegate
            }
            bottomsheet.tagId = tagId
            viewController.presentBottomSheet(viewController: bottomsheet)
            
            switch accessibilityIdentifier {
            case .bottomSheetMenuListMessage(let titleId,
                                             let prefixMenuListMessageId,
                                             let prefixMenuListMessageLabelId,
                                             let closeButtonId):
                bottomsheet.setAccessibilityIdentifier(titleId: titleId,
                                                       closeButtonId: closeButtonId,
                                                       prefixMenuListMessage: prefixMenuListMessageId,
                                                       prefixLabel: prefixMenuListMessageLabelId)
            default: break
            }
        }
    }
    
    public static func presentBottomSheetMenuListDescription(
        viewController: UIViewController,
        title: String,
        tagId: Int = .zero,
        imageRatio: DSRatio,
        viewModels: [DSBottomSheetMenuListDescriptionViewModel],
        delegate: DSBottomSheetMenuListDescriptionDelegate? = nil
    ) {
        let bottomSheet = BottomSheetMenuListDescriptionViewController(tagId: tagId, headerTitle: title, imageRatio: imageRatio, viewModels: viewModels)
        bottomSheet.delegate = delegate
        viewController.presentBottomSheet(viewController: bottomSheet)
    }
    
    public static func presentBottomSheetMenuListMultiSection(
        viewController: UIViewController,
        tagId: Int = .zero,
        viewModel: [DSBottomSheetMenuListMultiSectionViewModel],
        accessibilityIdentifier: DSBottomSheetAccessibilityIdentifier? = nil
    ) {
        
        if viewModel.isNotEmpty {
            let bottomsheet = DSBottomSheetMenuListMultiSection(
                tagId: tagId,
                viewModel: viewModel
            )
            
            if let delegate = viewController as? DSBottomSheetMenuListMultiSectionDelegate {
                bottomsheet.delegate = delegate
            }
            
            viewController.presentBottomSheet(viewController: bottomsheet)
            
            switch accessibilityIdentifier {
            case .bottomSheetMenuListMultiSection(let titleId,
                                                  let prefixMenuListMultiSectionId,
                                                  let prefixMenuListMultiSectionLabelId,
                                                  let closeButtonId):
                bottomsheet.setAccessibilityIdentifier(
                    titleId: titleId,
                    prefixMenuListMultiSectionId: prefixMenuListMultiSectionId,
                    prefixLabel: prefixMenuListMultiSectionLabelId,
                    closeButtonId: closeButtonId
                )
            default: break
            }
        }
    }
}

public protocol DSBottomSheetGeneralEventDelegate: AnyObject {
    func bottomSheetDidTapCloseButton(tagId: Int, params: [String: Any]?)
    func bottomSheetWillDismiss(tagId: Int, params: [String: Any]?)
    func bottomSheetDidTapBackground(tagId: Int, params: [String: Any]?)
}

public extension DSBottomSheetGeneralEventDelegate {
    func bottomSheetDidTapCloseButton(tagId: Int, params: [String: Any]?) {}
    func bottomSheetWillDismiss(tagId: Int, params: [String: Any]?) {}
    func bottomSheetDidTapBackground(tagId: Int, params: [String: Any]?) {}
}
