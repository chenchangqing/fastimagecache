//
//  PhotoBrowserCollectionViewCell.swift
//  fastImageDemo
//
//  Created by  green on 15/10/13.
//  Copyright © 2015年 com.fgl. All rights reserved.
//

import UIKit

class PhotoBrowserCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    var photoInfo: PhotoInfo?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        
        imageView.frame = bounds
        addSubview(imageView)
    }
}
