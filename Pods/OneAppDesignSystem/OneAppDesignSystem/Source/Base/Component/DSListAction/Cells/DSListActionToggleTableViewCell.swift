//
//  DSListActionToggleTableViewCell.swift
//  OneApp
//
//  Created by TTB on 9/12/2565 BE.
//  Copyright © 2565 BE TTB. All rights reserved.
//

import Foundation
import UIKit

/**
 Custom component ListActionToggle for Design System
 
 ![image](/DocumentationImages/ds-list-action-toggle-cell.png)
 
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
    Configure DSListActionToggleTableViewCell for the table in the tableView(_:cellForRowAt:) method.
     ```
      public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          switch style {
          case .listActionToggle(let viewModels):
              let viewModel = viewModels[indexPath.row]
              let isShowBottomLine = indexPath.row != viewModels.count - 1
 
              // Reuse or create a cell.
              let cell: DSListActionToggleTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
 
              // Set background color when cell is selected.
              let backgroundView = UIView()
              backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
              cell.selectedBackgroundView = backgroundView
             
              /// Configure the cell.
              cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)
              cell.toggle.tagId = indexPath.row
              cell.toggle.delegate = self
              cell.selectionStyle = .none
 
              return cell
          default:
              fatalError("UITableViewCell is not implement")
          }
      }
     ```
 How to use ListActionToggleViewModel for setup DSListActionToggleTableViewCell
  Parameter | Type + Information
    --- | ---
    `text` | `String` text of DSListActionIconTableViewCell is mandatory, which cannot be nil.
    `leftIcon` | `DSIcons` icon display on the left side of text. It will be hidden if it isn't set.
    `state` | `DSToggleState` state of DSToggle component is mandatory, which cannot be nil.
    `description` | `String` text to display as a desvription (optional). if it is empty, it will be hidden.
    ```
         public struct ListActionIconViewModel {
             var text: String
             var leftIcon: DSIcons?
             var state: DSToggleState
             var description: String?
         }
    ```
 */
public final class DSListActionToggleTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var leftIconView: UIView!
    @IBOutlet weak var leftIconImageView: UIImageView!
    @IBOutlet public weak var toggle: DSToggle!
    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    /// For setup style of ListActionToggle
    ///
    /// The setup function takes a parameter actionToggleModel of type ListActionToggleModel
    ///
    /// For label variable, it's required data to present text in ListActionToggle
    ///
    /// As leftIcon is optional, default value is nil: Hide the icon
    /// If there is any icon in ListActionToggleViewModel, the icon will be displayed
    ///
    /// Set default color of the icon as componentLightDefault, referring to figma that UX designed
    public func configure(viewModel: ListActionToggleViewModel, isShowBottomLine: Bool) {
        label.text = viewModel.text
        label.font = viewModel.labelSize.titleStyle
        label.textColor = viewModel.labelSize.titleColor
        leftIconView.isHidden = viewModel.leftIcon == nil
        leftIconImageView.image = viewModel.leftIcon?.image.withRenderingMode(.alwaysTemplate)
        leftIconImageView.tintColor = DSColor.componentLightDefault
        bottomBorder.isHidden = !isShowBottomLine
        toggle.setup(state: viewModel.state)
        
        if let description = viewModel.description {
            descriptionLabel.isHidden = false
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
        }
    }
    
    public func setAccessibilityIdentifier(id: String,
                                           titleLabelId: String,
                                           toggleId: String,
                                           descriptionLabelId: String,
                                           circleViewId: String) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = titleLabelId
        self.toggle.accessibilityIdentifier = toggleId
        self.descriptionLabel.accessibilityIdentifier = descriptionLabelId
        self.toggle.setAccessibilityIdentifier(
            id: circleViewId,
            leftIconImageViewId: circleViewId,
            rightIconImageViewId: circleViewId,
            circleViewId: circleViewId
        )
    }
}

// MARK: - Private
private extension DSListActionToggleTableViewCell {
    func setupUI() {
        bottomBorder.backgroundColor = DSColor.componentDividerBackgroundSmall
        toggle.setup(state: .offActive)
        descriptionLabel.font = DSFont.paragraphSmall
        descriptionLabel.textColor = DSColor.componentLightDesc
        leftIconImageView.tintAdjustmentMode = .normal

    }
}
