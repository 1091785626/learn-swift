//
//  ViewController.swift
//  05-UICollectionView
//
//  Created by Mr.Z on 2017/6/26.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

import UIKit

let width = UIScreen.main.bounds.size.width
let widthCell = (width - 10.0 * 3) / 2
let heightHeader: CGFloat = 40.0
let heightFooter: CGFloat = 20.0
let heightCell: CGFloat = 80.0

class ViewController: UIViewController {
    
    
    lazy var cv: UICollectionView! = { [unowned self] in
        // 滚动方向
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)

        
        // 属性设置
        view.autoresizingMask = .flexibleHeight
        view.backgroundColor = UIColor.blue
        view.dataSource = self
        view.delegate = self
        
        return view
        }()
    var dataArr: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "UICollectionView的用法"
        // 初始化
        self.setLocalData()
        self.setup()
    }
    
    override func loadView() {
        super.loadView()
        
        // 视图控制器背景颜色
        self.view.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // xy,计算从内容区域开始计算
        navigationController?.navigationBar.isTranslucent = false
    }


}
// MARK: - 数据
extension ViewController {
    func setLocalData() {
        self.dataArr = NSMutableArray()
        for number in 1...5 {
            let text = String(format: "第 %d 个", arguments: [number])
            
            let model = Model()
            model.text = text
            
            self.dataArr.add(model);
        }
    }
}
// MARK: - 视图
extension ViewController {
    func setup() {
        
        view.addSubview(cv)
 
        // 注册一个cell
        cv!.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        // 注册一个headView
        cv!.register(CollectionReusableViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        // 注册一个footView
        cv!.register(CollectionReusableViewFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier)

    }
}
// MARK:- 代理
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // 返回多少个组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    // 返回HeadView的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: width, height: heightHeader)
    }
    
    // 返回footview的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: width, height: heightFooter)
    }
    
    // 返回自定义HeadView或者FootView，我这里以headview为例
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview:UICollectionReusableView!
        
        if kind == UICollectionElementKindSectionHeader {
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath as IndexPath) as! CollectionReusableViewHeader
            reusableview.backgroundColor = UIColor.green
            
            (reusableview as! CollectionReusableViewHeader).label.text = String(format: "第 %d 个页眉", arguments: [indexPath.section])
        } else if kind == UICollectionElementKindSectionFooter {
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath as IndexPath) as! CollectionReusableViewFooter
            reusableview.backgroundColor = UIColor.brown
            
            (reusableview as! CollectionReusableViewFooter).label.text = String(format: "第 %d 个页脚", arguments: [indexPath.section])
        }
        
        return reusableview
    }
    
    // MARK: - cell视图
    
    // 返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    /**
     注意cell的大小与间距的关系，即cell的相对于父视图的大小受上下左右间距的大小影响，以及每个row显示的cell个数的影响。主要是计算宽度。
     如：每行显示2个，且上下左右间距为10.0，那么cell的大小相对于父视图来计算则是：cell的宽 = (父视图的宽 - 左右间距的大小 * (2 + 1)) / 2；cell的
     */
    // 返回cell的宽高
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSize(width: widthCell, height: heightCell)
    }
    
    // 返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    // 返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        cell.layer.borderWidth = 0.3;
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        let model = self.dataArr.object(at: indexPath.row) as! Model
        let text = model.text
        cell.label!.text = text
        
        return cell
    }
    
    
    // MARK: 点击事件
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let text = String(format: ("你点击了第 %d-%d 个cell"), arguments: [indexPath.section + 1, indexPath.row + 1])
        print(text)
    }
}

