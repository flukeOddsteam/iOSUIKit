//
//  PreviewFileContent.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/2/2567 BE.
//

import UIKit
import WebKit
import PDFKit
import IQKeyboardManagerSwift

private enum Constants {
    static let defaultHorizontalPadding: CGFloat = 56
    static let defaultTopPaddingContent: CGFloat = 16
    static let defaultHeaderHeight: CGFloat = 99
}

final class PreviewFileContent: UIView {
    // MARK: - Content
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var contentContainerView: UIView!
    @IBOutlet weak var previousButton: DSClickableIconGeneralIcon!
    @IBOutlet weak var nextButton: DSClickableIconGeneralIcon!

    // MARK: - Error
    @IBOutlet weak var emptyAndError: DSEmptyAndErrorState!
    @IBOutlet weak var errorContainerView: UIView!
    @IBOutlet weak var topErrorContentConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorContentView: UIView!
    @IBOutlet weak var errorStackView: UIStackView!
    @IBOutlet weak var retryGhostButton: DSGhostButton!

    // MARK: - Password
    @IBOutlet weak var passwordContainerView: UIView!
    @IBOutlet weak var passwordTextField: DSTextFieldPassword!
    @IBOutlet weak var passwordContentView: UIView!
    @IBOutlet weak var passwordIconImageView: UIImageView!
    @IBOutlet weak var passwordTitleImageView: UILabel!
    @IBOutlet weak var topPasswordContentConstraint: NSLayoutConstraint!

    @IBOutlet var cornerImageViews: [UIImageView]!

    weak var delegate: PreviewFileContentDelegate?
    weak var dataSource: PreviewFileContentDataSource?

    private lazy var pdfUseCase: PDFPreviewUseCaseInterface = DIContainer.shared.pdfPreviewUseCase

    private(set)var currentIndex: Int = .zero
    
    var state: PreviewFileContentState = .loading {
        didSet {
            updateStateUI()
        }
    }

    private var scrollObserver: NSKeyValueObservation?
    private var numberOfFailure: Int = .zero

    deinit {
        pdfUseCase.flushUpTemporaryFile()
        removeObserver()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func setup() {
        setDefaultContentInset()
        load(at: .zero)
    }

    func setContentEdgeInset(_ inset: UIEdgeInsets) {
        webView.scrollView.contentInset = inset
    }

    func removeCurrentFile() {
        let previousIndex = currentIndex.isZero ? currentIndex : currentIndex - 1

        load(at: previousIndex)
        delegate?.previewFileContent(self, contentDidChangedAt: previousIndex)
    }

    func updateTopPaddingErrorAndPasswordContent() {
        let headerHeight = dataSource?.headerView.frame.height ?? Constants.defaultHeaderHeight
        let constant = headerHeight + Constants.defaultTopPaddingContent
        topErrorContentConstraint.constant = constant
        topPasswordContentConstraint.constant = constant
        layoutIfNeeded()
    }

    func movePasswordTopContainer(offset: CGFloat) {
        topPasswordContentConstraint.constant = offset
        performAnimation(animated: true) {
            self.layoutIfNeeded()
        }
    }
}

// MARK: - Action
extension PreviewFileContent {
    @IBAction func retryButtonDidTapped(_ sender: Any) {
        load(at: currentIndex)
    }
}
// MARK: - UIScrollViewDelegate
extension PreviewFileContent: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard state == .loaded else {
            return
        }
        delegate?.previewFileContent(self, didScroll: scrollView)
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard state == .loaded else {
            return
        }

        delegate?.previewFileContent(self, didZoom: scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.previewFileContent(self, didEndScrolling: scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.previewFileContent(self, didEndDragging: scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        delegate?.previewFileContent(self, willBeginZooming: scrollView, with: view)
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        delegate?.previewFileContent(self, didEndZooming: scrollView, with: view, atScale: scale)
    }
}

// MARK: - WKNavigationDelegate
extension PreviewFileContent: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        state = .loading
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        state = .loading
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        state = .loaded
        numberOfFailure = .zero
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        state = .error
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        state = .error
    }
}

// MARK: - DSTextFieldPasswordDelegate
extension PreviewFileContent: DSTextFieldPasswordDelegate {
    func textFieldShouldReturn(_ textField: DSTextFieldPassword) -> Bool {
        textField.endEditing(true)
        performUnlockPassword(
            password: textField.text
        )
        return true
    }

    func textFieldToolBarButtonDidTapped(_ textField: DSTextFieldPassword) {
        performUnlockPassword(
            password: textField.text
        )
    }
}

// MARK: - Private
private extension PreviewFileContent {
    func commonInit() {
        setupXib()
        setupUI()
        setupObserver()
    }

