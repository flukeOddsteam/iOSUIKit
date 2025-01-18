//
//  DSCarouselSelection.swift
//  OneAppDesignSystem
//
//  Created by TTB on 14/8/2567 BE.
//

import UIKit

private enum Constants {
    static let labelsTotalHeight: CGFloat = 88.4
    static let thumbnailSize: CGFloat = 56.0
    static let imageLineSpacing: CGFloat = 16.0
    static let thumbnailLineSpacing: CGFloat = 8.0
    static let transitionPoint: CGFloat = 0.05
}

/// Enum DSCarouselSelection type.
public enum DSCarouselSelectionType: Equatable {
    /// slip: aspect ratio 10:16, max height 338
    case slip
    /// credit: aspect ratio 16:10, max height 177.3
    case credit
    /// debit: aspect ratio 10:16, max height 268.2
    case debit
}

public protocol DSCarouselSelectionDelegate: AnyObject {
    func carouselSelection(_ view: DSCarouselSelection, imageViewForItem imageView: UIImageView, at index: Int)
    func carouselSelection(_ view: DSCarouselSelection, imageViewThumbnailForItem imageView: UIImageView, at index: Int)
}

/// For setup DSCarouselViewModel
///
/// Parameter for setup CarouselItem
/// - Parameter image: URL of the main image to be displayed in the carousel.
/// - Parameter title: Title of the carousel item.
/// - Parameter description: Description of the carousel item.
/// - Parameter thumbnail: URL of the thumbnail image to be displayed in the bottom carousel.
/// - Parameter status: Status indicating whether the item is enabled or disabled.
public struct DSCarouselViewModel {
    let title: String
    let description: String?
    var status: Status
    
    public enum Status {
        case enabled
        case disabled(tag: String)
        
        var isEnabled: Bool {
            switch self {
            case .enabled:
                return true
            case .disabled:
                return false
            }
        }
    }
    
    public init(
        title: String,
        description: String? = nil,
        status: Status = .enabled
    ) {
        self.title = title
        self.description = description
        self.status = status
    }
}

/**
 Custom component DSCarouselSelection for Design System
 
    ![image](/DocumentationImages/ds-carousel-selection-slip.png)
    ![image](/DocumentationImages/ds-carousel-selection-credit.png)
    ![image](/DocumentationImages/ds-carousel-selection-debit.png)
 
 **Usage Example:**
 1. Create UIView on .xib file and assign `DSCarouselSelection` Class to the UIView.
 2. Binding constraint.
 3. Connect UIView to `@IBOutlet` in text editor.
 4. Set value to properties in `viewDidLoad()` or where ever you want.
 
 ```
 @IBOutlet weak var carouselSelection: DSCarouselSelection!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      
      let items = [
          CarouselItem(
              image: URL(string: "https://example.com/image1.jpg")!,
              title: "Item 1",
              description: "Description 1",
              thumbnail: URL(string: "https://example.com/thumbnail1.jpg")!
          ),
          CarouselItem(
              image: URL(string: "https://example.com/image2.jpg")!,
              title: "Item 2",
              description: "Description 2",
              thumbnail: URL(string: "https://example.com/thumbnail2.jpg")!,
              status: .disabled(tag: "UNAVAILABLE")
          )
      ]
      
      // Set up the carousel with the items and desired type
      carouselSelection.setup(with: items, type: .slip)
      
      // Optional: Set up a callback for when the page changes
      carouselSelection.onPageChanged = { page in
          print("Current page: \(page)")
      }
  }
 ```
 
 Programmatically change current position:
 
 ```
 // Change to the index 0 without animation
 DispatchQueue.main.async {
     self.carouselSelection.setCurrentPosition(position: 0, isAnimate: false)
 }

 // Change to the index 1 with animation
 DispatchQueue.main.async {
     self.carouselSelection.setCurrentPosition(position: 1, isAnimate: true)
 }
 ```
 **DSCarouselSelection has 3 types:**
 - slip
 - credit
 - debit
 
 */
public final class DSCarouselSelection: UIView {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    /// The type of carousel selection (slip, credit, or debit).
    public var selectionType: DSCarouselSelectionType = .slip {
        didSet { updateAppearance() }
    }
    
    /// The array of CarouselItem objects to be displayed in the carousel.
    public var data: [DSCarouselViewModel] = [] {
        didSet { reloadData() }
    }
    
