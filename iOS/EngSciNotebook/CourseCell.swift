//
//  CourseCell.swift
//  EngSciNotebook
//
//  Created by Morris Chen on 2017-09-10.
//  Copyright © 2017 Morris Chen. All rights reserved.
//

import UIKit

class CourseCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var courseCode: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red:222/255.0, green:225/255.0, blue:227/255.0, alpha:1.0).cgColor
    }
    
}
