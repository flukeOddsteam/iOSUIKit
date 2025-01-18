//
//  DSPreviewFile.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/2/2567 BE.
//

import UIKit

/**
 Common flow DSPreviewFile

 ![image](/DocumentationImages/ds-preview-file.png)

 **Usage Example:**
  Just call DSPreviewFile.show it will present common flow preview file

  Parameter | Description
    --- | ---
    `resources` | ` The array of DSPreviewFileResource` This contains the request URL, file name, extension type, file type, and configuration to show a popup dialog when the save button is tapped.
    `configuration` | `DSPreviewFileConfiguration` The configuration contains attributes for showing/hiding delete and edit file buttons and buttons sticky.
    `delegate` | `DSPreviewFileDelegate` The event that occurred in DSPreviewFile.
    `viewController` | `UIViewController` The UIViewController instance to present DSPreviewFile


    ## Example
 ```swift
 let configuration = DSPreviewFileConfiguration(
     presentationStyle: .push,
     stickyPresentationStyle: .saveAndShare,
     isDisplayEditFileName: true,
     isDisplayDeleteFile: true
 )

 viewController = DSPreviewFile.show(
     resources: [
             .init(
                 request: URLRequest(
                     url: URL(
                         string: "url"
                     )!
                 ),
                 fileName: "design-system.pdf",
                 fileType: .pdf,
                 isShowSaveFileDialog: true,
                 extensionFile: ".pdf")
     ],
     configuration: configuration,
     delegate: self,
     viewController: self
 )
```
 Return Type | Description
   --- | ---
   `DSPreviewFileViewController` | The UIViewController class for DSPreviewFile.

 ## Resource parameters
 Parameter | Description
   --- | ---
   `request` | ` URLRequest`: The request to display pdf/image in preview file.
 `fileName` | ` String`: The request to display pdf/image in preview file.
 `fileType` | ` DSPreviewFileType`: The type of file. e.g. image or pdf.
 `extensionFile` | ` String?`: The text to display in top of content
 `isShowSaveFileDialog` | ` Bool` The flag to display choice between pdf and image.
 `passwordResource` | ` PasswordResource` Password object that contain phrase and password for bypass.

```
```
 ## Resource parameters
 Parameter | Description
   --- | ---
   `password` | ` String?`: The password of pdf for bypass.
 `hintTextField` | ` String`: Hint in helper text of textfield.
 `hintError` | ` String`: Hint in error helper text in case password is invalid or wrong.
 `hintBottomSheetDescription` | ` String`: The content to display when share or save file with password protected.
 `placeholderTextField` | ` String`: The Placeholder of textfield.
 ```
*/
public struct DSPreviewFile {

    @discardableResult
    public static func show(
        resources: [DSPreviewFileResource],
        configuration: DSPreviewFileConfiguration,
        delegate: DSPreviewFileDelegate?,
        viewController: UIViewController
    ) -> DSPreviewFileViewController {

        let nibName = String(describing: DSPreviewFileViewController.self)
        let previewViewController = DSPreviewFileViewController(
            nibName: nibName,
            bundle: .dsBundle
        )

        previewViewController.resources = resources
        previewViewController.delegate = delegate
        
        let sceneState = PreviewFileSceneState(configuration: configuration)
        previewViewController.sceneState = sceneState

        switch sceneState.configuration.presentationStyle {
        case .push:
            viewController.navigationController?.pushViewController(
                previewViewController,
                animated: true
            )

        case .modal:
            let navigationController = UINavigationController(
                rootViewController: previewViewController
            )

            navigationController.setNavigationBarHidden(
                true,
                animated: false
            )

            navigationController.modalPresentationStyle = .overFullScreen

            viewController.present(
                navigationController,
                animated: true
            )
        }

        return previewViewController
    }
}
