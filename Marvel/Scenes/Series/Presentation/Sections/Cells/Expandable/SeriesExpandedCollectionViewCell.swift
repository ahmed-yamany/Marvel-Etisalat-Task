//
//  SeriesExpandedCollectionViewCell.swift
//  Marvel
//
//  Created by Ahmed Yamany on 17/07/2024.
//

import UIKit

class SeriesExpandedCollectionViewCell: UICollectionViewCell {
    private var heightConstraint: NSLayoutConstraint?
    
    public var isExpanded: Bool = false {
        didSet {
            if isExpanded {
                show()
            } else {
                hide()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
    }
    
    public func show() {
        heightConstraint?.constant = 100
//        isHidden = false
    }
    
    public func hide() {
        heightConstraint?.constant = 0
//        isHidden = true
    }
}
