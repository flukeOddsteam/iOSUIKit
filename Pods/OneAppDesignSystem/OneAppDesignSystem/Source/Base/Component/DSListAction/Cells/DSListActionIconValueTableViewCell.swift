//
//  DSListActionIconValueTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/11/2566 BE.
//

import UIKit

/**
 Custom component ListActionIconValueTableViewCell for Design System

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
        tableView.register(DSListActionIconValueTableViewCell.self)

     }
     ```
    Configure DSListActionIconValueTableViewCell for the table in the tableView(_:cellForRowAt:) method.
     ```
      public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          switch style {
          case .listActionIconValue(let viewModels):
             let viewModel = viewModels[indexPath.row]
             let isShowBottomLine = indexPath.row != viewModels.count - 1
 
             // Reuse or create a cell.
             let cell: DSListActionIconValueTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)

             // Set background color when cell is selected.
             let backgroundView = UIView()
             backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
             cell.selectedBackgroundView = backgroundView

             /// Configure the cell.
             cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)

             return cell
          default:
              fatalError("UITableViewCell is not implement")
          }
      }
     ```
 How to use DSListActionIconValueViewModel for setup DSListActionIconTableViewCell
  Parameter | Type + Information
    --- | ---
    `text` | `String` text of DSListActionIconValueTableViewCell is mandatory, which cannot be nil.
    `valueText` | `String` value text of DSListActionIconValueTableViewCell is mandatory, which cannot be nil.
    `secondaryText` | `String` description text  of DSListActionIconValueTableViewCell is optional, which can be nil.
    `textStyle` |  `DSListActionIconTitleStyle` text font style. Default is h3 (bold).
    `leftIcon` | `DSIcons` icon display on the left side of text. It will be hidden if it isn't set.
    `rightIcon` | `DSIcons` icon display on the right side of text. It will be hidden if it isn't set.
    `hideLeftIcon` | `IconHiddenStyle` style of hide left icon. Default is hide all which means left icon and space of left icon content view will be hidden.
    `hideRightIcon` | `IconHiddenStyle` style of hide right icon. Default is hide all which means right icon and space of right icon content view will be hidden.
    ```
         public struct DSListActionIconValueViewModel {
             var text: String
             var valueText: String
             var secondaryText: String?
             var textStyle: DSListActionIconTitleStyle
             var leftIcon: DSIcons?
             var rightIcon: DSIcons?
             var hideLeftIcon: IconHiddenStyle
             var hideRightIcon: IconHiddenStyle
             var ratio: CGFloat
         }
    ```
 */
public final class DSListActionIconValueTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var leftIconView: UIView!
    @IBOutlet weak var leftIconImageView: UIImageView!
    
    @IBOutlet weak var rightIconView: UIView!
    @IBOutlet weak var rightIconImageView: UIImageView!
    
    @IBOutlet weak var bottomBorder: UIView!
    
    @IBOutlet weak var secondaryLabelView: UIView!
    
    @IBOutlet private weak var widthRatio: NSLayoutConstraint!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    /// For setup style of ListActionIconValue
    ///
    /// The setup function takes a parameter viewModel of type DSListActionIconValueViewModel
    ///
    /// For label, valueLabel, secondaryLabel variable, it's required data to present text in DSListActionIconValueViewModel
    ///
    /// As leftIcon and rightIcon are optional, default value is nil: Hide the icon
    /// If there is any icon in ListActionIconModel, the icon will be displayed
    ///
    /// Set default color of the icon as componentLightDefault, referring to figma that UX designed
    ///
    /// Default ratio is 50 / 50, can set this in ratio parameter
    /// 
    public func configure(
        viewModel: DSListActionIconValueViewModel,
        isShowBottomLine: Bool = true
    ) {
        label.text = viewModel.text
        label.font = viewModel.textStyle == .paragraphMedium ? DSFont.paragraphMedium : DSFont.h3
        
        valueLabel.text = viewModel.valueText

        if let secondaryText = viewModel.secondaryText {
            secondaryLabelView.isHidden = false
            secondaryLabel.text = secondaryText
        }
        
        switch viewModel.hideLeftIcon {
        case .all:
            leftIconView.isHidden = viewModel.leftIcon == nil
        case .onlyIcon:
            leftIconImageView.isHidden = viewModel.leftIcon == nil
        }
        
        switch viewModel.hideRightIcon {
        case .all:
            rightIconView.isHidden = viewModel.rightIcon == nil
        case .onlyIcon:
            rightIconImageView.isHidden = viewModel.rightIcon == nil
        }
        
        leftIconImageView.image = viewModel.leftIcon?.image.withRenderingMode(.alwaysTemplate)
        rightIconImageView.image = viewModel.rightIcon?.image.withRenderingMode(.alwaysTemplate)
        bottomBorder.isHidden = !isShowBottomLine
        widthRatio = widthRatio.setMultiplier(multiplier: viewModel.ratio)
    }
    
    public func setAccessibilityIdentifier(id: String,
                                           titleLabelId: String,
                                           valueLabelId: String,
                                           descriptionLabelId: String) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = titleLabelId
        self.valueLabel.accessibilityIdentifier = valueLabelId
        self.secondaryLabel.accessibilityIdentifier = descriptionLabelId
    }
}

// MARK: - Private
private extension DSListActionIconValueTableViewCell {
    func setupUI() {
        label.textColor = DSColor.componentLightDefault
        
        valueLabel.font = DSFont.valueList
        valueLabel.textColor = DSColor.componentLightDefault
        
        secondaryLabel.font = DSFont.labelInput
        secondaryLabel.textColor = DSColor.componentLightDesc
        secondaryLabelView.isHidden = true
        
        bottomBorder.backgroundColor = DSColor.componentDividerBackgroundSmall
        
        rightIconImageView.tintColor = DSColor.componentLightDefault
        leftIconImageView.tintColor = DSColor.componentLightDefault
        rightIconImageView.tintAdjustmentMode = .normal
        leftIconImageView.tintAdjustmentMode = .normal

    }
}
