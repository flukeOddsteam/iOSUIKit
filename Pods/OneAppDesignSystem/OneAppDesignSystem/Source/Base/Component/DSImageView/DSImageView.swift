//
//  DSImageView.swift
//  OneAppDesignSystem
//
//  Created by TTB  on 7/9/2566 BE.
//

import UIKit

public enum DSRatioImageViewConfigure {
    case imageAspectRatio(ratio: DSRatio? = .ratio1x1)
    case none
}

public enum DSImageViewType {
    case image(UIImage)
    case url(URL?)
    case none
}

protocol DSImageConfigureAppearanceInterface {
    var imageAspectRatio: CGFloat { get }
}

extension DSRatioImageViewConfigure: DSImageConfigureAppearanceInterface {
    var imageAspectRatio: CGFloat {
        switch self {
        case .imageAspectRatio(let ratio):
            switch ratio {
            case .ratio1x1:
                return DSRatio.ratio1x1.rawValue
            case .ratio3x2:
                return DSRatio.ratio3x2.rawValue
            case .ratio2x3:
                return DSRatio.ratio2x3.rawValue
            case .ratio16x9:
                return DSRatio.ratio16x9.rawValue
            case .ratio9x16:
                return DSRatio.ratio9x16.rawValue
            case .ratio32x9:
                return DSRatio.ratio32x9.rawValue
            case .ratio9x32:
                return DSRatio.ratio9x32.rawValue
            default:
                return DSRatio.ratio1x1.rawValue
            }
        default:
            return 0
        }
    }
    
    var placeHolderImage: UIImage {
        switch self {
        case .imageAspectRatio(let ratio):
            switch ratio {
            case .ratio1x1:
                return SvgIcons.placeholder1x1.image
            case .ratio3x2:
                return SvgIcons.placeholder3x2.image
            case .ratio2x3:
                return SvgIcons.placeholder2x3.image
            case .ratio16x9:
                return SvgIcons.placeholder16x9.image
            case .ratio9x16:
                return SvgIcons.placeholder9x16.image
            case .ratio32x9:
                return SvgIcons.placeholder32x9.image
            case .ratio9x32:
                return SvgIcons.placeholder9x32.image
            default:
                return SvgIcons.placeholder1x1.image
            }
        default:
            return SvgIcons.placeholder1x1.image
        }
    }
}

/**
 Custom component DSImageView for design system
 
 **Usage Example:**
 1. Create UIImageView on storyboard and assign `DSImageView` Class to the UIImageView.
 2. Binding constraint
 3. Connect UIImageView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var imageView: DSImageView!

     override func viewDidLoad() {
         super.viewDidLoad()
                    
         // Example: Show display image with placeholder and Set ratio 1x1 
         imageView.setup(sourceImage: .none,
                         ratioImage: .imageAspectRatio(ratio: .ratio1x1))
                    
         // Example: Show display image with uiimage and Set ratio 3x2
         imageView.setup(sourceImage: .image(Constants.ttbGlobalHouseImage),
                         ratioImage: .imageAspectRatio(ratio: .ratio3x2))
 
         // Example: Show display image with url and Set ratio 16x9
         let fileUrl = URL(string: "{input your string url}")
         imageView.setup(sourceImage: .url(fileUrl),
                         ratioImage: .imageAspectRatio(ratio: .ratio16x9))
 
     }

     ```
 **DSImageView by sourceImage has 3 types:**
 - none: set default image view placeholder
 - image: set image with uiimage
 - url: set image with url
 
 **DSImageView by ratioImage has 7 types:**
 - ratio1x1: set aspect ratio with 1x1 in UiImageView
 - ratio3x2: set aspect ratio with 3x2 in UiImageView
 - ratio2x3: set aspect ratio with 2x3 in UiImageView
 - ratio16x9: set aspect ratio with 16x9 in UiImageView
 - ratio9x16: set aspect ratio with 9x16 in UiImageView
 - ratio32x9: set aspect ratio with 32x9 in UiImageView
 - ratio9x32: set aspect ratio with 9x32 in UiImageView
 */
public class DSImageView: UIImageView {
    private var sourceImage: DSImageViewType = .none
    private var ratioImage: DSRatioImageViewConfigure = .imageAspectRatio(ratio: DSRatio.ratio1x1)
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupImageView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupImageView()
    }
    
    public override init(image: UIImage!) {
        super.init(image: image)
        self.setupImageView()
    }
    
    public override init(image: UIImage!, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        self.setupImageView()
    }
    
    private func setupImageView() {
        self.contentMode = .scaleAspectFill
    }
    
    public func setup(sourceImage: DSImageViewType, ratioImage: DSRatioImageViewConfigure) {
        self.sourceImage = sourceImage
        self.ratioImage = ratioImage
        self.updateImage()
    }
    
    private func updateImage() {
        switch self.sourceImage {
        case .image(let image):
            self.image = image
        case .url(let url):
            self.setImage(with: url, placeHolder: self.ratioImage.placeHolderImage)
        default:
            self.image = self.ratioImage.placeHolderImage
        }
    }
}
