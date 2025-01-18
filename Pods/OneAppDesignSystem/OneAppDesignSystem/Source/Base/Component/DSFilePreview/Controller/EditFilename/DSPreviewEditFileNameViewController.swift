//
//  EditFilePreviewViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/3/2567 BE.
//

import UIKit

protocol PreviewEditFileNameDelegate: AnyObject {
    func editFilePreviewSaveButtonDidTapped(
        _ viewController: UIViewController,
        with textField: DSTextField,
        completion: () -> Void
    )

    func editFilePreviewSaveButtonDidFinished(
        with text: String
    )
}

public final class DSPreviewEditFileNameViewController: UIViewController {

    @IBOutlet public weak var textField: DSTextField!

    @IBOutlet weak var navBar: DSNavBar!
    @IBOutlet weak var saveButton: DSPrimaryButton!

    weak var delegate: PreviewEditFileNameDelegate?

    public var resource: DSPreviewFileResource!

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
    }

    public func dismiss(completion: (() -> Void)? = nil) {
        view.setTransition(type: .moveIn, subtype: .fromLeft)
        dismiss(animated: true, completion: completion)
    }
}

// MARK: - Action
extension DSPreviewEditFileNameViewController {
    @IBAction func saveButtonDidTapped(_ sender: Any) {
        delegate?.editFilePreviewSaveButtonDidTapped(
            self,
            with: textField,
            completion: { [weak self] in
            guard let self = self else { return }
            self.dismiss {
                self.delegate?.editFilePreviewSaveButtonDidFinished(with: self.textField.text)
            }
        })
    }
}

// MARK: - DSNavBarDelegate
extension DSPreviewEditFileNameViewController: DSNavBarDelegate {
    public func navBarBackButtonDidTapped(_ view: DSNavBar) {
        dismiss()
    }
}

// MARK: - Private
private extension DSPreviewEditFileNameViewController {
    func setupNavigationBar() {
        navBar.setup(
            title: PreviewFilePhrase.editFileNameNavigationBarTitle.localize(),
            style: .backButtonOnly,
            theme: .light,
            isAchorWithSuperView: false
        )

        navBar.delegate = self
    }

    func setupUI() {
        
        saveButton.largePrimaryText(
            text: PreviewFilePhrase.editFileNameSaveButtonTitle.localize()
        )

        textField.setup(
            title: PreviewFilePhrase.editFileNamePlaceholder.localize(),
            state: .default,
            text: resource.fileName,
            helperText: "",
            placeholder: PreviewFilePhrase.editFileNamePlaceholder.localize(),
            clickAbleIcon: nil,
            clickableIconAction: { }
        )
    }
}
