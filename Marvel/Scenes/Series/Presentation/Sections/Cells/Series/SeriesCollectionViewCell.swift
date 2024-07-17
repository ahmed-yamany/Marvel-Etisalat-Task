//
//  NewsCollectionViewCell.swift
//  Mega Mall
//
//  Created by Ahmed Yamany on 27/10/2023.
//

import UIKit
import Combine

class SeriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var expandedStackViewHeightConstraint: NSLayoutConstraint!
            
    override func awakeFromNib() {
        super.awakeFromNib()
        updateCell()
        nameLabel.text = "Batman"
        ratingLabel.text = "4.1"
        yearLabel.text = "2023"
    }
    
    // MARK: - Update Cell
    private func updateCell() {
        updateThumbnailImage()
        updateNameLabel()
        updateRatingImage()
        updateRatingLabel()
        updateYearLabel()
    }
    
    private func updateThumbnailImage() {
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.layer.borderColor = UIColor.mlPrimary.cgColor
        thumbnailImageView.layer.borderWidth = 1
    }
    
    private func updateNameLabel() {
        nameLabel.font = FontFamily.Poppins.bold.font(size: 22)
        nameLabel.textColor = .mlTextPrimary
    }
    
    private func updateRatingImage() {
        ratingImage.image = UIImage(systemName: "star.fill")
        ratingImage.tintColor = .mlGold
    }
    
    private func updateRatingLabel() {
        ratingLabel.font = FontFamily.Poppins.semiBold.font(size: 12)
        ratingLabel.textColor = .mlTextPrimary
    }
    
    private func updateYearLabel() {
        yearLabel.font = FontFamily.Poppins.bold.font(size: 12)
        yearLabel.textColor = .mlTextPrimary
    }
}