    /// A closure that is called when the current page of the carousel changes.
    public var onPageChanged: ((Int) -> Void)?
    /// A closure that is called when the current page is enabled or disabled.
    public var onCurrentPageEnabled: ((Int, Bool) -> Void)?
    
    public weak var delegate: DSCarouselSelectionDelegate?
    
    private let imageLayout = ImageCarouselViewLayout()
    private let thumbnailLayout = ThumbnailCarouselViewLayout()
    private let staticIndicatorView = UIView()
    private let inputCheckboxView = UIView()
    
    private var aspectRatio: CGFloat { selectionType.aspectRatio }
    private var maxHeight: CGFloat { selectionType.maxHeight }
    
    private var isSynchronizing = false
    private var isImageDragging = false
    
    private var currentPage: Int = 0 {
        didSet {
            if currentPage != oldValue {
                imageLayout.currentPage = currentPage
                thumbnailLayout.currentPage = currentPage
                onPageChanged?(currentPage)
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateAppearance()
        thumbnailCollectionView.layoutIfNeeded()
        imageCollectionView.layoutIfNeeded()
    }
    
    /// Sets up the carousel with the provided data and selection type.
    /// - Parameters:
    ///   - data: An array of CarouselItem objects to be displayed in the carousel.
    ///   - type: The type of carousel selection (slip, credit, or debit).
    public func setup(with data: [DSCarouselViewModel], type: DSCarouselSelectionType) {
        self.data = data
        self.selectionType = type
    }
    
    /// Sets the current position of the carousel.
    /// - Parameters:
    ///   - position: The index of the item to scroll to.
    ///   - isAnimate: Whether to animate the scrolling.
    ///   - completion: A closure to be executed after the scrolling is complete.
    public func setCurrentPosition(
        position: Int,
        isAnimate: Bool,
        completion: (() -> Void)? = nil
    ) {
        guard position >= 0,
              position < data.count else { return }
        
        imageCollectionView.isScrollEnabled = false
        thumbnailCollectionView.isScrollEnabled = false
        
        thumbnailLayout.currentPage = position
        let thumbnailOffset = thumbnailLayout.updateOffset(thumbnailCollectionView)
        
        thumbnailCollectionView.layoutIfNeeded()
        imageCollectionView.layoutIfNeeded()
        
        if isAnimate {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
                DispatchQueue.main.async {
                    self.thumbnailCollectionView.setContentOffset(CGPoint(x: thumbnailOffset, y: 0), animated: true)
                    self.thumbnailCollectionView.performBatchUpdates {
                        self.thumbnailCollectionView.collectionViewLayout.invalidateLayout()
                    }
                    self.imageCollectionView.performBatchUpdates {
                        self.imageCollectionView.collectionViewLayout.invalidateLayout()
                    }
                }
            }
            
            animator.addCompletion { _ in
                self.thumbnailLayout.previousOffset = thumbnailOffset
                self.currentPage = position
                
                self.imageCollectionView.isScrollEnabled = true
                self.thumbnailCollectionView.isScrollEnabled = true
                
                completion?()
            }
            
            animator.startAnimation()
            
        } else {
            thumbnailCollectionView.setContentOffset(CGPoint(x: thumbnailOffset, y: 0), animated: false)
            
            thumbnailLayout.previousOffset = thumbnailOffset
            currentPage = position
            
            thumbnailCollectionView.performBatchUpdates {
                self.thumbnailCollectionView.collectionViewLayout.invalidateLayout()
            }
            imageCollectionView.performBatchUpdates {
                self.imageCollectionView.collectionViewLayout.invalidateLayout()
            }
            
            imageCollectionView.isScrollEnabled = true
            thumbnailCollectionView.isScrollEnabled = true
            
            completion?()
        }
    }
    
    public func reloadData() {
        imageCollectionView.reloadData()
        thumbnailCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension DSCarouselSelection: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = data[indexPath.item]
        
        if collectionView == imageCollectionView {
            let cell: CarouselSelectionImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            
            let disableTag: String?
            if case let .disabled(tag) = item.status {
                disableTag = tag
            } else {
                disableTag = nil
            }
            
            cell.setup(
                isEnabled: item.status.isEnabled,
                title: item.title,
                description: item.description,
                disableTag: disableTag
            )
            
            delegate?.carouselSelection(
                self,
                imageViewForItem: cell.imageView,
                at: indexPath.item
            )
            
            return cell
        } else {
            let cell: CarouselSelectionThumbnailCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setup(isEnabled: item.status.isEnabled)
            delegate?.carouselSelection(
                self,
                imageViewThumbnailForItem: cell.thumbnailImageView,
                at: indexPath.item
            )
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension DSCarouselSelection: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView == thumbnailCollectionView,
              !imageCollectionView.isDecelerating,
              !imageCollectionView.isDragging,
              indexPath.item != currentPage else { return }
        
        thumbnailCollectionView.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.thumbnailCollectionView.isUserInteractionEnabled = true
        }
        
        setCurrentPosition(position: indexPath.item, isAnimate: true)
    }
}

// MARK: - UIScrollViewDelegate
extension DSCarouselSelection: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isSynchronizing else { return }
        isSynchronizing = true
        
