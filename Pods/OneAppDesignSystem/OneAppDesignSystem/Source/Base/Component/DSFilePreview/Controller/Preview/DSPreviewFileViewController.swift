//
//  DSFilePreviewViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/2/2567 BE.
//

import UIKit

public protocol DSPreviewFileInterface {
    var currentViewController: UIViewController { get }

    func showToast(title: String)
    func showLoading()
    func hideLoading()
    func setTextFieldState(_ state: DSTextFieldState)
    func dismiss(_ animation: Bool)
}

public protocol DSPreviewFileDelegate: AnyObject {
    func previewFile(
        _ viewController: DSPreviewFileViewController,
        shareDidTappedWith resource: DSPreviewFileResource
    )

    func previewFile(
        _ viewController: DSPreviewFileViewController,
        saveDidTappedWith resource: DSPreviewFileResource,
        with fileType: DSPreviewFileType
    )

    func previewFile(
        _ viewController: DSPreviewFileViewController,
        deleteFileWith resource: DSPreviewFileResource,
        completion: () -> Void
    )

    func previewFile(
        _ viewController: DSPreviewFileViewController,
        editFileSaveButtonDidTap resource: DSPreviewFileResource,
        textField: DSTextField,
        completion: () -> Void
    )
    
    func previewFile(
        _ viewController: DSPreviewFileViewController,
        closeFileWith resource: DSPreviewFileResource
    )
}

public extension DSPreviewFileDelegate {
    func previewFile(_ viewController: DSPreviewFileViewController, shareDidTappedWith resource: DSPreviewFileResource) { }
    func previewFile(_ viewController: DSPreviewFileViewController, saveDidTappedWith resource: DSPreviewFileResource, with fileType: DSPreviewFileType) { }
    func previewFile(_ viewController: DSPreviewFileViewController, deleteFileWith resource: DSPreviewFileResource, completion: () -> Void) {
        completion()
    }

    func previewFile(
        _ viewController: DSPreviewFileViewController,
        editFileSaveButtonDidTap resource: DSPreviewFileResource,
        textField: DSTextField,
        completion: () -> Void
    ) {
        completion()
    }
    
    func previewFile(
        _ viewController: DSPreviewFileViewController,
        closeFileWith resource: DSPreviewFileResource
    ) { }
}

public final class DSPreviewFileViewController: UIViewController, DSPreviewFileInterface {

    @IBOutlet weak var navBar: DSNavBar!
    @IBOutlet weak var headerSection: PreviewFileHeaderSection!
    @IBOutlet weak var content: PreviewFileContent!
    @IBOutlet weak var stickyButton: DSStickyButtonView!
    @IBOutlet weak var topHeaderConstraint: NSLayoutConstraint!

    // MARK: - Public
    public weak var delegate: DSPreviewFileDelegate?

    public var resources: [DSPreviewFileResource] = []

    public var currentViewController: UIViewController {
        return editViewController ?? self
    }

    public weak var editViewController: DSPreviewEditFileNameViewController?

    // MARK: - Internal
    internal var sceneState = PreviewFileSceneState(configuration: .default)

    internal var router: DSPreviewFileRouterInterface!
    internal var presenter: DSPreviewFilePresenterInterface!
    // MARK: - Private
    private var saveFileMenu: [DSPreviewFileType] = DSPreviewFileType.allCases

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        router = DSPreviewFileRouter(viewController: self)
        presenter = DSPreviewFilePresenter(view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObserver()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    public func showToast(title: String) {
        DispatchQueue.main.async {
            DSToast.showToast(style: .success, message: title)
        }
    }

    public func showLoading() {
        DSLoader.showLoading()
    }

    public func hideLoading() {
        DSLoader.hideLoading()
    }

    public func setTextFieldState(_ state: DSTextFieldState) {
        editViewController?.textField.updateLayout(state: state)
    }

    public func dismiss(_ animation: Bool) {
        performDismiss(animation)
    }
}

// MARK: - Action
extension DSPreviewFileViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        let keyboardHeight = keyboardFrame.height
        let keyboardTopY = view.frame.height - keyboardHeight
        let frame = view.convert(content.passwordTextField.frame, from: content.passwordTextField.superview)
        let textFieldYPosition = frame.origin.y + frame.size.height
        let topPadding: CGFloat = 24

