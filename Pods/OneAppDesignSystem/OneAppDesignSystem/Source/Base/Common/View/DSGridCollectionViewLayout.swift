//
//  DSGridCollectionViewLayout.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/11/2565 BE.
//

import UIKit

private enum Constants {
    static let defaultVerticalCellSpacing: CGFloat = 16
    static let defaultHorizontalCellSpacing: CGFloat = 16
    static let defaultVerticalColumn: Int = 2
    static let defaultHorizontalColumn: Int = 1
    static let defaultSection: Int = 0
    static let defaultContentInset: UIEdgeInsets = .zero
}

public protocol DSGridCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat
}

public class DSGridCollectionViewLayout: UICollectionViewLayout {
    
    public weak var delegate: DSGridCollectionViewLayoutDelegate?
    
    // MARK: - Variant
    public var contentInsets: UIEdgeInsets = Constants.defaultContentInset
    public var verticalCellSpacing: CGFloat = Constants.defaultVerticalCellSpacing
    public var horizontalCellSpacing: CGFloat = Constants.defaultHorizontalCellSpacing
    public var numberOfColumns: Int = Constants.defaultVerticalColumn
    
    public var columnWidth: CGFloat {
        let isSingleColumn = numberOfColumns == 1
        let spacing: CGFloat = isSingleColumn ? .zero : horizontalCellSpacing * CGFloat(numberOfColumns - 1)
        return (contentWidth - spacing) / CGFloat(numberOfColumns)
    }
        
    // MARK: - Private
    private var contentHeight: CGFloat = .zero
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentWidth: CGFloat {
        let width = collectionView?.bounds.width ?? .zero
        let padding = contentInsets.left + contentInsets.right
        return width - padding
    }
    
    public override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    public override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else {
            return
        }
        
        collectionView.contentInset = contentInsets

        var column = 0
        
        let xOffset: [CGFloat] = getOffsetXPosition()
        var yOffset: [CGFloat] = Array(repeating: .zero, count: numberOfColumns)
        
        let matrixHeight = getMatrixHeight()
        
        for item in getRangeOfItems() {
            let indexPath = IndexPath(item: item, section: Constants.defaultSection)
            let row: Int = item / numberOfColumns
            let height = getMaxHeightInMatrix(matrix: matrixHeight, row: row)
            
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height + verticalCellSpacing
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache where attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    public override func invalidateLayout() {
        super.invalidateLayout()
        cache.removeAll()
    }
}

// MARK: - Private
private extension DSGridCollectionViewLayout {
    
    func getMatrixHeight() -> [[CGFloat]] {
        guard let collectionView = collectionView else { return [] }
        
        let numberOfItems = getNumberOfItems()
        let defaultRowSize = numberOfItems / numberOfColumns
        let expectedSize = hasNumerator(major: numberOfItems, divider: numberOfColumns) ? defaultRowSize + 1 : defaultRowSize
        
        var result: [[CGFloat]] = Array(repeating: Array(repeating: .zero, count: numberOfColumns), count: expectedSize)
        for item in getRangeOfItems() {
            let row: Int = item / numberOfColumns
            let column: Int = item % numberOfColumns
            
            let indexPath = IndexPath(item: item, section: Constants.defaultSection)
            let height = delegate?.collectionView(collectionView, heightForCellAtIndexPath: indexPath) ?? .zero
            
            result[row][column] = height
        }
        
        return result
    }
    
    func getOffsetXPosition() -> [CGFloat] {
        Array(Int.zero..<numberOfColumns).map { columnIndex in
            let offset = CGFloat(columnIndex) * columnWidth
            let isFirstColumn = columnIndex == .zero
            return isFirstColumn ? offset : offset + (horizontalCellSpacing * CGFloat(columnIndex))
        }
    }
    
    func getNumberOfItems() -> Int {
        guard let collectionView = collectionView else { return .zero }
        return collectionView.numberOfItems(inSection: Constants.defaultSection)
    }
    
    func getRangeOfItems() -> Range<Int> {
        guard let collectionView = collectionView else {
            fatalError("CollectionView is undefinded")
        }
        
        return Int.zero..<collectionView.numberOfItems(inSection: Constants.defaultSection)
    }
    
    func getMaxHeightInMatrix(matrix: [[CGFloat]], row: Int) -> CGFloat {
        guard let heightInRow = matrix[safe: row] else {
            return .zero
        }
        
        return heightInRow.max() ?? .zero
    }
    
    func hasNumerator(major: Int, divider: Int) -> Bool {
        major % divider != .zero
    }
}
