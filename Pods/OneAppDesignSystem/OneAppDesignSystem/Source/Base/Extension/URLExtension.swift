//
//  URLExtension.swift
//  OneAppDesignSystem
//
//  Created by TTB on 7/6/2567 BE.
//

import Foundation
import PDFKit

extension URL {
    var isFileLocked: Bool {
        return PDFDocument(url: self)?.isLocked ?? false
    }

    var isPDF: Bool {
        return PDFDocument(url: self).isNotNull
    }
    
    func toCFData() -> CFData? {
        do {
            // Load the data from the URL
            let data = try Data(contentsOf: self)
            // Convert Swift Data to CFData
            let cfData = data as CFData
            return cfData
        } catch {
            return nil
        }
    }
}
