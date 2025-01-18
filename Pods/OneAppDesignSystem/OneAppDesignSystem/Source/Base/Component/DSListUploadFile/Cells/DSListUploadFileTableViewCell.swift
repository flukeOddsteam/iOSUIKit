//
//  DSListUploadFileTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/22.
//

import UIKit

/// Enum type of file on DSListUploadFileTableViewCell
public enum DSListUploadFileType {
    /// image file type such as .jpg, .jpeg, .png or heic.
    case image
    /// document file type such as .txt, .xls, .doc or unknown type.
    case pdf
    /// video file type such as .mov, .mp4
    case video
}

/// For setup ListUploadFileViewModel
///
/// Parameter for setup DSListUploadFileTableViewCell
/// - Parameter text: text to display as label of DSListUploadFileTableViewCell.
/// - Parameter type: file type that display on DSListUploadFileTableViewCell.
public struct ListUploadFileViewModel {
    var text: String
    var type: DSListUploadFileType
    
    public init(text: String, type: DSListUploadFileType) {
        self.text = text
        self.type = type
    }
}

/// Delegate for DSListUploadFileTableViewCell
public protocol DSListUploadFileTableViewCellDelegate: AnyObject {
    /// on tap right ghost button, which is trash icon
    func onTapRightGhostButton(_ tagId: String)
}

/**
 Custom component DSListUploadFileTableViewCell for Design System
 
 ![image](/DocumentationImages/ds-list-upload-file-cell.png)
 
 **Usage Example:**
 1. Create UITableView on .xib file.
 2. Binding constraint.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
     ```
     @IBOutlet weak var tableView: UITableView!
 
     override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(DSListUploadFileTableViewCell.self)
        tableView.allowsSelection = false
     }
     ```
    Configure DSListUploadFileTableViewCell for the table in the tableView(_:cellForRowAt:) method.
    ```
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let viewModel = viewModels[indexPath.row]
         let isShowBottomLine = indexPath.row != viewModels.count - 1
 
         // Reuse or create a cell.
         let cell: DSListUploadFileTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
         
         // Set background color when cell is selected.
         let backgroundView = UIView()
         backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
         cell.selectedBackgroundView = backgroundView
         
         /// Configure the cell.
         cell.setup(tagId: indexPath.row, viewModel: viewModel, isShowBottomLine: isShowBottomLine)
         cell.delegate = self
         
         return cell
     }
    ```
 */
public final class DSListUploadFileTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet private weak var leftIconView: UIView!
    @IBOutlet private weak var leftIconImageView: UIImageView!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var rightGhostButton: DSGhostButton!
    @IBOutlet private weak var bottomBorder: UIView!
    
    // MARK: - Public
    /// Delegate of DSListUploadFileTableViewCell
    public weak var delegate: DSListUploadFileTableViewCellDelegate?
    
    /// Variable for set tag ID of DSListUploadFileTableViewCell 
    public var tagId: String = ""
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupGesture()
    }
    
    /// For setup DSListUploadFileTableViewCell
    ///
    /// Parameter for setup DSListUploadFileTableViewCell
    /// - Parameter tagId: tag ID of DSListUploadFileTableViewCell.
    /// - Parameter viewModel: model of ListUploadFileViewModel to display on DSListUploadFileTableViewCell.
    /// - Parameter isShowBottomLine: set to display cell separator line.
    public func setup(tagId: String, viewModel: ListUploadFileViewModel, isShowBottomLine: Bool) {
        self.tagId = tagId
        self.label.text = viewModel.text
        let type = viewModel.type
        
        switch type {
        case .image:
            self.leftIconImageView.image = DSIcons.icon24OutlinePhoto.image.withRenderingMode(.alwaysTemplate)
        case .pdf:
            self.leftIconImageView.image = DSIcons.icon24Outlinefile.image.withRenderingMode(.alwaysTemplate)
        case .video:
            self.leftIconImageView.image = DSIcons.icon24OutlineMovie.image.withRenderingMode(.alwaysTemplate)
        }
        
        self.leftIconImageView.tintColor = DSColor.componentLightDefault
        self.bottomBorder.isHidden = !isShowBottomLine
    }
    
    public func setAccessibilityIdentifier(id: String,
                                           labelId: String,
                                           rightGhostButtonId: String,
                                           rightGhostButtonLabelId: String) {
        self.accessibilityIdentifier = id
        self.label.accessibilityIdentifier = labelId
        self.rightGhostButton.setAccessibilityIdentifier(id: rightGhostButtonId, titleLabelId: rightGhostButtonLabelId)
    }
    
}

// MARK: - Action
extension DSListUploadFileTableViewCell {
    @objc func handleTap(sender: UITapGestureRecognizer) {
        delegate?.onTapRightGhostButton(tagId)
    }
}

// MARK: - Private
private extension DSListUploadFileTableViewCell {
    func setupUI() {
        self.label.font = DSFont.h3
        self.label.textColor = DSColor.componentLightDefault
        self.bottomBorder.backgroundColor = DSColor.componentDividerBackgroundSmall
        self.rightGhostButton.mediemGhostIcon(icon: DSIcons.icon24OutlineTrash.image)
        self.leftIconImageView.tintAdjustmentMode = .normal

    }
    
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.rightGhostButton.addGestureRecognizer(tapGesture)
    }
}
