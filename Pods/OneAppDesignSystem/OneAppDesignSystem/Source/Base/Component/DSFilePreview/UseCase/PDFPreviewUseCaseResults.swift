//
//  PDFPreviewUseCaseResults.swift
//  OneAppDesignSystem
//
//  Created by TTB on 29/5/2567 BE.
//

import Foundation

enum PDFPreviewUseCaseResults {
    enum TemporaryPersistentStore {
        case success(URL)
        case error
    }

    enum UnlockPassword {
        case success(URL)
        case wrongPassword
        case error
    }

    enum WritePDF {
        case success(URLRequest)
        case error
    }
}