    func setupUI() {
        contentContainerView.backgroundColor = DSColor.componentSummaryBackground

        webView.backgroundColor = DSColor.componentSummaryBackground
        webView.navigationDelegate = self
        webView.scrollView.delegate = self

        webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.alwaysBounceHorizontal = false
        webView.scrollView.bounces = false

        errorContainerView.backgroundColor = DSColor.componentSummaryBackground
        errorContentView.backgroundColor = DSColor.componentPreviewFileBackground
        errorContentView.setBorder(
            width: 1,
            color: DSColor.componentPreviewFileOutline
        )

        errorContentView.set(
            cornerRadius: 8
        )

        passwordContentView.set(
            cornerRadius: 8
        )
        
        passwordIconImageView.image = DSIcons.vector56DocumentProtected.image
        passwordTitleImageView.text = PreviewFilePhrase.passwordDescriptionTitle.localize()
        passwordTitleImageView.font = DSFont.paragraphMedium
        passwordTitleImageView.textColor = DSColor.componentLightDesc
        passwordTextField.textField.returnKeyType = .done
        passwordContainerView.backgroundColor = DSColor.componentSummaryBackground
        passwordContentView.backgroundColor = DSColor.componentPreviewFileBackground
        passwordContentView.setBorder(
            width: 1,
            color: DSColor.componentPreviewFileOutline
        )

        cornerImageViews.forEach { imageView in
            imageView.image = SvgIcons.vectorCornerItem.image
        }

        emptyAndError.setup(
            style: .iconMedium(
                image: DSIcons.vector56NoDataPreviewFile.image
            ),
            title: "",
            description: PreviewFilePhrase.errorLoadingFileTitle.localize(),
            useOriginalImage: true
        )

        retryGhostButton.mediumGhostTextIconLeft(
            text: PreviewFilePhrase.errorLoadingFileRetryButton.localize(),
            icon: DSIcons.icon24OutlineRefresh.image
        )

        let previousButtonViewModel = DSClickableIconGeneralIconViewModel(
            tagId: .zero,
            state: .disable,
            theme: .light,
            size: .medium,
            imageType: .image(
                DSIcons.icon24OutlineChevronLeft.image
            ),
            isBadged: false
        )

        previousButton.setup(viewModel: previousButtonViewModel) { [weak self] _ in
            guard let self else { return }
            self.performChangePage(action: .previous)
        }

        let nextButtonViewModel = DSClickableIconGeneralIconViewModel(
            tagId: .zero,
            state: .active,
            theme: .light,
            size: .medium,
            imageType: .image(DSIcons.icon24OutlineChevronRight.image),
            isBadged: false
        )

        nextButton.setup(viewModel: nextButtonViewModel) { [weak self] _ in
            guard let self else { return }
            self.performChangePage(action: .next)
        }

        updateTopPaddingErrorAndPasswordContent()

        passwordTextField.setup(
            viewModel: DSTextFieldPasswordViewModel(
                title: PreviewFilePhrase.passwordTextFieldTitle.localize(),
                state: .default,
                isSecurePassword: true
            )
        )

        passwordTextField.delegate = self
    }

    func performChangePage(action: LoadRequestAction) {

        let index = action == .next ? currentIndex + 1 : currentIndex.isZero ? currentIndex : currentIndex - 1
        currentIndex = index
        load(at: index)

        delegate?.previewFileContent(self, contentDidChangedAt: index)
    }

    func updateButtonState() {
        let resources = dataSource?.userResources ?? []
        let isHidden = resources.count <= 1

        let previousState: DSClickableIconGeneralState = resources[safe: currentIndex - 1].isNull ? .disable : .active
        let nextState: DSClickableIconGeneralState = resources[safe: currentIndex + 1].isNull ? .disable : .active

        nextButton.isHidden = isHidden
        nextButton.componentState = nextState

        previousButton.isHidden = isHidden
        previousButton.componentState = previousState
    }

    func updateContentInsetAfterLoaded() {
        let headerHeight = self.dataSource?.headerView.frame.height ?? .zero
        let containerHeight = webView.frame.height - headerHeight
        let contentHeight = webView.scrollView.contentSize.height
        
        let shouldDisplayCenter = contentHeight < containerHeight
        let horizontalPadding = webView.scrollView.contentInset.left + webView.scrollView.contentInset.right
        let verticalPadding = (containerHeight - contentHeight) / 2

        let topPadding = shouldDisplayCenter ? verticalPadding + headerHeight : headerHeight
        let bottomPadding = shouldDisplayCenter ? verticalPadding : .zero

        let newInset = UIEdgeInsets(
            top: topPadding,
            left: horizontalPadding / 2,
            bottom: bottomPadding,
            right: horizontalPadding / 2
        )

        self.setContentEdgeInset(newInset)
    }

    func setupObserver() {
        self.scrollObserver = webView.scrollView.observe(\.contentSize, options: .new) { [weak self] _, _ in
            guard let self else { return }
            self.updateContentInsetAfterLoaded()
        }
    }

    func removeObserver() {
        scrollObserver?.invalidate()
        scrollObserver = nil
    }