        let position = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if scrollView == imageCollectionView {
            currentPage = imageLayout.currentPage
            synchronizeThumbnailCollectionView()
        } else if scrollView == thumbnailCollectionView {
            if !isImageDragging {
                if position.x < 0 && currentPage < data.count - 1 {
                    setCurrentPosition(position: currentPage + 1, isAnimate: true) {
                        self.isImageDragging = true
                    }
                } else if position.x > 0 && currentPage > 0 {
                    setCurrentPosition(position: currentPage - 1, isAnimate: true) {
                        self.isImageDragging = true
                    }
                }
            }
            synchronizeImageCollectionView()
        }
        
        updateSelectedItemIndicator()
        isSynchronizing = false
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isImageDragging = false
    }
}

// MARK: - Private
private extension DSCarouselSelection {
    func commonInit() {
        setupXib()
        setupUI()
        updateAppearance()
    }
    
    func setupUI() {
        setupCollectionViews()
        setupStaticIndicatorView()
    }
    
    func setupCollectionViews() {
        [imageCollectionView, thumbnailCollectionView].forEach { collectionView in
            collectionView?.dataSource = self
            collectionView?.delegate = self
            collectionView?.showsHorizontalScrollIndicator = false
            collectionView?.showsVerticalScrollIndicator = false
            collectionView?.decelerationRate = .fast
        }
        
        imageCollectionView.register(CarouselSelectionImageCollectionViewCell.self)
        thumbnailCollectionView.register(CarouselSelectionThumbnailCollectionViewCell.self)
        
        imageLayout.minimumLineSpacing = Constants.imageLineSpacing
        thumbnailLayout.minimumLineSpacing = Constants.thumbnailLineSpacing
        
        imageCollectionView.collectionViewLayout = imageLayout
        imageLayout.scrollDirection = .horizontal
        
        thumbnailCollectionView.collectionViewLayout = thumbnailLayout
        thumbnailLayout.scrollDirection = .horizontal
    }
    
