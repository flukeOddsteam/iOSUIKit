//
//  DSLazyLoading.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/3/2566 BE.
//

import Lottie

private enum Constants {
    static let lottieFileName: String = "lottie-spinner-loading"
}

public protocol DSLazyLoadingInterface {
    func showLoading()
    func hideLoading()
}

/**
    Custom component DSLazyLoading for Design System
 
    ![image](/DocumentationImages/ds-lazy-loading.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSLazyLoading` Class to the UIView.
    2. Binding constraint and do not set height and width
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
    @IBOutlet weak var lazyLoadingView: DSLazyLoading!
    override func viewDidLoad() {
        super.viewDidLoad()
        lazyLoadingView.setup(style: .dark, title: "Loading")
        lazyLoadingDarkView.showLoading()
    }
     ```
    5. Call showLoading() when you want to start spinner and display loading
    6. Call hideLoading() when you want to stop spinner and hide loading
     **DSLazyLoading has 2 style:**
     - light
     - dark
 */

public final class DSLazyLoading: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animationContainerView: UIView!
    
    private var animationView: AnimationView!
    
    /// text to display on DSLazyLoading
    public var titleText: String = "Loading" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    private var style: DSLazyLoadingStyle = .dark {
        didSet {
            updateStyle()
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
    
    /// Setup DSLazyLoading
    ///
    /// Parameter for setup DSLazyLoading
    /// - Parameter style: loading style on DSLazyLoading. There are 2 styles such as light and dark.
    /// - Parameter title: text to display on DSLazyLoading.
    public func setup(style: DSLazyLoadingStyle,
                      title: String) {
        self.style = style
        self.titleText = title
    }
}

// MARK: - DSLazyLoadingInterface
extension DSLazyLoading: DSLazyLoadingInterface {
    public func showLoading() {
        animationView.play()
        isHidden = false
    }
    
    public func hideLoading() {
        animationView.stop()
        isHidden = true
    }
}

// MARK: - Private
private extension DSLazyLoading {
    func commonInit() {
        setupXib()
        setupUI()
        setupLottie()
        updateStyle()
    }
    
    func setupUI() {
        titleLabel.font = DSFont.labelList
        containerView.setRadius(radius: .radius16px)
    }
    
    func setupLottie() {
        animationView = AnimationView(name: Constants.lottieFileName, bundle: .dsBundle)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        
        animationContainerView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: animationContainerView.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: animationContainerView.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: animationContainerView.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: animationContainerView.bottomAnchor)
        ])
    }
    
    func updateStyle() {
        containerView.backgroundColor = style.backgroundColor
        titleLabel.textColor = style.textColor
    }
}
