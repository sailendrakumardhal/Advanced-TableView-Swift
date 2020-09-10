//
//  ExpandTableCell.swift
//  AdvanceTableViewDemo
//
//  Created by Sailendra on 7/28/20.
//  Copyright © 2020 SailendraMac. All rights reserved.
//

import UIKit

class ExpandTableCell: UITableViewCell {
    
    var cellData: CellData! {
        didSet {
            titleLbl.text = cellData.title
            descLbl.text = cellData.desc
            featureImageView.image = cellData.featureImage
        }
    }
    
    fileprivate var featureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 2
        return imageView
    }()
    
    fileprivate var titleLbl: UILabel = {
        let tLbl = UILabel()
        tLbl.translatesAutoresizingMaskIntoConstraints = false
        tLbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tLbl.textColor = .black
        return tLbl
    }()
    
    fileprivate var descLbl: UILabel = {
        let dLbl = UILabel()
        dLbl.translatesAutoresizingMaskIntoConstraints = false
        dLbl.translatesAutoresizingMaskIntoConstraints = false
        dLbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        dLbl.textColor = .black
        dLbl.numberOfLines = 2
        dLbl.lineBreakMode = .byWordWrapping
        return dLbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        backgroundColor = .clear
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    fileprivate var imageHeightClosed: NSLayoutConstraint!
    fileprivate var imageHeightopened: NSLayoutConstraint!
    
    fileprivate func setupConstraints() {
        contentView.addSubview(featureImageView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(descLbl)
        
        featureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        featureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        featureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
//        featureImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        imageHeightopened = featureImageView.heightAnchor.constraint(equalToConstant: 140)
        imageHeightClosed = featureImageView.heightAnchor.constraint(equalToConstant: 20)
        
        titleLbl.topAnchor.constraint(equalTo: featureImageView.bottomAnchor, constant: 8).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        descLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 4).isActive = true
        descLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        descLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        descLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    func animate() {
        self.imageHeightopened.isActive = false
        self.imageHeightClosed.isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.imageHeightopened.isActive = true
            self.imageHeightClosed.isActive = false
            
            UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
                self.contentView.layoutIfNeeded()
            }, completion: { (_) in
                
            })
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
