//
//  DSPreviewFileType.swift
//  OneAppDesignSystem
//
//  Created by TTB on 15/3/2567 BE.
//

import Foundation

public enum DSPreviewFileType: Int, CaseIterable {
    case pdf
    case image

    public init(mimeType: String) {
        switch mimeType {
        case "image/jpeg", "image/png":
            self = .image
        case "application/pdf":
            self = .pdf
        default:
            self = .image
        }
    }
}

extension DSPreviewFileType {
    var fileTypeTitle: String {
        switch self {
        case .pdf:
            return "PDF"
        case .image:
            return "รูปภาพ"
        }
    }

    var isPDF: Bool {
        return self == .pdf
    }
}
