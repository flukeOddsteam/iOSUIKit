//
//  DSBottomSheetExternal.swift
//  OneAppDesignSystem
//
//  Created by TTB on 23/12/22.
//

import UIKit
import WebKit

private enum Constants {
    static let headerViewHeight: CGFloat = 56
}

protocol BottomSheetExternalDelegate: AnyObject {
    func bottomSheetIsDismiss()
}

final class DSBottomSheetExternal: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: DSClickableIconBadge!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: DSClickableIconBadge!
    /// Delegate of DSBottomSheetExternal
    weak var delegate: BottomSheetExternalDelegate?
    
    var titleText: String = ""
    
    var urlString: String? = ""
    
    var scrollEnable: Bool = true

    var visibleBackButton: Bool = true

    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        let nibname = String(describing: DSBottomSheetExternal.self)
        super.init(nibName: nibname, bundle: .dsBundle)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func setAccessibilityIdentifier(titleLabelId: String,
                                    closeButtonId: String,
                                    webViewId: String) {
        self.titleLabel.accessibilityIdentifier = titleLabelId
        self.closeButton.setAccessibilityIdentifier(id: closeButtonId)
        self.webView.accessibilityIdentifier = webViewId
    }
}

// MARK: - Action
extension DSBottomSheetExternal {
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func backButtonDidTapped(_ sender: Any) {
        webView.goBack()
    }
}

// MARK: - WKNavigationDelegate
extension DSBottomSheetExternal: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        updateVisibleBackButton()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateVisibleBackButton()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        updateVisibleBackButton()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        updateVisibleBackButton()
    }
}

// MARK: - UIScrollViewDelegate
extension DSBottomSheetExternal: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isHidden = webView.scrollView.contentOffset.y <= 0
        headerView.dsShadowDrop(isHidden: isHidden, style: .bottom)
    }
}

// MARK: - PanModalPresentable
extension DSBottomSheetExternal: PanModalPresentable {
    func panModalWillDismiss() {
        delegate?.bottomSheetIsDismiss()
    }
    
    var cornerRadius: CGFloat {
        return DSRadius.radius24px.rawValue
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var isUserInteractionEnabled: Bool {
        return true
    }
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .maxHeight
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    
    var anchorModalToLongForm: Bool {
        return true
    }
    
    var panModalBackgroundColor: UIColor {
        return DSColor.otherBackgroundOverlayScreen
    }
    
    var topOffset: CGFloat {
        return UIApplication.getStatusBarFrame().height + 16
    }
    
    var allowsDragToDismiss: Bool {
        return true
    }
    
    var allowsTapToDismiss: Bool {
        return true
    }
}

// MARK: - Private
private extension DSBottomSheetExternal {
    func commonInit() {
        setupUI()
        loadWebView()
        updateVisibleBackButton()
    }
    
    func setupUI() {
        titleLabel.text = self.titleText
        titleLabel.font = DSFont.h3
        titleLabel.textColor = DSColor.componentLightDefault
        closeButton.setup(style: .normal, image: SvgIcons.icon24Close.image)
        webView.scrollView.pinchGestureRecognizer?.isEnabled = self.scrollEnable
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.delegate = self
        webView.navigationDelegate = self
        
        backButton.setup(style: .normal, image: DSIcons.icon24ChevronLeft.image)
    }
    
    func loadWebView() {
        if let urlValue = self.urlString, let url = NSURL(string: urlValue) {
            let urlRequest = NSURLRequest(url: url as URL)
            self.webView.load(urlRequest as URLRequest)
        }
    }

    func updateVisibleBackButton() {
        backButton.isHidden = visibleBackButton ? !webView.canGoBack : true
    }
}
