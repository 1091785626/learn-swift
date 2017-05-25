//
//  ViewController.swift
//  03-UIView
//
//  Created by Mr.Z on 2017/5/18.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "view的用法"
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
        
        let view = UIView(frame: CGRect(x: 10.0, y: 10.0, width: 200.0, height: 200.0))
        // 添加到父视图
        self.view.addSubview(view)
        // 背景颜色
        view.backgroundColor = UIColor.red
        // layer层属性设置
        view.layer.cornerRadius = 5.0
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = true
        
        let view01 = UIView(frame: CGRect(x: 10.0, y: 10.0, width: 50.0, height: 50.0))
        view.addSubview(view01)
        view01.backgroundColor = UIColor.yellow
        
        let view02 = UIView(frame: CGRect(x: 20.0, y: 20.0, width: 60.0, height: 60.0))
        view.addSubview(view02)
        view02.backgroundColor = UIColor.blue
        
        let view03 = UIView(frame: CGRect(x: 30.0, y: 30.0, width: 70.0, height: 70.0))
        view.addSubview(view03)
        view03.backgroundColor = UIColor.purple
        
        let view04 = UIView(frame: CGRect(x: 10.0, y: 30.0, width: 70.0, height: 70.0))
        view04.backgroundColor = UIColor.orange
        
        
        
        // 显示在最前面
        view.bringSubview(toFront: view01)
        // 显示在最后面
        view.sendSubview(toBack: view03)
        // 插入指定位置
        view.insertSubview(view04, aboveSubview: view03)
        // 交换位置
        view.exchangeSubview(at: 2, withSubviewAt: 3)
        
        
        // 其他属性设置
        view.isUserInteractionEnabled = true
        view.isHidden = false
        view.alpha = 1.0
        
        // 父视图
        let superView = view.superview
        print(superView!)
        // 子视图数组
        let subViewArray = view.subviews
        print(subViewArray)
    }
}