    func setupStaticIndicatorView() {
        staticIndicatorView.layer.borderColor = DSColor.componentLightOutlineActive.cgColor
        staticIndicatorView.layer.borderWidth = 2.0
        staticIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        inputCheckboxView.backgroundColor = .clear
        staticIndicatorView.isUserInteractionEnabled = false
        staticIndicatorView.setRadius(radius: .radius8px)
        
        addSubview(staticIndicatorView)
        NSLayoutConstraint.activate([
            staticIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            staticIndicatorView.centerYAnchor.constraint(equalTo: thumbnailCollectionView.centerYAnchor),
            staticIndicatorView.widthAnchor.constraint(equalToConstant: 56),
            staticIndicatorView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        inputCheckboxView.translatesAutoresizingMaskIntoConstraints = false
        inputCheckboxView.backgroundColor = .clear
        inputCheckboxView.isUserInteractionEnabled = false
        addSubview(inputCheckboxView)
        
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = DSColor.componentLightBackgroundActive
        circleView.layer.cornerRadius = 10
        circleView.layer.masksToBounds = true
        
        inputCheckboxView.addSubview(circleView)
        
        NSLayoutConstraint.activate([
            inputCheckboxView.heightAnchor.constraint(equalToConstant: 24),
            inputCheckboxView.widthAnchor.constraint(equalToConstant: 24),
            inputCheckboxView.trailingAnchor.constraint(equalTo: staticIndicatorView.trailingAnchor, constant: 10),
            inputCheckboxView.topAnchor.constraint(equalTo: staticIndicatorView.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: inputCheckboxView.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: inputCheckboxView.centerYAnchor),
            circleView.heightAnchor.constraint(equalToConstant: 20),
            circleView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        let overlayImageView = UIImageView()
        overlayImageView.translatesAutoresizingMaskIntoConstraints = false
        overlayImageView.contentMode = .scaleAspectFit
        inputCheckboxView.addSubview(overlayImageView)
        
        NSLayoutConstraint.activate([
            overlayImageView.leadingAnchor.constraint(equalTo: inputCheckboxView.leadingAnchor),
            overlayImageView.trailingAnchor.constraint(equalTo: inputCheckboxView.trailingAnchor),
            overlayImageView.topAnchor.constraint(equalTo: inputCheckboxView.topAnchor),
            overlayImageView.bottomAnchor.constraint(equalTo: inputCheckboxView.bottomAnchor)
        ])
        
        overlayImageView.image = DSIcons.icon24OutlineCheckSmall.image.withRenderingMode(.alwaysTemplate)
        overlayImageView.tintColor = DSColor.componentLightIconOnDark
    }
    
    func synchronizeThumbnailCollectionView() {
        guard let imageLayout = imageCollectionView.collectionViewLayout as? ImageCarouselViewLayout,
              let thumbnailLayout = thumbnailCollectionView.collectionViewLayout as? ThumbnailCarouselViewLayout else {
            return
        }
        
        let targetThumbnailOffset = (imageLayout.calculateCurrentPage() * thumbnailLayout.itemWidth) - thumbnailLayout.centerOffset
        
        thumbnailCollectionView.contentOffset = CGPoint(x: targetThumbnailOffset, y: 0)
        currentPage = imageLayout.currentPage
    }
    
    func synchronizeImageCollectionView() {
        guard let imageLayout = imageCollectionView.collectionViewLayout as? ImageCarouselViewLayout,
              let thumbnailLayout = thumbnailCollectionView.collectionViewLayout as? ThumbnailCarouselViewLayout else {
            return
        }
        
        let targetImageOffset = (thumbnailLayout.calculateCurrentPage() * imageLayout.itemWidth) - imageLayout.centerOffset
        
        imageCollectionView.contentOffset = CGPoint(x: targetImageOffset, y: 0)
        currentPage = thumbnailLayout.currentPage
    }
    
    func updateAppearance() {
        let adjustedHeight = min(self.imageCollectionView.frame.height, maxHeight + Constants.labelsTotalHeight)
        let adjustedWidth = (adjustedHeight - Constants.labelsTotalHeight) * aspectRatio
        
        imageLayout.itemSize = CGSize(width: adjustedWidth, height: adjustedHeight)
        thumbnailLayout.itemSize = CGSize(width: Constants.thumbnailSize, height: Constants.thumbnailSize)
        imageHeightConstraint.constant = adjustedHeight
        
        imageCollectionView.contentInset = UIEdgeInsets(top: 0, left: imageLayout.centerOffset, bottom: 0, right: imageLayout.centerOffset)
        thumbnailCollectionView.contentInset = UIEdgeInsets(top: 0, left: thumbnailLayout.centerOffset, bottom: 0, right: thumbnailLayout.centerOffset)
    }
    
    func updateSelectedItemIndicator() {
        guard let thumbnailLayout = thumbnailCollectionView.collectionViewLayout as? ThumbnailCarouselViewLayout else {
            return
        }
        
        guard currentPage >= 0 && currentPage < data.count else {
            return
        }
        
        let distanceFromCenter = abs(thumbnailLayout.calculateCurrentPage() - CGFloat(currentPage))
        
        if distanceFromCenter <= Constants.transitionPoint {
            let isEnabled = data[currentPage].status.isEnabled
            
            inputCheckboxView.isHidden = !isEnabled
            
            if isEnabled {
                staticIndicatorView.layer.borderColor = DSColor.componentLightOutlineActive.cgColor
            } else {
                staticIndicatorView.layer.borderColor = DSColor.componentDisableOutline.cgColor
            }
            
            onCurrentPageEnabled?(currentPage, isEnabled)
        }
    }
}
