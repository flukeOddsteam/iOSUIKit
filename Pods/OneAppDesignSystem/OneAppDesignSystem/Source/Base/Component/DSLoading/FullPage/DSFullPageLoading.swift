//
//  DSFullPageLoading.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/10/2565 BE.
//

import UIKit
import Lottie

private enum Constants {
    static let loadingViewTag: Int = 100011
    static let lottieFileName: String = "Loading icon"
}

/// Interface of DSFullPageLoadingProtocal
protocol DSFullPageLoadingProtocal {
    func showLoading(backgroundAppearance: FullPageLoadingBackgroundAppearance)
    func hideLoading()
}

public enum FullPageLoadingBackgroundAppearance {
    case overlay
    case none
    case white
    
    var backgroundColor: UIColor {
        switch self {
        case .overlay:
            return DSColor.otherBackgroundOverlayScreen
        case .none:
            return DSColor.otherBackgroundOverlayWhiteLoading
        case .white:
            return DSColor.dynamicColor(day: .white, night: .white)
        }
    }
}

/**
 Custom component DSFullPageLoading for Design System
 
 ![image](/DocumentationImages/ds-loading.png)
 
 **Usage Example:**
 1. Create UIView programmatically  `DSFullPageLoading` Class to the target to display loading.
 2. The  DSFullPageLoading must call ` func setup(targetView: self.view) ` and send base view to assign to parentView.
 3  The DSFullPageLoading can call showLoading with param ` backgroundAppearance `
 4. Then call ` hideLoading() ` when finish the task
 
 ```
 var loadingView: DSFullPageLoading = DSFullPageLoading()
 // setup
 loadingView.setup(targetView: self.view)
 // display with overlay
 loadingView.showLoading(backgroundAppearance: .overlay)
 // display without overlay
 loadingView.showLoading(backgroundAppearance: .none)
 // display with background
 loadingView.showLoading(backgroundAppearance: .none)
 // hide loading
 self.loadingView.hideLoading()
 ```
 
*/

public final class DSFullPageLoading: UIView, DSFullPageLoadingProtocal {
    
    /// Variable for setting UI loading
    private var loadingView: AnimationView!
    private var baseView: UIView!
    private var backgroundView: UIView!
    /// Variable for setting parent view.
    private var targetView: UIView?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func setup(targetView: UIView) {
        self.targetView = targetView
        self.frame = targetView.bounds
        
        if let viewWithTag = targetView.viewWithTag(Constants.loadingViewTag) {
            viewWithTag.removeFromSuperview()
        }
        
        targetView.addSubview(self)
    }

    public func showLoading(backgroundAppearance: FullPageLoadingBackgroundAppearance) {
        loadingView.play()
        setDisplay(true)
        baseView.backgroundColor = backgroundAppearance.backgroundColor
        targetView?.isUserInteractionEnabled = false
    }
    
    public func hideLoading() {
        loadingView.stop()
        setDisplay(false)
        targetView?.isUserInteractionEnabled = true
    }
}

// MARK: - Private
private extension DSFullPageLoading {
    func commonInit() {
        self.tag = Constants.loadingViewTag
        loadingView = AnimationView(name: Constants.lottieFileName, bundle: .dsBundle)
        loadingView.contentMode = .scaleAspectFit
        loadingView.loopMode = .loop
        loadingView.backgroundBehavior = .pauseAndRestore
        baseView = UIView.init(frame: UIScreen.main.bounds)
        baseView.backgroundColor = .backgoundOverlayScreen
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.5 - 40,
                                              y: UIScreen.main.bounds.size.height * 0.5 - 40,
                                              width: 80,
                                              height: 80))
        backgroundView.backgroundColor = .primaryHonestWhite
        backgroundView.layer.borderColor = UIColor.secondaryGrey20.cgColor
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.cornerRadius = 16
        backgroundView.dsShadowDrop()
        
        self.addSubview(baseView)
        self.addSubview(backgroundView)
        self.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 47.7),
            loadingView.widthAnchor.constraint(equalToConstant: 47.7)
        ])
        setDisplay(false)
        loadingView.play()
        
        self.isUserInteractionEnabled = false
        baseView.isUserInteractionEnabled = false
    }
    
    func setDisplay(_ isShow: Bool) {
        baseView.isHidden = !isShow
        backgroundView.isHidden = !isShow
        loadingView.isHidden = !isShow
    }
}
