import UIKit

extension UIView {
    
	var xibName: String {
		return String(describing: type(of: self)).components(separatedBy: ".").first ?? ""
	}
	
	func setupXib() {
		setupXib(xibName: xibName)
	}
	
    func setupXib(xibName: String) {
		let nib = UINib(nibName: xibName, bundle: .dsBundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.layoutIfNeeded()
        self.addSubview(view)
    }
    
    static var identifier: String {
        return description()
            .components(separatedBy: ".")
            .dropFirst()
            .joined(separator: ".")
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                topPriority: UILayoutPriority? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                bottomPriority: UILayoutPriority? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0,
                centerXAnchor: NSLayoutXAxisAnchor? = nil,
                centerYAnchor: NSLayoutYAxisAnchor? = nil,
                paddingCenterXAnchor: CGFloat = 0,
                paddingCenterYAnchor: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let centerXAnchor = centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: paddingCenterXAnchor).isActive = true
        }
        
        if let centerYAnchor = centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: paddingCenterYAnchor).isActive = true
        }
    }
    
    func autosizing(forWidth width: CGFloat = UIScreen.main.bounds.width) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let containerFrame = CGRect(x: .zero, y: .zero, width: width, height: CGFloat.greatestFiniteMagnitude)
        let containerView = UIView(frame: containerFrame)
        containerView.addSubview(self)
        
        self.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        self.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        self.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0).isActive = true

        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.removeFromSuperview()
        
        self.frame = CGRect(x: .zero, y: .zero, width: self.frame.width, height: self.frame.height)
    }
    
    func sizeToFit(forWidth width: CGFloat = UIScreen.main.bounds.width) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let containerFrame = CGRect(x: .zero, y: .zero, width: width, height: CGFloat.greatestFiniteMagnitude)
        let containerView = UIView(frame: containerFrame)
        containerView.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            self.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor)
        ])

        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.removeFromSuperview()
        
        self.frame = CGRect(x: .zero, y: .zero, width: self.frame.width, height: self.frame.height)
    }
    
    func setRadius(radius: DSRadius) {
        self.layer.cornerRadius = radius.rawValue
    }
    
    func setCircle() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func setRectangle(_ adjust: CGFloat? = nil) {
        if let adjust = adjust {
            self.layer.cornerRadius = (self.frame.height / 3) + adjust
            return
        }
        self.layer.cornerRadius = self.frame.height / 3
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func setBorderAlpha(alpha: CGFloat) {
        self.alpha = alpha
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
    
    func removeSubviews() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func removeAspectRatioConstraint() {
       for constraint in self.constraints {
           if (constraint.firstItem as? UIImageView) == self,
              (constraint.secondItem as? UIImageView) == self {
               removeConstraint(constraint)
           }
       }
    }

    func set(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
    }

    func performAnimation(
        animated: Bool,
        interval: TimeInterval? = nil,
        action: (() -> Void)? = nil) {

        if animated {
            UIView.animate(
                withDuration: interval ?? .zero,
                animations: {
                    action?()
                },
                completion: nil
            )
        } else {
            action?()
        }
    }

    func setTransition(
        interval: TimeInterval = 0.3,
        type: CATransitionType,
        subtype: CATransitionSubtype
    ) {
        let transition = CATransition()
        transition.duration = interval
        transition.type = type
        transition.subtype = subtype
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.window?.layer.add(transition, forKey: kCATransition)
    }

    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
