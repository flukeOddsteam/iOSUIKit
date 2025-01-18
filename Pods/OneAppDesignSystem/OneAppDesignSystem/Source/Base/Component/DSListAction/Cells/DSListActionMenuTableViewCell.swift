//
//  DSListActionMenuTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 5/1/2566 BE.
//

import UIKit

/**
 Custom component ListActionMenu for Design System
 
 ![image](/DocumentationImages/ds-list-action-menu.png)
 
 **Usage Example:**
 1. Create UITableView on .xib file.
 2. Binding constraint.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var tableView: UITableView!
 
     override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DSListActionIconTableViewCell.self)

     }
     ```
    Configure DSListActionMenuTableViewCell for the table in the tableView(_:cellForRowAt:) method.
     ```
      public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          switch style {
          case .listActionMenu(let viewModels):
              let viewModel = viewModels[indexPath.row]
              let isShowBottomLine = indexPath.row != viewModels.count - 1
 
              // Reuse or create a cell.
              let cell: DSListActionMenuTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
             
              /// Configure the cell.
              cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)
 
              return cell
          default:
              fatalError("UITableViewCell is not implement")
          }
      }
     ```
 How to use ListActionMenuViewModel for setup DSListActionMenuTableViewCell
  Parameter | Type + Information
    --- | ---
    `label` | `String` text of DSListActionIconTableViewCell is mandatory, which cannot be nil.
    `iconValue` | `DSIconValue` icon displays in front of the value text (optional). It will be hidden if it isn't set. You can set icon by using DSIcons and color by using DSColor
    `value` | `String` text displays close to the right of DSListActionIconTableViewCell (optional).  It will be hidden if it isn't set.
    `labelDesc` | `String` ext to display as a desvription (optional). if it is empty, it will be hidden.
    `leftIcon` | `DSIcons` icon displays on the left side of text. It will be hidden if it isn't set.
    `rightIcon` | `DSIcons` icon displays on the right side of text. It will be hidden if it isn't set.
    `pill` | `DSCollectionPillViewModel` view model of DSPill that will display underneath label or description.
    `ratio` | `CGFloat` ratio of label and value (optional). For example, 50/50 or 70/30. Default ratio is 50/50.
    ```
         public struct ListActionMenuViewModel {
             var label: String
             var iconValue: DSIconValue?
             var value: String?
             var labelDesc: String?
             var leftIcon: DSListActionMenuImageType?
             var rightIcon: DSIcons
             var pill: DSCollectionPillViewModel?
             var ratio: CGFloat?
         }
    ```
 */
public final class DSListActionMenuTableViewCell: UITableViewCell, NibLoadable {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var valueView: UIView!
    @IBOutlet weak var valueContentView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabelView: UIView!
    @IBOutlet weak var pillContentView: DSMessageContentPillView!
    @IBOutlet weak var containerPillView: UIView!
    @IBOutlet weak var leftIconView: UIView!
    @IBOutlet weak var leftIconImageView: UIImageView!
    @IBOutlet weak var iconValueView: UIView!
    @IBOutlet weak var iconValueImageView: UIImageView!
    @IBOutlet weak var rightIconView: UIView!
    @IBOutlet weak var rightIconImageView: UIImageView!
    @IBOutlet weak var bottomBorder: UIView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    /// For setup style of ListActionMenu
    ///
    /// The setup function takes a parameter actionMenuModel of type ListActionMenuModel
    ///
    /// For label variable, it's required data to present text in ListActionMenu
    ///
    /// As leftIcon is optional, default value is nil: Hide the icon
    /// If there is any icon in ListActionIconModel, the icon will be displayed
    ///
    /// Set default color of the icon as componentLightDefault, referring to figma that UX designed
    public func configure(viewModel: ListActionMenuViewModel, isShowBottomLine: Bool) {
        label.text = viewModel.label
        
        valueContentView.isHidden = viewModel.value == nil
        value.text = viewModel.value
        
        leftIconView.isHidden = viewModel.leftIcon == nil
        
        if let iconValue = viewModel.iconValue {
            iconValueView.isHidden = false
            iconValueImageView.image = iconValue.icon.image.withRenderingMode(.alwaysTemplate)
            iconValueImageView.tintColor = iconValue.color
        }
        
        if let leftIcon = viewModel.leftIcon {
            switch leftIcon {
            case .icon(let icon):
                leftIconImageView.image = icon.image.withRenderingMode(.alwaysTemplate)
                leftIconImageView.tintColor = DSColor.componentLightDefault
            case .image(let image):
                leftIconImageView.image = image
            case .url(let url, let placeholder):
                leftIconImageView.setImage(with: url, placeHolder: placeholder ?? SvgIcons.placeholder1x1.image)
            }
        }
        
        rightIconImageView.image = viewModel.rightIcon.image.withRenderingMode(.alwaysTemplate)
        rightIconImageView.tintColor = DSColor.componentLightDefault

        setDescriptionView(labelDesc: viewModel.labelDesc)
        setCollectionPill(viewModel: viewModel.pill)
        
        if let ratio = viewModel.ratio {
            setMultiplierBetweenTwoViews(
                firstView: labelView,
                secoundView: valueView,
                multiplier: ratio
            )
        }
        
        bottomBorder.isHidden = !isShowBottomLine
    }
    
    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.backgroundColor = highlighted ? DSColor.componentLightBackgroundOnPress : .clear
    }
    
    public func setAccessibilityIdentifier(id: String,
                                           titleLabelId: String,
                                           valueLabelId: String,
                                           descriptionLabelId: String) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = titleLabelId
        self.value.accessibilityIdentifier = valueLabelId
        self.descriptionLabel.accessibilityIdentifier = descriptionLabelId
    }
}

