//
//  DSListUploadFileView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/22.
//

import UIKit

/// Delegate for DSListUploadFileView
public protocol DSListUploadFileDelegate: AnyObject {
    /// select a row on table view of DSListUploadFileView
    func listUploadView(_ view: DSListUploadFileView, didSelectRowAt index: Int)
}

/**
 Custom component DSListUploadFileView for Design System
 
 ![image](/DocumentationImages/ds-list-upload-file.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSListUploadFileView` Class to the UIView
 2. Binding constraint and do not set `Height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Set value to properties in `viewDidLoad()` or wherever you want.
     ```
         @IBOutlet weak var listUploadFileView: DSListUploadFileView!
 
         private let dataList: [ListUploadFileViewModel] = [
             ListUploadFileViewModel(text: "FileLabel.pdf", type: .pdf),
             ListUploadFileViewModel(text: "FileLabel.png", type: .image),
             ListUploadFileViewModel(text: "FileLabel.mp4", type: .video)
         ]
         
         override func viewDidLoad() {
             super.viewDidLoad()
             listUploadFileView.delegate = self
             listUploadFileView.setup(dataList)
         }
     ```
 How to use ListUploadFileViewModel
  Parameter | Type + Information
    --- | ---
    `text` | `String` Label of file is mandatory, which cannot ne nil.
    `type` | `DSListUploadFileType`Type of file. The left icon depends on what kind of file type.
    ```
        public struct ListUploadFileViewModel {
            var text: String
            var type: DSListUploadFileType
        }
    ```
 
 **DSListUploadFileType has 3 types:**
 - image: use for image file  type such as .jpg, .jpeg, .png or heic.
 - pdf: use for document file type such as .txt, .xls, .doc or unknown type.
 - video: use for video file type such as .mov, .mp4
 */

public final class DSListUploadFileView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private var viewModels: [ListUploadFileViewModel] = []
    
    private var prefixListUploadFileCellId: String = ""
    private var prefixLabelId: String = ""
    private var prefixRightGhostButtonId: String = ""
    private var prefixRightGhostButtonLabelId: String = ""
    
    // MARK: - Public properties
    /// Delegate of DSListUploadFileView
    public weak var delegate: DSListUploadFileDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupTableView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupTableView()
    }
    
    /// For setup DSListUploadFileView
    ///
    /// Parameter for setup DSListUploadFileView
    /// - Parameter viewModel: list of ListUploadFileViewModel to display on DSListUploadFileView.
    public func setup(_ viewModels: [ListUploadFileViewModel]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           prefixListUploadFileCellId: String? = nil,
                                           prefixLabelId: String? = nil,
                                           prefixRightGhostButtonId: String? = nil,
                                           prefixRightGhostButtonLabelId: String? = nil) {
        self.accessibilityIdentifier = id
        self.prefixListUploadFileCellId = prefixListUploadFileCellId ?? ""
        self.prefixLabelId = prefixLabelId ?? ""
        self.prefixRightGhostButtonId = prefixRightGhostButtonId ?? ""
        self.prefixRightGhostButtonLabelId = prefixRightGhostButtonLabelId ?? ""
    }

}

// MARK: - UITableViewDataSource
extension DSListUploadFileView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let isShowBottomLine = indexPath.row != viewModels.count - 1
        let cell: DSListUploadFileTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        cell.setup(tagId: "\(indexPath.row)", viewModel: viewModel, isShowBottomLine: isShowBottomLine)
        cell.delegate = self
        
        let row = String(indexPath.row)
        cell.setAccessibilityIdentifier(id: prefixListUploadFileCellId.idConcatenation(row),
                                        labelId: prefixLabelId.idConcatenation(row),
                                        rightGhostButtonId: prefixRightGhostButtonId.idConcatenation(row),
                                        rightGhostButtonLabelId: prefixRightGhostButtonLabelId.idConcatenation(row))
        
        return cell
    }
}

// MARK: - DSListUploadFileTableViewCellDelegate
extension DSListUploadFileView: DSListUploadFileTableViewCellDelegate {
    public func onTapRightGhostButton(_ tagId: String) {
        print("tapped on trash icon row: \(tagId)")
    }
}

// MARK: - Private
private extension DSListUploadFileView {
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(DSListUploadFileTableViewCell.self)
        tableView.allowsSelection = false
    }
}
