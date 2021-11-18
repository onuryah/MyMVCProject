//
//  PhotosCell.swift
//  MyProject
//
//  Created by Ceren Çapar on 16.11.2021.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    @IBOutlet weak var photosImageView: UIImageView!
    @IBOutlet weak var photoNameLabelField: UILabel!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