        if textFieldYPosition > keyboardTopY {
            let toolBarHeight = content.passwordTextField.textField.inputAccessoryView?.frame.height ?? .zero
            let offset = textFieldYPosition - keyboardTopY + toolBarHeight + topPadding
            
            content.movePasswordTopContainer(offset: -offset)
        }

    }

    @objc func keyboardWillHide(notification: NSNotification) {
        content.updateTopPaddingErrorAndPasswordContent()
    }
}

// MARK: - DSPreviewFileViewInterface
extension DSPreviewFileViewController: DSPreviewFileViewInterface {
    func displayFullScreenError(viewModel: PreviewFileFullScreenErrorViewController.ViewModel) {
        router.gotoFullScreenErrorScreen(viewModel: viewModel)
    }
}

// MARK: - PreviewFileContentDelegate
extension DSPreviewFileViewController: PreviewFileContentDelegate {
    func previewFileContent(_ view: PreviewFileContent, didScroll scrollView: UIScrollView) {
        handleHeaderSection(scrollView)
    }

    func previewFileContent(_ view: PreviewFileContent, didEndScrolling scrollView: UIScrollView) {
        sceneState.resetTemporaryOffset()
    }

    func previewFileContent(_ view: PreviewFileContent, didEndDragging scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        sceneState.resetTemporaryOffset()
    }

    func previewFileContent(_ view: PreviewFileContent, contentDidChangedAt index: Int) {
        updateHeaderTitle()
    }

    func previewFileContentHasMaximumExceedFailure(_ view: PreviewFileContent) {
        presenter.contentDidLoadMaximumExceed()
    }

    func previewFileContent(_ view: PreviewFileContent, stateDidChanged state: PreviewFileContentState) {
        updateVisibleActionButton(state: state)
    }
    
    func previewFileContent(_ view: PreviewFileContent, didEndZooming scrollView: UIScrollView, with uiView: UIView?, atScale scale: CGFloat) {
        handleHeaderSection(scrollView)
    }
}

// MARK: - DSNavBarDelegate
extension DSPreviewFileViewController: DSNavBarDelegate {
    public func navBarCloseButtonDidTapped(_ view: DSNavBar) {
        dismiss(true)
    }

    public func navBarBackButtonDidTapped(_ view: DSNavBar) {
        dismiss(true)
    }
}

// MARK: - EditFilePreviewDelegate
extension DSPreviewFileViewController: PreviewEditFileNameDelegate {
    func editFilePreviewSaveButtonDidTapped(_ viewController: UIViewController, with textField: DSTextField, completion: () -> Void) {
        let resource = resources[content.currentIndex]
        delegate?.previewFile(
            self,
            editFileSaveButtonDidTap: resource,
            textField: textField,
            completion: completion
        )
    }

    func editFilePreviewSaveButtonDidFinished(with text: String) {
        updateFileName(text)
    }
}

// MARK: - PreviewFileFullScreenErrorDelegate
extension DSPreviewFileViewController: PreviewFileFullScreenErrorDelegate {
    func previewFileFullScreenErrorDidSelectPrimaryButton(_ viewController: PreviewFileFullScreenErrorViewController) {
        dismiss(true)
    }
}

// MARK: - PreviewFileHeaderSectionDelegate
extension DSPreviewFileViewController: PreviewFileHeaderSectionDelegate {
    func previewFileHeaderEditButtonDidTapped(_ view: PreviewFileHeaderSection) {
        let resource = resources[content.currentIndex]
        editViewController = router.gotoEditFileNameScreen(resource: resource)
    }

    func previewFileHeaderDeleteButtonDidTapped(_ view: PreviewFileHeaderSection) {
        let style = BottomSheetMessageStyle.confirm(
            title: PreviewFilePhrase.deleteFileBottomSheetTitle.localize(),
            description: PreviewFilePhrase.deleteFileBottomSheetSubTitle.localize(),
            buttonTextPrimary: PreviewFilePhrase.confirmButton.localize(),
            buttonTextPrimaryAction: { [weak self] in
                guard let self = self,
                      let delegate = self.delegate,
                      let resource = resources[safe: content.currentIndex] else {
                    return
                }

                delegate.previewFile(self, deleteFileWith: resource) {
                    self.performDeleteFile()
                }
            },
            buttonTextGhost: PreviewFilePhrase.cancelButton.localize(),
            buttonTextGhostAction: { }
        )

        DSBottomSheetWrapper.presentBottomSheetGeneral(
            viewController: self,
            style: style
        )
    }
}

