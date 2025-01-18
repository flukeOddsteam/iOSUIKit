//
//  DSError.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/5/2567 BE.
//

import UIKit

public protocol DSErrorDelegate: AnyObject {
    func errorScreenDidDisappear(_ error: DSError)
}

public struct DSErrorContentParameter {
    public let title: [String: String]?
    public let description: [String: String]?

    public init(
        title: [String: String]?,
        description: [String: String]?
    ) {
        self.title = title
        self.description = description
    }
}

public typealias DSErrorAction = (() -> Void)?

/**
    Error screen presenting.

    **Usage Example:**
     1. Create DSError object by passing the code like '8230-F-01-IL-01-01-000'.
     2. If the code is not exist. the object should be nil.
     3. Show ui with present function.

     ```swift
        override func viewDidLoad() {
             let error = DSError(code: "8230-F-01-IL-01-01-000")
             error.present(viewController: self,
                  primaryAction: {
                      error.close(completion: {
                             // Do something
                      })
                  }, ghostAction: {
                      error.close(completion: {
                             // Do something
                      })
                  })
             }
        }
     ```

     Parameter | Description
       --- | ---
       `code` | ` String` The id of error code.
       `params` | `DSErrorContentParameter?` The parameter of content title and description.
       `configuration` | ` [String: Bool]?` The parameter for multiple condition.
*/
public class DSError {

    private var errorData: ErrorData
    private var params: DSErrorContentParameter?
    private var configuration: [String: Bool]?

    private weak var viewController: UIViewController?

    public weak var delegate: DSErrorDelegate?

    public init?(
        code: String,
        params: DSErrorContentParameter? = nil,
        configuration: [String: Bool]? = nil
    ) {

        self.params = params
        self.configuration = configuration
        let service = FileReadableService<[String: ErrorData]>()
        guard let dictionary = service.getFile(filename: "error", extension: "json"),
              let errorData = dictionary[code] else {
            return nil
        }

        self.errorData = errorData
    }

    /**
     `Function to present error ui.`
     Parameter | Description
       --- | ---
       `viewController` | ` UIViewController` The parent UIViewController. We store this controller to present/dismiss the UI
       `primaryAction` | `The callback action of primary button` This closure will trigger when user click the primary button of fullscreen and bottom sheet.
       `ghostAction` | ` The callback action of ghost button` This closure will trigger when user click the ghost button of fullscreen and bottom sheet.
     */
    public func present(
        viewController: UIViewController,
        primaryAction: DSErrorAction,
        ghostAction: DSErrorAction
    ) {
        let presentable = ErrorPresentable(
            errorData: errorData,
            params: params,
            configuration: configuration
        )

        switch presentable.type {
        case .bottomSheet:
            let nibName = String(describing: ErrorBottomSheetViewController.self)
            let scene = ErrorBottomSheetViewController(
                nibName: nibName,
                bundle: .dsBundle
            )
            scene.delegate = self

            if case let .bottomSheet(errorSubType) = presentable.subType {
                scene.type = errorSubType.value(
                    block: .block,
                    confirm: .confirm,
                    limitation: .limitation,
                    multipleCondition: .multipleCondition
                )
            }
            let viewModel = ErrorBottomSheetViewModel(
                title: presentable.title,
                description: presentable.description,
                primaryButtonTitle: presentable.primaryButtonTitle,
                ghostButtonTitle: presentable.ghostButtonTitle,
                iconImage: presentable.image,
                multipleConditionData: presentable.multipleConditionData
            )
            scene.viewModel = viewModel
            scene.primaryButtonAction = primaryAction
            scene.ghostButtonAction = ghostAction

            viewController.presentBottomSheet(
                viewController: scene
            )

            setViewController(scene)

        case .fullPage:
            let nibName = String(describing: DSErrorFullPageViewController.self)
            let scene = DSErrorFullPageViewController(
                nibName: nibName,
                bundle: .dsBundle
            )
            scene.delegate = self
            let viewModel = DSErrorFullPageViewModel(
                title: presentable.title,
                description: presentable.description,
                primaryButtonTitle: presentable.primaryButtonTitle,
                ghostButtonTitle: presentable.ghostButtonTitle,
                mediaDisplayType: presentable.imageType.value(
                    illustration: .image,
                    icon: .icon
                ),
                imageType: .image(presentable.image))
            scene.viewModel = viewModel
            scene.primaryAction = primaryAction
            scene.ghostAction = ghostAction
            scene.modalPresentationStyle = .overFullScreen
            viewController.present(scene, animated: true)
            setViewController(scene)
        }
    }
    /**
     Parameter | Description
       --- | ---
       `completion` | ` (() -> Void)?` The action when error ui is closed.
     */
    public func close(completion: (() -> Void)? = nil) {
        viewController?.dismiss(animated: true, completion: completion)
    }
}

extension DSError: DSErrorFullPageEventDelegate {
    public func errorFullPageDidDismiss(_ viewController: DSErrorFullPageViewController) {
        delegate?.errorScreenDidDisappear(self)
    }
}

// MARK: - ErrorBottomSheetDelegate
extension DSError: ErrorBottomSheetDelegate {
    func errorBottomSheetDidDismiss(_ viewController: ErrorBottomSheetViewController) {
        delegate?.errorScreenDidDisappear(self)
    }
}

// MARK: - Private
private extension DSError {

    func setViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}
