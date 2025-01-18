//
//  FilePreviewHeaderSection.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/2/2567 BE.
//

import UIKit

final class PreviewFileHeaderSection: UIView {

    @IBOutlet weak var numberOfFileLabel: UILabel!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var editButton: DSGhostButton!
    @IBOutlet weak var deleteButton: DSGhostButton!
    @IBOutlet weak var editContainer: UIView!
    @IBOutlet weak var deleteContainer: UIView!

    weak var delegate: PreviewFileHeaderSectionDelegate?

    var fileName: String? {
        didSet {
            fileNameLabel.text = fileName
        }
    }

    var numberOfFile: String? {
        didSet {
            numberOfFileLabel.text = numberOfFile
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func setupVisibleButton(
        isDisplayEdit: Bool,
        isDisplayDelete: Bool
    ) {
        self.editContainer.isHidden = !isDisplayEdit
        self.deleteContainer.isHidden = !isDisplayDelete
    }
}

// MARK: - Action
extension PreviewFileHeaderSection {
    @IBAction func editButtonDidTapped(_ sender: Any) {
        delegate?.previewFileHeaderEditButtonDidTapped(self)
    }

    @IBAction func deleteButtonDidTapped(_ sender: Any) {
        delegate?.previewFileHeaderDeleteButtonDidTapped(self)
    }
}

// MARK: - Private
private extension PreviewFileHeaderSection {
    func commonInit() {
        setupXib()
        setupUI()
    }

    func setupUI() {
        numberOfFileLabel.textColor = DSColor.pageLightDesc
        numberOfFileLabel.font = DSFont.labelList

        fileNameLabel.font = DSFont.h3
        fileNameLabel.textColor = DSColor.pageLightTextDefault

        editButton.mediemGhostIcon(icon: DSIcons.icon24OutlineEdit.image)
        deleteButton.mediemGhostIcon(icon: DSIcons.icon24OutlineTrash.image)

        setupVisibleButton(
            isDisplayEdit: false,
            isDisplayDelete: false
        )
    }
}
