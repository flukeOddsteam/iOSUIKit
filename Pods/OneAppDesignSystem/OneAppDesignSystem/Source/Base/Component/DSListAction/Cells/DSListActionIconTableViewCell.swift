//
//  DSListActionIconTableViewCell.swift
//  OneApp
//
//  Created by TTB on 30/8/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import Foundation
import UIKit

/// Enum IconHidden style
public enum IconHiddenStyle {
    /// Completely hide everything , icon and space.
    case all
    /// Hide only icon. There are still space of icon content view.
    case onlyIcon
}

public enum DSListActionIconTitleStyle {
    case h3
    case paragraphMedium
    
    var font: UIFont? {
        switch self {
        case .paragraphMedium:
            return DSFont.paragraphMedium
        case .h3:
            return DSFont.h3
        }
    }
}

/**
 Custom component ListActionIcon for Design System
 
 ![image](/DocumentationImages/ds-list-action-icon-cell.png)

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
    Configure DSListActionIconTableViewCell for the table in the tableView(_:cellForRowAt:) method.
     ```
      public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          switch style {
          case .listActionIcons(let viewModels):
              let viewModel = viewModels[indexPath.row]
              let isShowBottomLine = indexPath.row != viewModels.count - 1
 
              // Reuse or create a cell.
              let cell: DSListActionIconTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
             
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
 How to use ListActionIconViewModel for setup DSListActionIconTableViewCell
  Parameter | Type + Information
    --- | ---
    `text` | `String` text of DSListActionIconTableViewCell is mandatory, which cannot be nil.
    `textStyle` |  `DSListActionIconTitleStyle` text font style. Default is h3 (bold).
    `leftIcon` | `DSIcons` icon display on the left side of text. It will be hidden if it isn't set.
    `rightIcon` | `DSIcons` icon display on the right side of text. It will be hidden if it isn't set.
    `hideLeftIcon` | `IconHiddenStyle` style of hide left icon. Default is hide all which means left icon and space of left icon content view will be hidden.
    `hideRightIcon` | `IconHiddenStyle` style of hide right icon. Default is hide all which means right icon and space of right icon content view will be hidden.
    ```
         public struct ListActionIconViewModel {
             var text: String
             var textStyle: DSListActionIconTitleStyle
             var leftIcon: DSIcons?
             var rightIcon: DSIcons?
             var hideLeftIcon: IconHiddenStyle
             var hideRightIcon: IconHiddenStyle
         }
    ```
 */
public final class DSListActionIconTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var leftIconView: UIView!
    @IBOutlet weak var leftIconImageView: UIImageView!
    
    @IBOutlet weak var rightIconView: UIView!
    @IBOutlet weak var rightIconImageView: UIImageView!
    
    @IBOutlet weak var bottomBorder: UIView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    /// For setup style of ListActionIcon
    ///
    /// The setup function takes a parameter actionIconModel of type ListActionIconModel
    ///
    /// For label variable, it's required data to present text in ListActionIcon
    ///
    /// As leftIcon and rightIcon are optional, default value is nil: Hide the icon
    /// If there is any icon in ListActionIconModel, the icon will be displayed
    ///
    /// Set default color of the icon as componentLightDefault, referring to figma that UX designed
    public func configure(viewModel: ListActionIconViewModel, isShowBottomLine: Bool) {
        label.text = viewModel.text
        label.font = viewModel.textStyle == .paragraphMedium ? DSFont.paragraphMedium : DSFont.h3
        
        let hasLeftIcon = viewModel.leftIcon.isNotNull
        let hasRightIcon = viewModel.rightIcon.isNotNull
        
        switch viewModel.hideLeftIcon {
        case .all:
            leftIconView.isHidden = !hasLeftIcon
            leftIconImageView.isHidden = !hasLeftIcon
        case .onlyIcon:
            leftIconView.isHidden = false
            leftIconImageView.isHidden = !hasLeftIcon
        }
        
        switch viewModel.hideRightIcon {
        case .all:
            rightIconView.isHidden = !hasRightIcon
            rightIconImageView.isHidden = !hasRightIcon
        case .onlyIcon:
            rightIconView.isHidden = false
            rightIconImageView.isHidden = !hasRightIcon
        }
        
        leftIconImageView.image = viewModel.leftIcon?.image.withRenderingMode(.alwaysTemplate)
        
        rightIconImageView.image = viewModel.rightIcon?.image.withRenderingMode(.alwaysTemplate)
        
        bottomBorder.isHidden = !isShowBottomLine
    }
    
    public func setAccessibilityIdentifier(id: String, titleLableId: String) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = titleLableId
    }
}

// MARK: - Private
private extension DSListActionIconTableViewCell {
    func setupUI() {
        label.textColor = DSColor.componentLightDefault
        bottomBorder.backgroundColor = DSColor.componentDividerBackgroundSmall
        rightIconImageView.tintColor = DSColor.componentLightDefault
        leftIconImageView.tintColor = DSColor.componentLightDefault

        rightIconImageView.tintAdjustmentMode = .normal
        leftIconImageView.tintAdjustmentMode = .normal

    }
}
