//
//  SectionData.swift
//  AdvanceTableViewDemo
//
//  Created by Sailendra on 7/28/20.
//  Copyright © 2020 SailendraMac. All rights reserved.
//

import UIKit

struct SectionData {
    var open: Bool
    var data: [CellData]
}


struct CellData {
    var title: String
    var desc: String
    var featureImage: UIImage
}
