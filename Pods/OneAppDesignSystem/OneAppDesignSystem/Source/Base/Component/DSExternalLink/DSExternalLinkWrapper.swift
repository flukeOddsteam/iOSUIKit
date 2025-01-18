//
//  DSExternalLinkWrapper.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/4/2566 BE.
//

import UIKit

/**
 Custom component `DSExternalLink` for design system
 
 **External Full Page**
 
 ![image](/DocumentationImages/ds-external-full-page.png)

 **Usage Example:**
 1. import oneappdesignsystem.
 2. Call DSExternalLinkWrapper.openExternalLink()
 3. Sending data to parameter.
 
 **For example :**
    ```
    let request = URLRequest(url: url)
    DSExternalLinkWrapper.openExternalLink(
        viewController: self,
        request: request,
        navigationTitle: "Title",
        snackbarConfiguration: DSSnacksBarConfiguration(
            text: "ขณะนี้คุณกำลังทำรายการอยู่บนแพลตฟอร์ม \(url) ธนาคารทหารไทยธนชาติไม่มีส่วน รับผิดชอบต่อความเสียหายใดๆ ที่อาจเกิดขึ้น",
            buttonStyle: .ghost,
            buttonLabel: "รับทราบ"
        )
    )
    ```
 */
public class DSExternalLinkWrapper {

    @available(*, deprecated, message: "Use openExternalLink with snackbarConfiguration instead")
    public static func openExternalLink(
        viewController: UIViewController,
        request: URLRequest,
        navigationTitle: String,
        snackbarTitle: String,
        snackbarButtonTitle: String,
        snackbarButtonStyle: DSSnacksBarButtonStyle = .ghost,
        delegate: DSExternalLinkDelegate? = nil
    ) {
        openExternalLink(
            viewController: viewController,
            request: request,
            navigationTitle: navigationTitle,
            snackbarConfiguration: DSSnacksBarConfiguration(
                text: snackbarTitle,
                buttonStyle: snackbarButtonStyle,
                buttonLabel: snackbarButtonTitle
            ),
            delegate: delegate
        )
    }

    public static func openExternalLink(
        viewController: UIViewController,
        request: URLRequest,
        navigationTitle: String,
        snackbarConfiguration: DSSnacksBarConfiguration,
        delegate: DSExternalLinkDelegate? = nil
    ) {
        let nibName = String(describing: DSExternalLinkViewController.self)
        let externalLinkViewController = DSExternalLinkViewController(nibName: nibName, bundle: .dsBundle)
        let router = DSExternalLinkRouter(viewController: externalLinkViewController)

        externalLinkViewController.navigationBarTitle = navigationTitle
        externalLinkViewController.request = request
        externalLinkViewController.snackBarConfiguration = snackbarConfiguration
        externalLinkViewController.delegate = delegate
        externalLinkViewController.router = router
        externalLinkViewController.modalPresentationStyle = .overFullScreen
        externalLinkViewController.modalTransitionStyle = .coverVertical

        viewController.present(externalLinkViewController, animated: true)
    }
}
