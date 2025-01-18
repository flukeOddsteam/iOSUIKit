//
//  DSLoading.swift
//  OneAppDesignSystem
//
//  Created by Taratorn Deachboon on 3/3/2566 BE.
//

import Lottie

private enum Constants {
    static let lottieFileName: String = "lottie-spinner-loading"
    static let defaultSize: CGSize = CGSize(width: 48, height: 48)
}

public protocol DSLoadingInterface {
    func showLoading()
    func hideLoading()
}

/**
 Custom component DSLoading for Design System
 
 ![image](/DocumentationImages/ds-section-loading.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSLoading` Class to the UIView.
 2. Binding constraint and set width and height to 48x48px
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Call showLoading() when you need to start spinner and display
 5. Call hideLoading() when you need to stop spinner and hide loading view

*/

public final class DSLoading: UIView {
    
    private var loadingView: AnimationView!

    private var widthLoadingConstraint: NSLayoutConstraint!
    private var heightLoadingConstraint: NSLayoutConstraint!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    public func updateSize(size: CGSize) {
        widthLoadingConstraint.constant = size.width
        heightLoadingConstraint.constant = size.height
        layoutIfNeeded()
    }
}

extension DSLoading: DSLoadingInterface {
    public func showLoading() {
        loadingView.play()
        isHidden = false
    }
    
    public func hideLoading() {
        loadingView.stop()
        isHidden = true
    }
}

// MARK: - Private
private extension DSLoading {
    func commonInit() {
        setupUI()
        setupLottie()
    }
    
    func setupUI() {
        backgroundColor = .clear
    }
    
    func setupLottie() {
        loadingView = AnimationView(name: Constants.lottieFileName, bundle: .dsBundle)
        loadingView.contentMode = .scaleAspectFit
        loadingView.loopMode = .loop
        loadingView.backgroundBehavior = .pauseAndRestore
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingView)
        widthLoadingConstraint = loadingView.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.defaultSize.width)
        heightLoadingConstraint = loadingView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.defaultSize.height)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: self.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            widthLoadingConstraint,
            heightLoadingConstraint
        ])
        
    }
}