// MARK: - PreviewFileContentDataSource
extension DSPreviewFileViewController: PreviewFileContentDataSource {
    var userResources: [DSPreviewFileResource] {
        get {
            return resources
        } set {
            resources = newValue
        }
    }
    
    var headerView: UIView {
        return headerSection
    }
}

// MARK: - DSBottomSheetMenuListMessageDelegate
extension DSPreviewFileViewController: DSBottomSheetMenuListMessageDelegate {
    public func bottomSheetIsDismiss(didSelected: Bool) { }

    public func didSelectRowWithTag(index: Int, tagId: String) {
        guard let fileType = DSPreviewFileType(rawValue: index),
              let resource = resources[safe: content.currentIndex]  else {
            return
        }

        if fileType.isPDF, resource.hasPasswordInOriginalFile {
            displayBottomSheetPasswordProtection { [weak self] in
                guard let self else { return }
                self.delegate?.previewFile(self, saveDidTappedWith: resource, with: fileType)
            }
        } else {
            delegate?.previewFile(self, saveDidTappedWith: resource, with: fileType)
        }
    }
}

// MARK: - Private
private extension DSPreviewFileViewController {
    func setupNavigationBar() {
        var style: DSNavBarStyle
        switch sceneState.configuration.presentationStyle {
        case .modal:
            style = .closeButtonOnly
        case .push:
            style = .backButtonOnly
        }
        navBar.setup(
            title: PreviewFilePhrase.previewNavigationBarTitle.localize(),
            style: style,
            theme: .light,
            isAchorWithSuperView: true
        )

        navBar.delegate = self
    }

    func setupUI() {
        headerSection.delegate = self
        headerSection.dsShadowDrop()
        headerSection.layoutIfNeeded()
        updateHeaderTitle()

        content.delegate = self
        content.dataSource = self
        content.setup()
        content.updateTopPaddingErrorAndPasswordContent()

        let primaryButtonViewModel = DSButtonViewModel(title: PreviewFilePhrase.saveButton.localize()) { [weak self] in
            guard let self, let resource = resources[safe: content.currentIndex] else { return }
            if resource.isShowSaveFileDialog {
                self.performBottomSheetSaveFile()
            } else {
                if resource.fileType.isPDF, resource.hasPasswordInOriginalFile {
                    displayBottomSheetPasswordProtection {
                        self.delegate?.previewFile(self, saveDidTappedWith: resource, with: resource.fileType)
                    }
                } else {
                    self.delegate?.previewFile(self, saveDidTappedWith: resource, with: resource.fileType)
                }
            }
        }

        let ghostButtonView = DSButtonViewModel(title: PreviewFilePhrase.shareButton.localize()) { [weak self] in
            guard let self, let delegate, let resource = resources[safe: content.currentIndex] else { return }
            if resource.fileType.isPDF, resource.hasPasswordInOriginalFile {
                displayBottomSheetPasswordProtection {
                    delegate.previewFile(self, shareDidTappedWith: resource)
                }
            } else {
                delegate.previewFile(self, shareDidTappedWith: resource)
            }
        }

        var style: DSStickyButtonStyle?
        switch sceneState.configuration.stickyPresentationStyle {
        case .saveAndShare:
            style = .ghostHorizontal(
                primaryButton: primaryButtonViewModel,
                ghostButton: ghostButtonView
            )
        case .save:
            style = .vertical(
                primaryButton: primaryButtonViewModel,
                ghostButton: nil
            )
        case .none:
            style = nil
        }

        stickyButton.isHidden = style.isNull
        if let style {
            stickyButton.setup(style: style)
        }
    }

    func setupObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func hiddenHeaderSection(_ isHidden: Bool) {
        let constant: CGFloat = isHidden ? -headerSection.frame.height : .zero
        topHeaderConstraint.constant = constant

        self.view.performAnimation(animated: true, interval: 0.3) { [weak self] in
            guard let self else { return }
            self.view.layoutIfNeeded()
        }
    }

    func performBottomSheetSaveFile() {
        let viewModels: [DSBottomSheetMenuListMessageItem] = saveFileMenu.map {
            .init(
                icon: $0.menuIcon,
                title: $0.menuTitle
            )
        }

        DSBottomSheetWrapper.presentBottomSheetMenuListMessage(
            viewController: self,
            title: PreviewFilePhrase.fileTypeBottomSheetTitle.localize(),
            itemList: viewModels
        )
    }

