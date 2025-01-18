//
//  ProductListTableViewCell.swift
//  OneAppDesignSystem
//
//  Created by TTB on 9/3/2566 BE.
//

import UIKit

protocol ProductListTableViewCellInterface {
    var view: UIView { get }
    func setup(viewModel: DSProductListViewModel?, style: ProductListTableViewCellStyle)
}

class ProductListTableViewCell: UITableViewCell, NibLoadable {
    // MARK: - IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var imageAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView!
   
    public var isShowSeparatorLine: Bool = true {
        didSet {
            self.separatorLineView.isHidden = isShowSeparatorLine
        }
    }
    
    public var style: ProductListTableViewCellStyle = .imageAspectRatio(ratio: DSRatio.ratio1x1) {
        didSet {
            updateAppearance()
        }
    }
    
    private var image: DSProductListImageType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setAccessibilityIdentifier(id: String?) {
        self.accessibilityIdentifier = id
    }
}

// MARK: - DSProductListTableViewCellInterface
extension ProductListTableViewCell: ProductListTableViewCellInterface {
    var view: UIView {
        self
    }
    
    func setup(viewModel: DSProductListViewModel?, style: ProductListTableViewCellStyle = .imageAspectRatio(ratio: .ratio1x1)) {
        self.titleLabel?.text = viewModel?.title
        self.descriptionLabel?.text = viewModel?.description
        self.image = viewModel?.image
        self.style = style
    }
}

// MARK: - Private
private extension ProductListTableViewCell {
    func setupUI() {
        self.titleLabel.font = DSFont.h4
        self.titleLabel.textColor = DSColor.componentLightDefault
        
        self.descriptionLabel.font = DSFont.paragraphSmall
        self.descriptionLabel.textColor = DSColor.componentLightDesc
        self.separatorLineView.backgroundColor = DSColor.componentDividerBackgroundSmall
    }
    
    func updateAppearance() {
        switch self.image {
        case .image(let image):
            self.photoImageView.image = image
        case .url(let url, let placeholder):
            self.photoImageView.setImage(with: url, placeHolder: placeholder ?? self.style.placeHolderImage)
        default:
            self.photoImageView.image = self.style.placeHolderImage
        }
        
        self.imageAspectRatioConstraint = self.imageAspectRatioConstraint.setMultiplier(multiplier: self.style.imageAspectRatio)
    }
}
