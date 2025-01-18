//
//  PreviewFileContentDataSource.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/3/2567 BE.
//

import UIKit

protocol PreviewFileContentDataSource: AnyObject {
    var headerView: UIView { get }
    var userResources: [DSPreviewFileResource] { get set }

    func updateResource(index: Int, modified: (inout DSPreviewFileResource) -> DSPreviewFileResource)
}

// MARK: - Static extension
extension PreviewFileContentDataSource {
    func updateResource(index: Int, modified: (inout DSPreviewFileResource) -> DSPreviewFileResource) {
        guard var resource = userResources[safe: index] else {
            return
        }

        let modifiedResource = modified(&resource)
        userResources[index] = modifiedResource
    }
}
