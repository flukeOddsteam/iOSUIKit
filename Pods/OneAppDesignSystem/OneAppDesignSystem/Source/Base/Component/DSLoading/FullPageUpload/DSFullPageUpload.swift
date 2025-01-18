//
//  DSFullPageUpload.swift
//  OneAppDesignSystem
//
//  Created by TTB on 15/7/2567 BE.
//

import Lottie

/// Protocol to handle actions within DSFullPageUpload
public protocol DSFullPageUploadDelegate: AnyObject {
    /// Called when the ghost button is tapped
    func fullPageUploadDidTapGhostButton(_ viewController: DSFullPageUpload)
    /// Called when the upload process ends
    func fullPageUploadDidEnd(_ viewController: DSFullPageUpload)
}

public extension DSFullPageUploadDelegate {
    func fullPageUploadDidTapGhostButton(_ viewController: DSFullPageUpload) {}
    func fullPageUploadDidEnd(_ viewController: DSFullPageUpload) {}
}

/**
 Custom component DSFullPageUpload for Design System
 
 ![image](/DocumentationImages/ds-loading-upload.png)
 
 **Usage Example:**
 1. Create UIView programmatically `DSFullPageUpload` Class to the target to display loading.
 2. The DSFullPageUpload must call `func setup(targetView: self.view)` and send base view to assign to parentView.
 3. The DSFullPageUpload can call setupLayout with param `state` and `style` to display loading fullpage upload.
 4. The DSFullPageUpload can call updateLayout with param `state` to change state loading fullpage upload.
 5. The DSFullPageUpload can call `hideLoading()` to hide loading fullpage upload.
 
 DSFullPageUpload has 2 styles:
 - `overlay`: This style displays the loading view with an overlay background
 - `none`: This style displays the loading view without an overlay background

 DSFullPageUpload has 2 states:
 - `loading`: This state indicates that the upload process is ongoing. The loading animation will be displayed.
 - `success`: This state indicates that the upload process has completed successfully. A success animation will be displayed. Once the success animation completes, the view will automatically call `hideLoading()` to hide the loading view after 500 milliseconds.
 
 DSFullPageUpload supports 2 languages:
 - `th`: Thai language support for localized text.
 - `en`: English language support for localized text.
 
 ```
 var loadingViewUpload: DSFullPageUpload = DSFullPageUpload()
 
 // setup
 loadingViewUpload.setup(targetView: self.view)
 
 // display loading with overlay
 loadingViewUpload.setupLayout(state: .loading, style: .overlay)
 
 // display loading with overlay and hide cancel button
 loadingViewUpload.setupLayout(state: .loading, style: .overlay, isHideCancelButton: true)
 
 // display loading without overlay
 loadingViewUpload.setupLayout(state: .loading, style: .none)
 
 // display loading without overlay and hide cancel button
 loadingViewUpload.setupLayout(state: .loading, style: .none, isHideCancelButton: true)
 
 // display success with overlay
 loadingViewUpload.setupLayout(state: .success, style: .overlay)
 
 // display success with overlay and hide cancel button
 loadingViewUpload.setupLayout(state: .success, style: .overlay, isHideCancelButton: true)
 
 // display success without overlay
 loadingViewUpload.setupLayout(state: .success, style: .none)
 
 // display success without overlay and hide cancel button
 loadingViewUpload.setupLayout(state: .success, style: .none, isHideCancelButton: true)
 
 // display with Thai language
 DSLanguageManager.shared.setLanguage(code: "th")
 loadingViewUpload.setupLayout(state: .loading, style: .none)
 
 // display with Thai language and hide cancel button
 DSLanguageManager.shared.setLanguage(code: "th")
 loadingViewUpload.setupLayout(state: .loading, style: .none, isHideCancelButton: true)
 
 // display with English language
 DSLanguageManager.shared.setLanguage(code: "en")
 loadingViewUpload.setupLayout(state: .loading, style: .none)
 
 // display with English language and hide cancel button
 DSLanguageManager.shared.setLanguage(code: "en")
 loadingViewUpload.setupLayout(state: .loading, style: .none, isHideCancelButton: true)
 
 // update state to loading
 loadingViewUpload.updateLayout(state: .loading)
 
 // update state to success
 loadingViewUpload.updateLayout(state: .success)
 
 // update state with time delay
 var workItem: DispatchWorkItem?
 workItem = DispatchWorkItem { [weak self] in
     guard let self else { return }
     self.loadingViewUpload.updateLayout(state: .success)
 }
 DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: workItem!)
 
 // manual hide the loading view
 self.loadingView.hideLoading()
 ```
*/

public final class DSFullPageUpload: UIView {
    @IBOutlet weak var animationContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clickAbleGhostButton: DSGhostButton!
    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    private var animationView: AnimationView!
    private var targetView: UIView?
    private var baseView: UIView!
    
    /// Delegate of DSFullPageUpload
    public weak var delegate: DSFullPageUploadDelegate?
    
    private var state: DSFullPageUploadState = .loading
    
    private var isHideCancelButton: Bool = false
    
    /// Setup DSFullPageUpload
    ///
    /// This method sets up the DSFullPageUpload view by adding it to the target view.
    /// - Parameter targetView: The view to which DSFullPageUpload will be added
    public func setup(targetView: UIView) {
        self.targetView = targetView
        self.frame = targetView.bounds
        targetView.addSubview(self)
    }
    
