//
//  DSBullet.swift
//  OneAppDesignSystem
//
//  Created by TTB on 12/1/23.
//

import UIKit

/// Enum DSBullet style.
public enum DSBulletStyle {
    case bullet([DSBulletViewModel])
    case number([DSBulletNumberViewModel])
    case remark([DSBulletRemarkViewModel])
    case keyHighLight([DSBulletKeyHighLightViewModel])
}

/**
    Custom component DSBulletList for Design System
 
    ![image](/DocumentationImages/ds-bullet-point.png)

    **Usage Example:**
    1. Create UIView on .xib file and assign `DSBulletList` Class to the UIView.
    2. Binding constraint and don't set `height`.
    3. Connect UIView to `@IBOutlet` in text editor.
    4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var bulletPoint1: DSBulletList!
     @IBOutlet weak var bulletPoint2: DSBulletList!
     @IBOutlet weak var bulletPoint3: DSBulletList!
     @IBOutlet weak var bulletPoint4: DSBulletList!

 
     // Example: Create a ViewModel that contains the required data for DSBulletList - bullet type
     let bulletViewModels: [DSBulletViewModel] = [
         DSBulletViewModel(title: "Title",
                           titleColor: .nevy,
                           secondary: []),
         DSBulletViewModel(title: "Title",
                           secondary: [DSBulletSecondaryViewModel(title: "secondary title", isShowBullet: true)]),
         DSBulletViewModel(title: "Title",
                           secondary: [
                             DSBulletSecondaryViewModel(title: "Description", isShowBullet: false),
                             DSBulletSecondaryViewModel(title: "Secondary title", isShowBullet: true),
                             DSBulletSecondaryViewModel(title: "Description", isShowBullet: false)
                           ])
     ]
 
     // Example: Create a ViewModel that contains the required data for DSBulletList - number type
     let numberViewModels: [DSBulletNumberViewModel] = [
         DSBulletNumberViewModel(title: "Title",
                                 titleColor: .grey,
                                 secondary: [
                                     DSBulletNumberSecondaryViewModel(title: "Secondary title",
                                                                      style: .description),
                                     DSBulletNumberSecondaryViewModel(title: "Secondary title",
                                                                      style: .bullet)]),
         DSBulletNumberViewModel(title: "Title",
                                 secondary: [
                                     DSBulletNumberSecondaryViewModel(title: "Description",
                                                                      style: .description),
                                     DSBulletNumberSecondaryViewModel(title: "Secondary title",
                                                                      style: .number)])
     ]
 
     // Example: Create a ViewModel that contains the required data for DSBulletList - keyHighLight type and nevy color
     let keyHighLightViewModels: [DSBulletKeyHighLightViewModel] = [
         DSBulletKeyHighLightViewModel(title: "Title", titleColor: .nevy),
         DSBulletKeyHighLightViewModel(title: "Title", titleColor: .nevy)
     ]
 
     // Example: Create a ViewModel that contains the required data for DSBulletList - keyHighLight type and grey color
     let keyHighLightViewModels: [DSBulletKeyHighLightViewModel] = [
         DSBulletKeyHighLightViewModel(title: "Title", titleColor: .grey),
         DSBulletKeyHighLightViewModel(title: "Title", titleColor: .grey)
     ]
 
     // Example: Create a ViewModel that contains the required data for DSBulletList - remark type
     let remarkViewModels: [DSBulletRemarkViewModel] = [
         DSBulletRemarkViewModel(title: "Title", titleColor: .grey),
         DSBulletRemarkViewModel(title: "Title", titleColor: .grey)
     ]

     override func viewDidLoad() {
         super.viewDidLoad()
         bulletPoint1.setup(style: .bullet(bulletViewModels))
         bulletPoint2.setup(style: .number(numberViewModels))
         bulletPoint3.setup(style: .keyHighLight(keyHighLightViewModels))
         bulletPoint4.setup(style: .remark(remarkViewModels))
     }
     ```
 
 How to use DSBulletViewModel for DSBulletList bullet type
  Parameter | Type + Information
    --- | ---
    `title` | `String` text label of the DSBullet is mandatory, which cannot be nil.
    `titleColor` | `BulletPrimaryTextColor` text label color is mandatory. Default is .nevy
    `secondary` | `[DSBulletSecondaryViewModel]` List of DSBulletSecondaryViewModel. If it is empty, there will be no secondary item.
    ```
        public struct DSBulletViewModel {
            var title: String
            var titleColor: BulletPrimaryTextColor
            var secondary: [DSBulletSecondaryViewModel]
        }
    ```
 
 How to use DSBulletNumberViewModel for DSBulletList number type
  Parameter | Type + Information
    --- | ---
    `title` | `String` text label of the DSBullet is mandatory, which cannot be nil.
    `titleColor` | `BulletPrimaryTextColor` text label color is mandatory. Default is .nevy
    `secondary` | `[DSBulletNumberSecondaryViewModel]` List of DSBulletNumberSecondaryViewModel. If it is empty, there will be no secondary item.
    ```
        public struct DSBulletNumberViewModel {
            var title: String
            var secondary: [DSBulletNumberSecondaryViewModel]
        }
    ```
 
 How to use DSBulletKeyHighLightViewModel for DSBulletList keyHighLight type
  Parameter | Type + Information
    --- | ---
    `title` | `String` text label of the DSBullet is mandatory, which cannot be nil.
    `titleColor` | `BulletPrimaryTextColor` text label color is mandatory. Default is .nevy
    `secondary` | `[DSBulletNumberSecondaryViewModel]` List of DSBulletNumberSecondaryViewModel. If it is empty, there will be no secondary item.
    ```
        public struct DSBulletKeyHighLightViewModel {
            var title: String
        }
    ```
 
 How to use DSBulletRemarkViewModel for DSBulletList remark type
  Parameter | Type + Information
    --- | ---
    `title` | `String` text label of the DSBullet is mandatory, which cannot be nil.
    ```
        public struct DSBulletRemarkViewModel {
            var title: String
        }
    ```
 
     **DSBulletList has 4 types:**
     - bullet: Primary and Secodary Bullet Point
     - number: Number Bullet Point
     - keyHighLight: Keyhighlight Bullet Point
     - remark: Remark Bullet Point
 
     **Primary title has 2 style:**
     - nevy: BulletView/ Number/ CheckedIcon and text title colors are DSColor.componentLightDefault
     - grey: BulletView/ Number/ CheckedIcon and text title colors areDSColor.componentLightDesc
 */
public final class DSBulletList: UIView {
    
    @IBOutlet weak var stackView: UIStackView!
    
    /// For update spacing between items
    public var primarySpacing: CGFloat = 8 {
        didSet {
            stackView.spacing = primarySpacing
        }
    }

    private var style: DSBulletStyle = .bullet([])
    
    private lazy var factory: DSBulletListFactory = {
        return DSBulletListFactory()
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Setup DSBulletList
    ///
    /// Parameter for setup DSBulletList
    /// - Parameter style: style of DSBulletList (mandatory).
    /// - Parameter primarySpacing: parameter for update spacing between items (default is 8).
    /// - Parameter theme: parameter for update the appearance of the bullet list (default is .light).
    public func setup(style: DSBulletStyle, primarySpacing: CGFloat = 8) {
        self.style = style
        self.primarySpacing = primarySpacing
        relayout()
    }
    
    public func update(style: DSBulletStyle) {
        self.style = style
        relayout()
    }
}

// MARK: - Private
private extension DSBulletList {
    func commonInit() {
        setupXib()
    }
    
    func relayout() {
        stackView.removeAllSubviews()
        let views = factory.build(style: style)
        stackView.addArrangedSubviews(views)
    }
}
