//
//  PreviewController.swift
//  AdvanceTableViewDemo
//
//  Created by Sailendra on 7/31/20.
//  Copyright © 2020 SailendraMac. All rights reserved.
//

import UIKit

class PreviewController: UIViewController {
    
    var cellData: CellData! {
        didSet {
            featureImageView.image = cellData.featureImage
        }
    }
    
    fileprivate var featureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 2
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        view.addSubview(featureImageView)
                
        featureImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        featureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        featureImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        featureImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
    }
}