    func performDismiss(_ animated: Bool = true) {
        switch sceneState.configuration.presentationStyle {
        case .push:
            navigationController?.popViewControllerWithHandler(animated: animated) {
                self.closePreviewFile()
            }
        case .modal:
            dismiss(animated: animated) {
                self.closePreviewFile()
            }
        }
    }
    
    func closePreviewFile() {
        let resource = resources[content.currentIndex]
        delegate?.previewFile(self, closeFileWith: resource)
    }

    func updateFileName(_ fileName: String) {
        headerSection.fileName = fileName
        updateResource(index: content.currentIndex) { resource in
            resource.setFileName(fileName)
            return resource
        }
    }

    func performDeleteFile() {
        if resources.count <= 1 {
            performDismiss()
        } else {
            let index = content.currentIndex
            resources.remove(at: index)
            content.removeCurrentFile()
        }
    }

    func updateHeaderTitle() {
        guard let resource = resources[safe: content.currentIndex] else {
            return
        }

        headerSection.fileName = resource.fileName

        let page = "(\(content.currentIndex + 1)/\(resources.count))"

        let fileTypeTitle = [
            PreviewFilePhrase.prefixHeaderFile.localize(),
            resource.extensionFile
        ].compactMap { $0 }.joined(separator: " ")

        let isSingleFile = resources.count <= 1

        let numberOfFile = isSingleFile ? fileTypeTitle : [fileTypeTitle, page].joined(separator: " ")
        headerSection.numberOfFile = numberOfFile
    }

    func updateVisibleActionButton(state: PreviewFileContentState) {
        switch state {
        case .loaded:
            headerSection.setupVisibleButton(
                isDisplayEdit: sceneState.configuration.isDisplayEditFileName,
                isDisplayDelete: sceneState.configuration.isDisplayDeleteFile
            )

            stickyButton.isHidden = sceneState.configuration.stickyPresentationStyle == .none
        case .error, .password:
            headerSection.setupVisibleButton(
                isDisplayEdit: false,
                isDisplayDelete: false
            )

            stickyButton.isHidden = true
        default:
            break
        }
    }

    func displayBottomSheetPasswordProtection(completion: @escaping () -> Void) {
        guard let resource = resources[safe: content.currentIndex] else {
            return
        }

        DSBottomSheetWrapper.presentBottomSheetGeneral(
            viewController: self,
            style: .limitation(
                title: PreviewFilePhrase.passwordBottomSheetTitle.localize(),
                description: resource.passwordResource?.hintBottomSheetDescription ?? "",
                buttonTextPrimary: PreviewFilePhrase.okButton.localize(),
                buttonTextPrimaryAction: {
                    completion()
                },
                icon: DSIcons.icon24OutlineLock.image)
        )
    }
    
    func handleHeaderSection(_ scrollView: UIScrollView) {
        guard !scrollView.isZooming else {
            return
        }
        
        let yPosition = scrollView.contentOffset.y
        
        if sceneState.temporaryOffset == .zero {
            sceneState.set(temporaryOffset: scrollView.contentOffset)
        }
        
        if yPosition > sceneState.lastScrollingOffset.y, yPosition > .zero {
            hiddenHeaderSection(true)
        } else if yPosition < sceneState.lastScrollingOffset.y {
            hiddenHeaderSection(false)
        }
        
        let isHiddenShadowNavigationBar = topHeaderConstraint.constant == .zero
        navBar.setShadowDrop(isHidden: isHiddenShadowNavigationBar)
        sceneState.set(lastScrollingOffset: scrollView.contentOffset)
    }
}

// MARK: - SaveFileBottomSheetMenu
fileprivate extension DSPreviewFileType {
    var menuTitle: String {
        switch self {
        case .pdf:
            return PreviewFilePhrase.fileTypeBottomSheetItemPDF.localize()
        case .image:
            return PreviewFilePhrase.fileTypeBottomSheetItemPhoto.localize()
        }
    }

    var menuIcon: DSIcons {
        switch self {
        case .pdf:
            return .icon24Outlinefile
        case .image:
            return .icon24OutlinePhoto
        }
    }
}
