//
//  DSMessageContentTagView.swift
//  OneAppDesignSystem
//
//  Created by TTB on 28/9/2565 BE.
//

import UIKit

// MARK: Internal Struct
struct DSMessageContentPillViewModel {
    let style: DSPillStyle
    let title: String
}

// MARK: Internal Class
class DSMessageContentPillView: UIView {
    @IBOutlet weak var collectionView: IntrinsicCollectionView!
    
    private var viewModel: [DSMessageContentPillViewModel] = []
    
    // Variable to set accessibility identifier
    private var prefixPillId: String = ""
    private var prefixPillLabelId: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        setupXib()
        setupUI()
    }
    
    func setupUI() {
        collectionView.register(
            UINib(nibName: "DSMessageContentTagViewCell", bundle: .dsBundle),
            forCellWithReuseIdentifier: "DSMessageContentTagViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        let leftAlignedFlowLayout = LeftAlignedFlowLayout()
        leftAlignedFlowLayout.minimumInteritemSpacing = 8
        collectionView.collectionViewLayout = leftAlignedFlowLayout
    }

    func setup(viewModel: [DSMessageContentPillViewModel]) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    func setupAccessibilityIdentifier(prefixPillId: String, prefixPillLabelId: String) {
        self.prefixPillId = prefixPillId
        self.prefixPillLabelId = prefixPillLabelId
    }
}

// MARK: - UICollectionViewDataSource
extension DSMessageContentPillView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: "DSMessageContentTagViewCell",
                        for: indexPath
        ) as? DSMessageContentPillViewCell
        cell?.pillView.setup(style: viewModel[indexPath.row].style, title: viewModel[indexPath.row].title)
        
        // Set Accessibility Identifier
        let row = String(indexPath.row)
        cell?.setAccessibilityIdentifier(id: self.prefixPillId.idConcatenation(row),
                                         labelId: self.prefixPillLabelId.idConcatenation(row))
        
        return cell ?? DSMessageContentPillViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DSMessageContentPillView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = DSFont.allCap
        label.text = viewModel[indexPath.row].title
        label.sizeToFit()
        return CGSize(width: label.frame.width + 16, height: label.frame.height + 8)
    }
}
