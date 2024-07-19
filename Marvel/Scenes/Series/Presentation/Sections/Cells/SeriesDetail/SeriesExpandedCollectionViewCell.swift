//
//  SeriesExpandedCollectionViewCell.swift
//  Marvel
//
//  Created by Ahmed Yamany on 17/07/2024.
//

import UIKit

class SeriesExpandedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var startYearTitleLabel: UILabel!
    @IBOutlet weak var endYearTitleLabel: UILabel!
    @IBOutlet weak var startYearLabel: UILabel!
    @IBOutlet weak var endYearLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    private var heightConstraint: NSLayoutConstraint?
    private var activityIndicator = UIActivityIndicatorView(style: .large)

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
        setupViews()
    }
    
    public func show() {
        heightConstraint?.constant = 140
        isHidden = false
    }
    
    public func hide() {
        heightConstraint?.constant = 0
        isHidden = true
    }
    
    public func update(with entity: SeriesDetailEntity?) {
        if let entity {
            removeActivityIndicator()
            contentView.isHidden = false
            updateViews(with: entity)
        } else {
            addActivityIndicator()
            contentView.isHidden = true
        }
    }
    
    private func updateViews(with entity: SeriesDetailEntity) {
        startYearLabel.text = entity.startYear
        endYearLabel.text = entity.endYear
        descriptionLabel.text = entity.description
    }
    
    private func addActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    private func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
    
    private func setupViews() {
        setupYearTitleLabels()
        setupYearLabels()
        setupDescriptionLabel()
    }
    
    private func setupYearTitleLabels() {
        [startYearTitleLabel, endYearTitleLabel].forEach {
            $0.textColor = .mlTextPrimary
            $0.font = FontFamily.Poppins.semiBold.font(size: 16)
            $0.text = ""
        }
        startYearTitleLabel.text = L10n.startYear
        endYearTitleLabel.text = L10n.endYear
    }
    
    private func setupYearLabels() {
        [startYearLabel, endYearLabel].forEach {
            $0.textColor = .mlTextSecondary
            $0.font = FontFamily.Poppins.regular.font(size: 16)
            $0.text = ""
        }
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = FontFamily.Poppins.regular.font(size: 12)
        descriptionLabel.textColor = .mlTextSecondary
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
    }
}