    /// Setup layout for DSFullPageUpload with a specific state and style
    ///
    /// This method configures the state and style of loading
    /// - Parameters:
    ///   - state: The state of DSFullPageUpload
    ///   - style: The style to be applied to DSFullPageUpload
    ///   - isHideCancelButton: The isHideCancelButton use for Hide cencel button. default is `false`
    public func setupLayout(
        state: DSFullPageUploadState,
        style: DSFullPageUploadStyle,
        isHideCancelButton: Bool = false
    ) {
        self.state = state
        self.isHideCancelButton = isHideCancelButton
        updateState()
        showLoading(style: style)
    }
    
    /// Update layout of DSFullPageUpload based on the provided state
    ///
    /// This method updates the state of DSFullPageUpload and triggers the necessary animations.
    /// - Parameter state: The state to which DSFullPageUpload should be updated
    public func updateLayout(state: DSFullPageUploadState) {
        setAlpha(alpha: 0, duration: 0.1)
        self.state = state
        updateState()
        animationContainerView.isHidden = false
        layoutIfNeeded()
        animateAlpha(view: animationContainerView, to: 1, duration: 0.4, after: 0.01)
        animateAlpha(view: titleLabel, to: 1, duration: 0.4, after: 0.2)
        animateAlpha(view: clickAbleGhostButton, to: 1, duration: 0.4, after: 0.2)
        animationView.play { [weak self] finished in
            guard let self = self else { return }
            if finished {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.hideLoading()
                    self.delegate?.fullPageUploadDidEnd(self)
                }
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

extension DSFullPageUpload {
    /// Show loading animation with a specific style
    ///
    /// This method plays the loading animation and makes the view visible.
    /// - Parameter style: The style to be applied during loading
    public func showLoading(style: DSFullPageUploadStyle) {
        animationView.play()
        setDisplay(true)
        baseView.backgroundColor = style.backgroundColor
        self.isUserInteractionEnabled = true
    }
    
    /// Hide loading animation
    ///
    /// This method stops the loading animation and makes the view invisible.
    public func hideLoading() {
        animationView.stop()
        setDisplay(false)
        self.isUserInteractionEnabled = false
    }
}

// MARK: - Action
extension DSFullPageUpload {
    @IBAction func ghostButtonDidTapped(_ sender: Any) {
        hideLoading()
        self.delegate?.fullPageUploadDidTapGhostButton(self)
    }
}

// MARK: - Private
private extension DSFullPageUpload {
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.font = DSFont.paragraphSmall
        titleLabel.textColor = DSColor.componentLightDesc
        
        containerView.backgroundColor = DSColor.componentLightBackground
        containerView.setRadius(radius: .radius24px)
        containerView.setBorder(width: 1, color: DSColor.componentLightOutlineSecondary)
        containerView.dsShadowDrop(style: .bottom)
        
        baseView = UIView(frame: UIScreen.main.bounds)
        baseView.backgroundColor = .backgoundOverlayScreen
        
        addSubview(baseView)
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 180),
            containerView.heightAnchor.constraint(equalToConstant: 160),
            containerView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor)
        ])
        
        setDisplay(false)
        self.isUserInteractionEnabled = false
        baseView.isUserInteractionEnabled = false
    }
    
    func setupLottie(named animationName: String, mode: LottieLoopMode, animationSpeed: CGFloat = 1.0) {
        animationView?.removeFromSuperview()
        animationView = AnimationView(name: animationName, bundle: .dsBundle)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = mode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.animationSpeed = animationSpeed
        
        animationContainerView.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: animationContainerView.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: animationContainerView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: animationContainerView.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: animationContainerView.bottomAnchor)
        ])
    }
    
    func updateState() {
        setupLottie(named: state.lottieFileName, mode: state.loopMode, animationSpeed: state.animationSpeed)
        titleLabel.text = state.titleText
        validateHideCancelButton()
    }
    
    func setDisplay(_ isShow: Bool) {
        baseView.isHidden = !isShow
        containerView.isHidden = !isShow
        animationContainerView.isHidden = !isShow
    }
    
    func animateAlpha(view: UIView, to alpha: CGFloat, duration: TimeInterval, after delay: TimeInterval = 0) {
        UIView.animate(withDuration: duration, delay: delay, animations: {
            view.alpha = alpha
        })
    }
    
    func setAlpha(alpha: CGFloat, duration: CGFloat) {
        animateAlpha(view: animationContainerView, to: alpha, duration: duration)
        animateAlpha(view: titleLabel, to: alpha, duration: duration)
        animateAlpha(view: clickAbleGhostButton, to: alpha, duration: duration)
    }
    
    func validateHideCancelButton() {
        if !isHideCancelButton {
            clickAbleGhostButton.isHidden = state.isGhostButtonHidden
            clickAbleGhostButton.smallGhostText(text: DSFullPageUploadPhrase.cancelButton.localize())
            setMarginUploadView()
        }
    }
    
    func setMarginUploadView() {
        topMargin.constant = state.topMargin
        bottomMargin.constant = state.bottomMargin
        layoutIfNeeded()
    }
}
