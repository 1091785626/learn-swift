//
//  ViewController.swift
//  02-UIButton
//
//  Created by Mr.Z on 2017/5/14.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "button的用法"
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
        let button = UIButton(type: .custom)
        
        // 添加到父视图，并设置frame
        self.view.addSubview(button)
        button.frame = CGRect(x: 10, y: 10, width: 200, height: 40)
        // 内边距
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        // button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        
        
        // 背景属性设置
        button.backgroundColor = UIColor.blue
        
        // 按钮图片自适应
        button.imageView?.contentMode = .scaleAspectFit
        
        // button.setBackgroundImage(UIImage(named: "normalImage"), for: .normal)
        // button.setBackgroundImage(UIImage(named: "hightImage"), for: .highlighted)
        
        // 图标设置
        button.setImage(UIImage(named: "normalImage"), for: .normal)
        button.setImage(UIImage(named: "hightImage"), for: .highlighted)
        // 图标内边距
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -10.0, bottom: 0.0, right: 0.0)
        
        
        // 标题设置
        button.setTitle("button", for: .normal)
        button.setTitleColor(UIColor.black, for: .highlighted)
        button.setTitleColor(UIColor.red, for: .highlighted)
        button.setTitleColor(UIColor.red, for: .selected)
        button.setTitleShadowColor(UIColor.green,  for: .normal)
        button.titleLabel?.font = UIFont(name: "GillSans", size: 20.0)
        // 标题内边距
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, -50.0)
        
        button.isSelected = false
        button.isEnabled = true
        button.isUserInteractionEnabled = true
        
        // 响应事件
        button.addTarget(self, action: #selector(onClick(_ :)), for: .touchUpInside)
    }
}

extension ViewController {

    func onClick(_ button: UIButton ) -> Void {
        button.isSelected = !button.isSelected
        if button.isSelected == true {
            print("选中按钮")
            let buttonTitle = button.titleLabel?.text
            print(buttonTitle!)
        } else {
            print("未选中按钮")
        }
    }

}

