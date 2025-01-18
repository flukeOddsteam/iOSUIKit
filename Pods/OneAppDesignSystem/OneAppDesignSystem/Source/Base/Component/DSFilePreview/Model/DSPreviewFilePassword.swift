//
//  DSPreviewFilePassword.swift
//  OneAppDesignSystem
//
//  Created by TTB on 3/6/2567 BE.
//

import Foundation

public extension DSPreviewFileResource {
    struct PasswordResource {
        public var password: String?
        public var hintTextField: String
        public var hintError: String
        public var hintBottomSheetDescription: String
        public var placeholderTextField: String

        public init(
            password: String? = nil,
            hintTextField: String,
            hintError: String,
            hintBottomSheetDescription: String,
            placeholderTextField: String
        ) {
            self.password = password
            self.hintTextField = hintTextField
            self.hintError = hintError
            self.hintBottomSheetDescription = hintBottomSheetDescription
            self.placeholderTextField = placeholderTextField
        }
    }

}
