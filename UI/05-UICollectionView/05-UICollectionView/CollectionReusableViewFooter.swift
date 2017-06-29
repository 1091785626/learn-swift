//
//  CollectionReusableViewFooter.swift
//  05-UICollectionView
//
//  Created by Mr.Z on 2017/6/26.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

import UIKit

let footerIdentifier = "CollectionReusableViewFooter"

class CollectionReusableViewFooter: UICollectionReusableView {
    
    lazy var label: UILabel! = { [unowned self] in
        let lab = UILabel()
        self.addSubview(lab)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.frame = CGRect(x: 10.0, y: 0.0, width: (self.bounds.width - 10.0 * 2), height: heightFooter)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