private extension DSListActionMenuTableViewCell {
    func setupUI() {
        label.font = DSFont.h3
        label.textColor = DSColor.componentLightDefault
        value.textColor = DSColor.componentLightDefault
        value.font = DSFont.valueList
        descriptionLabel.textColor = DSColor.componentLightDesc
        descriptionLabel.font = DSFont.paragraphSmall
        bottomBorder.backgroundColor = DSColor.componentDividerBackgroundSmall
        leftIconImageView.contentMode = .scaleAspectFill
        leftIconImageView.tintAdjustmentMode = .normal
        leftIconImageView.setCircle()
        leftIconImageView.clipsToBounds = true
        iconValueView.isHidden = true
        self.selectionStyle = .none
    }
    
    func setDescriptionView(labelDesc: String?) {
        if labelDesc != nil {
            descriptionLabel.text = labelDesc
            descriptionLabelView.isHidden = false
            descriptionLabel.isHidden = false
        } else {
            descriptionLabelView.isHidden = true
            descriptionLabel.isHidden = true
        }
    }
    
    func setCollectionPill(viewModel: DSCollectionPillViewModel?) {
        if let viewModel = viewModel {
            pillContentView.setup(viewModel: getCollectionPillViewModel(by: viewModel))
            pillContentView.isHidden = false
            containerPillView.isHidden = false
        } else {
            containerPillView.isHidden = true
            pillContentView.isHidden = true
        }
    }
    
    func getCollectionPillViewModel(by data: DSCollectionPillViewModel) -> [DSMessageContentPillViewModel] {
        var contentTagViewModel: [DSMessageContentPillViewModel] = []
        
        if let pillStatus = data.status {
            let contentTagStatus: DSMessageContentPillViewModel = DSMessageContentPillViewModel(
                style: .status(pillStatus.style),
                title: pillStatus.title
            )
            contentTagViewModel.append(contentTagStatus)
        }
        
        let contentTag: [DSMessageContentPillViewModel] = data.tag?.map { DSMessageContentPillViewModel(style: .tag, title: $0) } ?? []
        contentTagViewModel.append(contentsOf: contentTag)
        
        return contentTagViewModel
    }
    
    func setMultiplierBetweenTwoViews(
        firstView: UIView,
        secoundView: UIView,
        multiplier: CGFloat
    ) {
        // Deactivate any conflicting constraints (if needed)
        // Create the width constraint with the desired multiplier
        let widthConstraint = NSLayoutConstraint(
            item: firstView,
            attribute: .width,
            relatedBy: .equal,
            toItem: secoundView,
            attribute: .width,
            multiplier: multiplier,  // Set your multiplier here
            constant: 0
        )
        
        // Activate the constraint
        widthConstraint.isActive = true
    }
}
