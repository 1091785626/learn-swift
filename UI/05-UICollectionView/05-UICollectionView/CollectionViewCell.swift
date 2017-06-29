//
//  CollectionViewCell.swift
//  05-UICollectionView
//
//  Created by Mr.Z on 2017/6/26.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

import UIKit

let cellIdentifier = "CollectionViewCell"

class CollectionViewCell: UICollectionViewCell {
    
    lazy var label: UILabel! = { [unowned self] in
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.font = UIFont.boldSystemFont(ofSize: 14.0)
        lab.textColor = UIColor.lightGray
        lab.backgroundColor = UIColor.yellow
        self.addSubview(lab)
        return lab
        }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // 初始化各种控件
        label.frame = CGRect(x: 5.0, y: 5.0, width: (widthCell - 5.0 * 2), height: (heightCell - 5.0 * 2))
        
        self.backgroundColor = UIColor.gray
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
