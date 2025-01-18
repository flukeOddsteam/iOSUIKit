//
//  DSPreviewFileResource.swift
//  OneAppDesignSystem
//
//  Created by TTB on 12/3/2567 BE.
//

import PDFKit

public struct DSPreviewFileResource {
    public var id: String
    public var request: URLRequest
    public var fileName: String
    public var fileType: DSPreviewFileType
    public var extensionFile: String?

    public var isShowSaveFileDialog: Bool
    public var passwordResource: PasswordResource?

    internal var filePath: URL?
    internal var hasPasswordInOriginalFile: Bool = false

    public init(
        id: String = "",
        request: URLRequest,
        fileName: String,
        fileType: DSPreviewFileType,
        isShowSaveFileDialog: Bool = false,
        extensionFile: String? = nil,
        passwordResource: PasswordResource? = nil
    ) {
        self.id = id
        self.request = request
        self.fileName = fileName
        self.fileType = fileType
        self.isShowSaveFileDialog = isShowSaveFileDialog
        self.extensionFile = extensionFile
        self.passwordResource = passwordResource
    }

    mutating func setFileName(_ fileName: String) {
        self.fileName = fileName
    }

    mutating func setFilePath(_ url: URL) {
        self.filePath = url
    }
    
    mutating func setFileType(_ type: DSPreviewFileType) {
        self.fileType = type
    }

    mutating func setPasswordInOriginalFile(_ hasPassword: Bool) {
        self.hasPasswordInOriginalFile = hasPassword
    }

    func hasLocked() -> Bool {
        guard let filePath else {
            return false
        }

        return filePath.isFileLocked
    }

    func hasFile() -> Bool {
        return filePath.isNotNull
    }

    func isPDF() -> Bool {
        return fileType == .pdf
    }
    
    func isImage() -> Bool {
        return fileType == .image
    }
}
