//
//  DSSkeletonLoading.swift
//  OneAppDesignSystem
//
//  Created by TTB on 4/1/2566 BE.
//

import UIKit

public protocol DSSkeletonViewAnimationInterface: AnyObject {
    func startAnimation()
    func stopAnimation()
}

/**
     Custom component DSSkeletonLoading for Design System

     ![image](/DocumentationImages/ds-skeleton-loading.png)

     **Usage Example:**
     1. Create UIView on .xib file and assign `DSSkeletonLoading` Class to the UIView.
     2. Set autolayout constraints
     3. Connect UIView to `@IBOutlet` in text editor.
     4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
         @IBOutlet weak var loadingView: DSSkeletonLoading!
     ```
     5. Set setup function
     ```
         loadingView.setup(style: .rounded)
     ```
     6. Conform protocol `DSSkeletonLoadingInterface` on your UIViewController or UIView
     7. Add your view after set shape into `skeletonViews`
     ```
         skeletonViews.append(loadingView)
     ```
     8. Set `startSkeleton()` for display shimmer animation
 
 **Enums:**

      **DSSkeletonLoadingTheme**
      - `light`: Applies a light theme for the skeleton loader. Suitable for views with a light background.
      - `dark`: Applies a dark theme for the skeleton loader. Suitable for views with a dark background.

      **DSSkeletonLoadingShapeStyle**
      This enum defines the shape style of the skeleton loader:
      - `circle`: Renders the skeleton in a circular shape.
      - `rounded`: Renders the skeleton with rounded corners with radius 8 px.
      - `rectangle`: Renders the skeleton as a standard rectangle.
 */
public final class DSSkeletonLoading: UIView {

    private var style: DSSkeletonLoadingShapeStyle = .circle
    private var theme: DSSkeletonLoadingTheme = .light
    private var gradient: CAGradientLayer?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public func setup(style: DSSkeletonLoadingShapeStyle, theme: DSSkeletonLoadingTheme = .light) {
        self.style = style
        self.theme = theme
        updateShape()
        updateTheme()
    }
}

extension DSSkeletonLoading: DSSkeletonViewAnimationInterface {
    public func startAnimation() {
        setShimmer()
    }

    public func stopAnimation() {
        removeShimmer()
    }
}

// MARK: - Private
private extension DSSkeletonLoading {

    func setupUI() {
        backgroundColor = .clear
    }

    func updateShape() {
        switch style {
        case .circle:
            setCircle()
        case .rounded:
            setRadius(radius: .radius8px)
        case .rectangle:
            setRadius(radius: .radius0px)
        }
    }
    
    func updateTheme() {
        if gradient != nil {
            removeShimmer()
            setShimmer()
        }
    }
    
    func setShimmer() {
        removeShimmer()
        let alpha = DSColor.componentLightBackgroundOnPress
        let light = DSColor.otherBackgroundSkeleton
        let colors = [alpha, light, alpha].map { $0.cgColor }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.opacity = theme == .light ? 1.0 : 0.4

        gradientLayer.frame = CGRect(
            x: -self.bounds.size.width,
            y: .zero,
            width: 3 * bounds.size.width,
            height: bounds.size.height
        )
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.4, 0.5, 0.6]

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false

        gradientLayer.add(animation, forKey: animation.keyPath)

        self.layer.masksToBounds = true
        self.layer.addSublayer(gradientLayer)

        gradient = gradientLayer
    }

    func removeShimmer() {
        guard let index = layer.sublayers?.firstIndex(where: { layer in
            return layer == gradient
        }) else {
            return
        }
        
        layer.sublayers?.remove(at: index)
        gradient = nil
    }
}
