//
//  ViewController.swift
//  04-UIScrollView
//
//  Created by Mr.Z on 2017/5/18.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

import UIKit

func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

class ViewController: UIViewController {
    
    var headerLabel:UILabel!
    var footerLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "scrollview的用法"
        // 初始化
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

extension ViewController {
    public func setup() {
        let sv = UIScrollView(frame: self.view.bounds)
        sv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(sv)
        sv.backgroundColor = .white
        var y : CGFloat = 10
        for i in 0 ..< 300 {
            let lab = UILabel()
            lab.text = "这个是 label \(i+1)"
            lab.sizeToFit()
            lab.frame.origin = CGPoint(x: 10,y: y)
            sv.addSubview(lab)
            y += lab.bounds.size.height + 10
        }
        var sz = sv.bounds.size
        sz.height = y
        sv.contentSize = sz
        
        print(sv.contentSize)
        
        delay(2) {
            print(sv.contentSize)
        }
        
        // 其他属性
        sv.isScrollEnabled = true // 可以上下滚动
        sv.scrollsToTop = true // 点击状态栏时，可以滚动回顶端
        sv.bounces = true // 在最顶端或最底端时，仍然可以滚动，且释放后有动画返回效果
        sv.isPagingEnabled = false // 分页显示效果
        sv.showsHorizontalScrollIndicator = true // 显示水平滚动条
        sv.showsVerticalScrollIndicator = true // 显示垂直滚动条
        sv.indicatorStyle = .white // 滑动条的样式
        // 代理
        sv.delegate = self
        
        // 头尾视图
        self.headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        self.view.addSubview(self.headerLabel)
        self.headerLabel.backgroundColor = UIColor.yellow
        self.headerLabel.textColor = UIColor.red
        self.headerLabel.textAlignment = .center
        self.headerLabel.text = "headerLabel"
        self.headerLabel.isHidden = false
        
        
        self.footerLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.height, width:  sv.frame.width, height: 0))
        self.view.addSubview(self.footerLabel)
        self.footerLabel.autoresizingMask = .flexibleTopMargin
        self.footerLabel.backgroundColor = UIColor.yellow
        self.footerLabel.textColor = UIColor.red
        self.footerLabel.textAlignment = .center
        self.footerLabel.text = "footerLabel"
        self.footerLabel.isHidden = false
        
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        print("1 scrollViewWillBeginDragging")
        scrollView.contentInset = .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        print("2 scrollViewDidScroll")
        // 上下拉时滚动时的位移量（向上滚动时，位移是正数；向下拉动时，位移是负数）
        let offsetY = scrollView.contentOffset.y
        print("offsetY = \(offsetY)")
        
        // 最大位移量（注意scrollview的contentsize的高与当前视图控制器的屏幕高度的关系）
        let offsetYMax = scrollView.contentSize.height
        print("offsetYMax = \(offsetYMax)")
        let offsetYTmp = offsetYMax - self.view.bounds.height
        print("offsetYTmp = \(offsetYTmp)")
        
        if offsetY <= 0 {
            // 向下拉
            
            // 重置headerLabel的frame
            var rectHeader = self.headerLabel.frame
            rectHeader.size.height = offsetY <= -40.0 ? 40.0 : offsetY * -1.0
            self.headerLabel.frame = rectHeader
            
            scrollView.contentInset = UIEdgeInsets(top: offsetY * -1.0, left: 0.0, bottom: 0.0, right: 0.0)
        } else if(offsetY > offsetYTmp) {
            // 向上滑 触底
            let offsetYUp = offsetY - offsetYTmp
            let _offsetY = offsetYUp >= 40.0 ? 40.0 : offsetYUp
            // 重置footerLabel的frame
            var rectFooter = self.footerLabel.frame
            rectFooter.origin.y = self.view.bounds.height - _offsetY
            rectFooter.size.height = _offsetY
            self.footerLabel.frame = rectFooter
            
            scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: offsetYUp, right: 0.0)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){
        print("3 scrollViewWillEndDragging")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        print("4 scrollViewDidEndDragging")
        
        let height = scrollView.frame.height
        let offsetY = scrollView.contentOffset.y
        let index = offsetY / height
        print("当前页是：\(index)")
        
        
        // 重置headerLabel的frame
        var rectHeader = self.headerLabel.frame
        rectHeader.size.height = 0
        self.headerLabel.frame = rectHeader
        
        // 重置footerLabel的frame
        var rectFooter = self.footerLabel.frame
        rectFooter.size.height = 0
        self.footerLabel.frame = rectFooter
        
        scrollView.contentInset = .zero
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView){
        print("5 scrollViewWillBeginDecelerating")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        print("6 scrollViewDidEndDecelerating")
    }
}
