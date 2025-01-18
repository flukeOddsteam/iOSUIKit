//
//  PreviewFileHeaderSectionDelegate.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/3/2567 BE.
//

import Foundation

protocol PreviewFileHeaderSectionDelegate: AnyObject {
    func previewFileHeaderEditButtonDidTapped(_ view: PreviewFileHeaderSection)
    func previewFileHeaderDeleteButtonDidTapped(_ view: PreviewFileHeaderSection)
}
