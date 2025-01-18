//
//  PreviewFileContentDelegate.swift
//  OneAppDesignSystem
//
//  Created by TTB on 24/3/2567 BE.
//

import UIKit

protocol PreviewFileContentDelegate: AnyObject {

    func previewFileContent(_ view: PreviewFileContent, contentDidChangedAt index: Int)
    func previewFileContent(_ view: PreviewFileContent, stateDidChanged state: PreviewFileContentState)

    func previewFileContentHasMaximumExceedFailure(_ view: PreviewFileContent)

    func previewFileContent(_ view: PreviewFileContent, didScroll scrollView: UIScrollView)
    func previewFileContent(_ view: PreviewFileContent, didZoom scrollView: UIScrollView)
    func previewFileContent(_ view: PreviewFileContent, didEndScrolling scrollView: UIScrollView)
    func previewFileContent(_ view: PreviewFileContent, didEndDragging scrollView: UIScrollView, willDecelerate decelerate: Bool)
    func previewFileContent(_ view: PreviewFileContent, willBeginZooming scrollView: UIScrollView, with uiView: UIView?)
    func previewFileContent(_ view: PreviewFileContent, didEndZooming scrollView: UIScrollView, with uiView: UIView?, atScale scale: CGFloat)
}

extension PreviewFileContentDelegate {
    func previewFileContent(_ view: PreviewFileContent, contentDidChangedAt index: Int) { }
    func previewFileContent(_ view: PreviewFileContent, stateDidChanged state: PreviewFileContentState) { }

    func previewFileContentHasMaximumExceedFailure(_ view: PreviewFileContent) { }

    func previewFileContent(_ view: PreviewFileContent, didScroll scrollView: UIScrollView) { }
    func previewFileContent(_ view: PreviewFileContent, didZoom scrollView: UIScrollView) { }
    func previewFileContent(_ view: PreviewFileContent, didEndScrolling scrollView: UIScrollView) { }
    func previewFileContent(_ view: PreviewFileContent, didEndDragging scrollView: UIScrollView, willDecelerate decelerate: Bool) { }
    func previewFileContent(_ view: PreviewFileContent, willBeginZooming scrollView: UIScrollView, with uiView: UIView?) { }
    func previewFileContent(_ view: PreviewFileContent, didEndZooming scrollView: UIScrollView, with uiView: UIView?, atScale scale: CGFloat) { }
}