    func load(at index: Int) {
        guard let resource = dataSource?.userResources[safe: index] else {
            return
        }
        updateButtonState()
        state = .loading
        
        switch resource.fileType {
        case .pdf:
            self.validatePDF(resource: resource, at: index)
        case .image:
            pdfUseCase.writePDFFromBase64(resource) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let request):
                    guard let url = request.url else {
                        state = .error
                        return
                    }
                    self.updateResourceFilePath(url, index: index)
                    self.validatePDF(resource: resource, at: index)
                case .error:
                    state = .error
                }
            }
        }
    }
    
    func validatePDF(resource: DSPreviewFileResource, at index: Int) {
        if resource.isPDF() {
            if resource.hasFile() {
                state = .loaded
                if resource.hasLocked() {
                    if let password = resource.passwordResource?.password {
                        performUnlockPassword(password: password, withByPassing: true)
                    } else {
                        self.state = .password(hasError: false)
                    }
                } else {
                    performLoad(at: index)
                }
            } else {
                pdfUseCase.retrieve(
                    resource
                ) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let url):
                            self.updateResourceFilePath(url, index: index)
                            self.updateResourcePasswordOriginalFile(url.isFileLocked, index: index)
                            self.load(at: index)
                        case .error:
                            self.state = .error
                        }
                    }
                }
            }

        } else {
            performLoad(at: index)
        }
    }

    func performUnlockPassword(password: String, withByPassing isByPass: Bool = false) {
        guard let resource = dataSource?.userResources[self.currentIndex],
              let filePath = resource.filePath else {
            return
        }
        pdfUseCase.unlockPDFPassword(
            filePath: filePath,
            password: password
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let url):
                self.updateResourceFilePath(url, index: self.currentIndex)
                self.performLoad(at: self.currentIndex)
            default:
                self.state = .password(hasError: !isByPass)
            }
        }
    }

    func performLoad(at index: Int) {

        guard let resource = dataSource?.userResources[safe: index] else {
            return
        }

        var request = resource.request
        
        if let filePath = resource.filePath {
            request = URLRequest(url: filePath)
        }
        
        setDefaultContentInset()

        webView.load(request)
        currentIndex = index
    }

    func setDefaultContentInset() {
        let resources = dataSource?.userResources ?? []
        let padding: CGFloat = resources.count > 1 ? Constants.defaultHorizontalPadding : .zero
        let headerHeight = dataSource?.headerView.frame.height ?? .zero
        let inset = UIEdgeInsets(
            top: headerHeight,
            left: padding,
            bottom: .zero,
            right: padding
        )

        setContentEdgeInset(inset)
    }

    func updateStateUI() {
        switch state {
        case .loading:
            DSLoader.showLoading(.none)
            errorStackView.isHidden = true
        case .loaded:
            contentContainerView.isHidden = false
            errorContainerView.isHidden = true
            errorStackView.isHidden = true
            passwordContainerView.isHidden = true
            passwordTextField.updateLayout(state: .default)
            passwordTextField.text.removeAll()
            DSLoader.hideLoading()
        case .error:
            DSLoader.hideLoading()
            updateTopPaddingErrorAndPasswordContent()
            contentContainerView.isHidden = true
            errorContainerView.isHidden = false
            errorStackView.isHidden = false
            passwordContainerView.isHidden = true
            updateAndValidateNumberOfFailure()
        case .password(let hasError):
            DSLoader.hideLoading()
            updateTopPaddingErrorAndPasswordContent()
            errorContainerView.isHidden = true
            contentContainerView.isHidden = true
            passwordContainerView.isHidden = false

            guard let resource = dataSource?.userResources[currentIndex] else {
                return
            }

            passwordTextField.placeholder = resource.passwordResource?.placeholderTextField ?? ""

            if hasError {
                passwordTextField.updateLayout(
                    state: .error(
                        message: resource.passwordResource?.hintError ?? ""
                    )
                )
            } else {
                passwordTextField.helperText = resource.passwordResource?.hintTextField ?? ""
                passwordTextField.updateLayout(
                    state: .default
                )
            }
        }

        delegate?.previewFileContent(self, stateDidChanged: state)
    }

    func updateAndValidateNumberOfFailure() {
        numberOfFailure += 1
        if numberOfFailure > 3 {
            delegate?.previewFileContentHasMaximumExceedFailure(self)
        }
    }

    func updateResourceFilePath(_ filePath: URL, index: Int) {
        dataSource?.updateResource(index: index, modified: { resource in
            resource.setFilePath(filePath)
            return resource
        })
    }

    func updateResourcePasswordOriginalFile(_ hasPassword: Bool, index: Int) {
        dataSource?.updateResource(index: index, modified: { resource in
            resource.setPasswordInOriginalFile(hasPassword)
            return resource
        })
    }
    
    func updateResourceFileType(_ type: DSPreviewFileType, index: Int) {
        dataSource?.updateResource(index: index, modified: { resource in
            resource.setFileType(type)
            return resource
        })
    }
}

// MARK: - Private Model
private extension PreviewFileContent {
    enum LoadRequestAction {
        case next
        case previous
    }
}
