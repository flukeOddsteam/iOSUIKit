//
//  DSExternalLinkViewController.swift
//  OneAppDesignSystem
//
//  Created by TTB on 16/4/2566 BE.
//

import UIKit
import WebKit

private enum Constants {
    static let defaultAnimationDuration: TimeInterval = 0.2
}

public protocol DSExternalLinkDelegate: AnyObject {
    func externalLink(_ webView: WKWebView, didCommit navigation: WKNavigation)
    func externalLink(_ webView: WKWebView, didFinish navigation: WKNavigation)
    func externalLink(_ webView: WKWebView, didFail navigation: WKNavigation, withError error: Error)
    func externalLink(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation, withError error: Error)

    func externalLinkPageDidDismiss()
    func externalLinkPageDidTapSnackBarButton()
}

final class DSExternalLinkViewController: UIViewController {

    @IBOutlet weak var navigationBarView: DSNavBar!
    @IBOutlet weak var snackBarView: DSSnacksBar!
    
    @IBOutlet weak var bottomSnackBarViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var webView: WKWebView!
    
    var router: DSExternalLinkRouterProtocol!
    
    // MARK: - DataStore
    var navigationBarTitle: String!
    var request: URLRequest!
    var snackBarConfiguration: DSSnacksBarConfiguration!
    
    weak var delegate: DSExternalLinkDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebView()
    }
}

extension DSExternalLinkViewController: DSNavBarDelegate {
    func navBarCloseButtonDidTapped(_ view: DSNavBar) {
        router.dismiss(completion: { [weak self] in
            self?.delegate?.externalLinkPageDidDismiss()
        })
    }
}

// MARK: - WKNavigationDelegate
extension DSExternalLinkViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        delegate?.externalLink(webView, didCommit: navigation)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        delegate?.externalLink(webView, didFinish: navigation)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        delegate?.externalLink(webView, didFail: navigation, withError: error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        delegate?.externalLink(webView, didFailProvisionalNavigation: navigation, withError: error)
    }
}

// MARK: - WKUIDelegate
extension DSExternalLinkViewController: WKUIDelegate { }

// MARK: - DSSnacksBarDelegate
extension DSExternalLinkViewController: DSSnacksBarDelegate {
    func pressedOnSnacksBarButton() {
        dismissSnackBar()
        delegate?.externalLinkPageDidTapSnackBarButton()
    }
}

// MARK: - Private
private extension DSExternalLinkViewController {
    func setupUI() {
        navigationBarView.setup(
            title: navigationBarTitle,
            style: .closeButtonOnly,
            theme: .light,
            isAchorWithSuperView: false
        )
        navigationBarView.delegate = self
        navigationBarView.setupScrollView(webView.scrollView)

        snackBarView.setup(configuration: snackBarConfiguration)
        snackBarView.delegate = self

        webView.navigationDelegate = self
        webView.uiDelegate = self

        view.backgroundColor = DSColor.componentLightBackground
    }
    
    func loadWebView() {
        webView.load(request)
    }
    
    func dismissSnackBar() {
        let bottomSafeAreaInsets = UIApplication.getWindow()?.safeAreaInsets.bottom ?? .zero
        let constant = snackBarView.frame.height + bottomSafeAreaInsets
        bottomSnackBarViewConstraint.constant = -constant
        UIView.animate(withDuration: Constants.defaultAnimationDuration) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
